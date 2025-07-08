<?php
// PHP_FILE_VERSION_FAMILY_20250707_02

header('Content-Type: application/json');
ini_set('display_errors', 1);
error_reporting(E_ALL);

require_once __DIR__ . '/../../backend/dbh.inc.php';

function respondWithError($message, $statusCode = 400) {
    http_response_code($statusCode);
    echo json_encode(['status' => 'error', 'message' => $message]);
    exit();
}

if (!isset($pdo)) {
    respondWithError("Database connection was not established.", 500);
}

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? null; // For specific actions like getUnassignedIndividuals, getAllIndividuals, getAllZoneNames

try {
    switch ($method) {
        case 'GET':
            if ($action === 'getUnassignedIndividuals') {
                // Fetch individuals who are not yet assigned as a household head in any household
                $stmt = $pdo->prepare("
                    SELECT
                        i.individual_id,
                        CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname) AS full_name
                    FROM individual i
                    LEFT JOIN household h ON i.individual_id = h.household_head_individual_id
                    WHERE h.household_head_individual_id IS NULL AND i.is_alive = TRUE
                    ORDER BY i.surname, i.first_name
                ");
                $stmt->execute();
                $individuals = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo json_encode(['status' => 'success', 'data' => $individuals]);
                exit();
            } elseif ($action === 'getAllIndividuals') {
                // Fetch all individuals (used for edit mode to ensure current head is in dropdown)
                $stmt = $pdo->prepare("
                    SELECT
                        i.individual_id,
                        CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname) AS full_name
                    FROM individual i
                    WHERE i.is_alive = TRUE
                    ORDER BY i.surname, i.first_name
                ");
                $stmt->execute();
                $individuals = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo json_encode(['status' => 'success', 'data' => $individuals]);
                exit();
            } elseif ($action === 'getAllZoneNames') {
                // Fetch all zone names for dropdowns
                $stmt = $pdo->prepare("SELECT zone_id, zone_name FROM zone ORDER BY zone_name");
                $stmt->execute();
                $zones = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo json_encode(['status' => 'success', 'data' => $zones]);
                exit();
            } elseif ($action === 'getAllHouseholdsForAssociation') { // Renamed action
                // Fetch ALL households for association management
                $stmt = $pdo->prepare("
                    SELECT
                        h.household_id,
                        CONCAT(h.address, ' (Head: ', COALESCE(CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname), 'N/A'), ')') AS display_name,
                        h.address,
                        COALESCE(CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname), 'N/A') AS head_of_household_name
                    FROM household h
                    LEFT JOIN individual i ON h.household_head_individual_id = i.individual_id
                    ORDER BY h.address ASC
                ");
                $stmt->execute();
                $households = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo json_encode(['status' => 'success', 'data' => $households]);
                exit();
            }


            $familyId = $_GET['id'] ?? null;
            $offset = isset($_GET['offset']) ? (int)$_GET['offset'] : 0;
            $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 10;
            $searchTerm = $_GET['search_query'] ?? '';

            $whereConditions = [];
            $params = [];

            // Search Term for family_name (main_family_surname)
            if (!empty($searchTerm)) {
                $searchPattern = '%' . strtolower($searchTerm) . '%';
                $whereConditions[] = "(LOWER(f.main_family_surname) LIKE :searchTerm)";
                $params[':searchTerm'] = $searchPattern;
            }

            $fullWhereClause = !empty($whereConditions) ? " WHERE " . implode(' AND ', $whereConditions) : "";

            if ($familyId) {
                // Fetch a single family by ID with all details
                // Note: family_head_name and zone_name are derived from the *first* associated household
                $sql = "
                    SELECT
                        f.family_id,
                        f.main_family_surname AS family_name, -- Alias for UI consistency
                        f.description,
                        (SELECT COUNT(*) FROM family_household fh WHERE fh.family_id = f.family_id) AS total_households,
                        (
                            SELECT COUNT(DISTINCT hm.individual_id)
                            FROM family_household fh_inner
                            JOIN household hh_inner ON fh_inner.household_id = hh_inner.household_id
                            JOIN household_member hm ON hh_inner.household_id = hm.household_id
                            WHERE fh_inner.family_id = f.family_id
                        ) AS total_members,
                        (
                            SELECT CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname)
                            FROM family_household fh_head
                            JOIN household hh_head ON fh_head.household_id = hh_head.household_id
                            JOIN individual i ON hh_head.household_head_individual_id = i.individual_id
                            WHERE fh_head.family_id = f.family_id
                            ORDER BY hh_head.household_id ASC -- Get head from the first household
                            LIMIT 1
                        ) AS family_head_name,
                        (
                            SELECT z.zone_name
                            FROM family_household fh_zone
                            JOIN household hh_zone ON fh_zone.household_id = hh_zone.household_id
                            JOIN zone z ON hh_zone.zone_id = z.zone_id
                            WHERE fh_zone.family_id = f.family_id
                            ORDER BY hh_zone.household_id ASC -- Get zone from the first household
                            LIMIT 1
                        ) AS zone_name,
                        (
                            SELECT hh_head.household_head_individual_id
                            FROM family_household fh_head
                            JOIN household hh_head ON fh_head.household_id = hh_head.household_id
                            WHERE fh_head.family_id = f.family_id
                            ORDER BY hh_head.household_id ASC -- Get head ID from the first household
                            LIMIT 1
                        ) AS family_head_individual_id, -- For populating edit form dropdown
                        (
                            SELECT hh_zone.zone_id
                            FROM family_household fh_zone
                            JOIN household hh_zone ON fh_zone.household_id = hh_zone.household_id
                            WHERE fh_zone.family_id = f.family_id
                            ORDER BY hh_zone.household_id ASC -- Get zone ID from the first household
                            LIMIT 1
                        ) AS zone_id -- For populating edit form dropdown
                    FROM family f
                    WHERE f.family_id = :family_id;
                ";
                $stmt = $pdo->prepare($sql);
                $stmt->bindParam(':family_id', $familyId, PDO::PARAM_INT);
                $stmt->execute();
                $family = $stmt->fetch(PDO::FETCH_ASSOC);

                if ($family) {
                    // Fetch associated households for the view modal
                    $householdsStmt = $pdo->prepare("
                        SELECT
                            h.household_id,
                            h.address,
                            CONCAT(i_hh.first_name, ' ', i_hh.middle_name, ' ', i_hh.surname) AS household_head_name,
                            (SELECT COUNT(*) FROM household_member hm WHERE hm.household_id = h.household_id) AS total_member_count
                        FROM household h
                        JOIN family_household fh ON h.household_id = fh.household_id
                        LEFT JOIN individual i_hh ON h.household_head_individual_id = i_hh.individual_id
                        WHERE fh.family_id = :family_id
                        ORDER BY h.address ASC;
                    ");
                    $householdsStmt->bindParam(':family_id', $familyId, PDO::PARAM_INT);
                    $householdsStmt->execute();
                    $family['households'] = $householdsStmt->fetchAll(PDO::FETCH_ASSOC);

                    // Fetch currently associated household IDs for the edit modal
                    $associatedHouseholdsStmt = $pdo->prepare("
                        SELECT household_id FROM family_household WHERE family_id = :family_id
                    ");
                    $associatedHouseholdsStmt->bindParam(':family_id', $familyId, PDO::PARAM_INT);
                    $associatedHouseholdsStmt->execute();
                    $family['associated_household_ids'] = array_column($associatedHouseholdsStmt->fetchAll(PDO::FETCH_ASSOC), 'household_id');


                    echo json_encode(['status' => 'success', 'data' => $family]);
                } else {
                    respondWithError('Family not found.', 404);
                }

            } else {
                // Fetch total count with search filter
                $countSql = "
                    SELECT COUNT(f.family_id)
                    FROM family f
                    {$fullWhereClause};
                ";
                $countStmt = $pdo->prepare($countSql);
                foreach ($params as $key => $value) {
                    $countStmt->bindValue($key, $value, is_int($value) ? PDO::PARAM_INT : PDO::PARAM_STR);
                }
                $countStmt->execute();
                $totalRecords = $countStmt->fetchColumn();

                // Fetch paginated data with search filter
                $sql = "
                    SELECT
                        f.family_id,
                        f.main_family_surname AS family_name, -- Alias for UI consistency
                        (SELECT COUNT(*) FROM family_household fh WHERE fh.family_id = f.family_id) AS total_households,
                        (
                            SELECT COUNT(DISTINCT hm.individual_id)
                            FROM family_household fh_inner
                            JOIN household hh_inner ON fh_inner.household_id = hh_inner.household_id
                            JOIN household_member hm ON hh_inner.household_id = hm.household_id
                            WHERE fh_inner.family_id = f.family_id
                        ) AS total_members,
                        (
                            SELECT CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname)
                            FROM family_household fh_head
                            JOIN household hh_head ON fh_head.household_id = hh_head.household_id
                            JOIN individual i ON hh_head.household_head_individual_id = i.individual_id
                            WHERE fh_head.family_id = f.family_id
                            ORDER BY hh_head.household_id ASC -- Get head from the first household
                            LIMIT 1
                        ) AS family_head_name,
                        (
                            SELECT z.zone_name
                            FROM family_household fh_zone
                            JOIN household hh_zone ON fh_zone.household_id = hh_zone.household_id
                            JOIN zone z ON hh_zone.zone_id = z.zone_id
                            WHERE fh_zone.family_id = f.family_id
                            ORDER BY hh_zone.household_id ASC -- Get zone from the first household
                            LIMIT 1
                        ) AS zone_name
                    FROM family f
                    {$fullWhereClause}
                    GROUP BY f.family_id
                    ORDER BY f.main_family_surname ASC
                    LIMIT :limit OFFSET :offset;
                ";
                $stmt = $pdo->prepare($sql);
                foreach ($params as $key => $value) {
                    $stmt->bindValue($key, $value, is_int($value) ? PDO::PARAM_INT : PDO::PARAM_STR);
                }
                $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
                $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
                $stmt->execute();
                $families = $stmt->fetchAll(PDO::FETCH_ASSOC);

                echo json_encode([
                    'status' => 'success',
                    'data' => [
                        'families' => $families,
                        'totalRecords' => $totalRecords
                    ]
                ]);
            }
            break;

        case 'POST': // Handles both add and update
            $input = json_decode(file_get_contents('php://input'), true);
            $familyId = $input['family_id'] ?? null;
            $associatedHouseholds = $input['associated_households'] ?? []; // Array of household_ids

            // Validate required fields for family table
            if (empty($input['family_name'])) {
                respondWithError('Family Name (Surname) is required.', 400);
            }

            $pdo->beginTransaction();
            try {
                if ($familyId) {
                    // Update existing family
                    $sql = "UPDATE family SET
                                main_family_surname = :main_family_surname,
                                updated_at = CURRENT_TIMESTAMP
                            WHERE family_id = :family_id";
                    $stmt = $pdo->prepare($sql);
                    $stmt->bindParam(':family_id', $familyId, PDO::PARAM_INT);
                } else {
                    // Add new family
                    $sql = "INSERT INTO family (
                                main_family_surname
                            ) VALUES (
                                :main_family_surname
                            )";
                    $stmt = $pdo->prepare($sql);
                }

                // Bind common parameters
                $stmt->bindParam(':main_family_surname', $input['family_name']); // Map JS family_name to DB main_family_surname

                if ($stmt->execute()) {
                    $currentFamilyId = $familyId ?: $pdo->lastInsertId();

                    // --- Manage Family-Household Associations ---
                    // 1. Delete existing associations for this family
                    $deleteAssociationsStmt = $pdo->prepare("DELETE FROM family_household WHERE family_id = :family_id");
                    $deleteAssociationsStmt->bindParam(':family_id', $currentFamilyId, PDO::PARAM_INT);
                    $deleteAssociationsStmt->execute();

                    // 2. Insert new associations
                    if (!empty($associatedHouseholds)) {
                        $insertAssociationStmt = $pdo->prepare("INSERT INTO family_household (family_id, household_id) VALUES (:family_id, :household_id)");
                        foreach ($associatedHouseholds as $household_id) {
                            $insertAssociationStmt->bindParam(':family_id', $currentFamilyId, PDO::PARAM_INT);
                            $insertAssociationStmt->bindParam(':household_id', $household_id, PDO::PARAM_INT);
                            $insertAssociationStmt->execute();
                        }
                    }
                    // --- End Manage Family-Household Associations ---


                    $pdo->commit();
                    echo json_encode(['status' => 'success', 'message' => 'Family saved successfully.', 'id' => $currentFamilyId]);
                } else {
                    $pdo->rollBack();
                    error_log("PDO Error: " . print_r($stmt->errorInfo(), true));
                    respondWithError('Failed to save family: ' . $stmt->errorInfo()[2]);
                }
            } catch (PDOException $e) {
                $pdo->rollBack();
                error_log("PDO Exception during POST: " . $e->getMessage());
                respondWithError('Database error saving family: ' . $e->getMessage(), 500);
            } catch (Exception $e) {
                $pdo->rollBack();
                error_log("General Exception during POST: " . $e->getMessage());
                respondWithError('An unexpected error occurred during save: ' . $e->getMessage(), 500);
            }
            break;

        case 'DELETE':
            $input = json_decode(file_get_contents('php://input'), true);
            $familyId = $input['family_id'] ?? null;

            if ($familyId) {
                $pdo->beginTransaction();
                try {
                    // Check if there are any households linked to this family
                    $checkStmt = $pdo->prepare("SELECT COUNT(*) FROM family_household WHERE family_id = :family_id");
                    $checkStmt->bindParam(':family_id', $familyId, PDO::PARAM_INT);
                    $checkStmt->execute();
                    if ($checkStmt->fetchColumn() > 0) {
                        respondWithError('Cannot delete family: There are still households assigned to this family. Please reassign or delete them first.', 409);
                    }

                    // Delete the family record
                    $stmt = $pdo->prepare("DELETE FROM family WHERE family_id = :family_id");
                    $stmt->bindParam(':family_id', $familyId, PDO::PARAM_INT);
                    $stmt->execute();

                    $pdo->commit();
                    if ($stmt->rowCount() > 0) {
                        echo json_encode(['status' => 'success', 'message' => 'Family deleted successfully.']);
                    } else {
                        respondWithError('Family not found or already deleted.', 404);
                    }
                } catch (PDOException $e) {
                    $pdo->rollBack();
                    error_log("PDO Error deleting family: " . $e->getMessage());
                    respondWithError('Failed to delete family: ' . $e->getMessage(), 500);
                }
            } else {
                respondWithError('Family ID not provided for deletion.', 400);
            }
            break;

        default:
            http_response_code(405);
            echo json_encode(['status' => 'error', 'message' => 'Method Not Allowed']);
            break;
    }

} catch (Exception $e) {
    error_log("General Exception in family.php: " . $e->getMessage());
    respondWithError('An unexpected error occurred: ' . $e->getMessage(), 500);
}
?>
