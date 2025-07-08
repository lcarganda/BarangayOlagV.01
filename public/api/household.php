<?php
header('Content-Type: application/json');
ini_set('display_errors', 1);
error_reporting(E_ALL);

require_once '../../backend/dbh.inc.php';

function respondWithError($message, $statusCode = 400) {
    http_response_code($statusCode);
    echo json_encode(['status' => 'error', 'message' => $message]);
    exit();
}

if (!isset($pdo)) {
    respondWithError("Database connection was not established.", 500);
}

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? null; // For specific actions like getUnassignedIndividuals, getAllIndividuals, getIndividualsForMembers

$sortBy = $_GET['sort_by'] ?? 'head_last_name';
$sortOrder = strtolower($_GET['sort_order'] ?? 'asc') === 'desc' ? 'DESC' : 'ASC';

switch ($sortBy) {
    case 'head_last_name':
        $orderBy = "i.surname $sortOrder";
        break;
    case 'member_count':
        $orderBy = "total_member_count $sortOrder";
        break;
    case 'zone':
        $orderBy = "z.zone_name $sortOrder";
        break;
    case 'income':
        $orderBy = "h.monthly_household_income $sortOrder";
        break;
    default:
        $orderBy = "i.surname $sortOrder";
}

try {
    switch ($method) {
        case 'GET':
            if ($action === 'getUnassignedIndividuals') {
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
            } elseif ($action === 'getIndividualsForMembers') {
                $stmt = $pdo->prepare("
                    SELECT 
                        i.individual_id, 
                        CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname) AS full_name
                    FROM individual i
                    LEFT JOIN household h ON i.individual_id = h.household_head_individual_id
                    WHERE i.is_alive = TRUE AND h.household_head_individual_id IS NULL
                    ORDER BY i.surname, i.first_name
                ");
                $stmt->execute();
                $individuals = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo json_encode(['status' => 'success', 'data' => $individuals]);
                exit();
            }

            $householdId = $_GET['id'] ?? null;
            $offset = isset($_GET['offset']) ? (int)$_GET['offset'] : 0;
            $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 10;
            $searchTerm = $_GET['search_query'] ?? '';
            $filtersJson = $_GET['filters'] ?? '{}'; // New: Get filters JSON string
            $filters = json_decode($filtersJson, true);

            if (json_last_error() !== JSON_ERROR_NONE) {
                respondWithError('Invalid filters JSON input: ' . json_last_error_msg());
            }

            $whereConditions = [];
            $params = [];

            // General Search Term
            if (!empty($searchTerm)) {
                $searchPattern = '%' . strtolower($searchTerm) . '%';
                $searchClauses = [];
                $searchClauses[] = "LOWER(h.address) LIKE :searchTerm";
                $searchClauses[] = "LOWER(z.zone_name) LIKE :searchTerm";
                $searchClauses[] = "LOWER(CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname)) LIKE :searchTerm";
                
                // For income search, handle numeric input
                if (is_numeric($searchTerm)) {
                    $income = (float)$searchTerm;
                    $searchClauses[] = "h.monthly_household_income = :exact_income";
                    $params[':exact_income'] = $income;
                }
                $params[':searchTerm'] = $searchPattern; // Bind general search term

                $whereConditions[] = "(" . implode(' OR ', $searchClauses) . ")";
            }

            // Apply Filters
            if (!empty($filters)) {
                // Monthly Income Filter
                if (isset($filters['min_monthly_income']) && $filters['min_monthly_income'] !== '') {
                    $whereConditions[] = "h.monthly_household_income >= :min_monthly_income";
                    $params[':min_monthly_income'] = (float)$filters['min_monthly_income'];
                }
                if (isset($filters['max_monthly_income']) && $filters['max_monthly_income'] !== '') {
                    $whereConditions[] = "h.monthly_household_income <= :max_monthly_income";
                    $params[':max_monthly_income'] = (float)$filters['max_monthly_income'];
                }

                // Zone Filter
                if (isset($filters['zone_id']) && $filters['zone_id'] !== 'all') {
                    $whereConditions[] = "h.zone_id = :zone_id";
                    $params[':zone_id'] = (int)$filters['zone_id'];
                }

                // Household Type Filter
                if (isset($filters['type_of_household_id']) && $filters['type_of_household_id'] !== 'all') {
                    $whereConditions[] = "h.type_of_household_id = :type_of_household_id";
                    $params[':type_of_household_id'] = (int)$filters['type_of_household_id'];
                }

                // House Material Filter
                if (isset($filters['type_of_house_material_id']) && $filters['type_of_house_material_id'] !== 'all') {
                    $whereConditions[] = "h.type_of_house_material_id = :type_of_house_material_id";
                    $params[':type_of_house_material_id'] = (int)$filters['type_of_house_material_id'];
                }

                // Boolean Filters (has_water, has_electricity, has_toilet, has_internet)
                $booleanFilters = ['has_water', 'has_electricity', 'has_toilet', 'has_internet'];
                foreach ($booleanFilters as $filterKey) {
                    if (isset($filters[$filterKey]) && $filters[$filterKey] !== 'all') {
                        $whereConditions[] = "h.{$filterKey} = :{$filterKey}";
                        $params[":{$filterKey}"] = filter_var($filters[$filterKey], FILTER_VALIDATE_BOOLEAN);
                    }
                }
            }

            $fullWhereClause = !empty($whereConditions) ? " WHERE " . implode(' AND ', $whereConditions) : "";

            $baseJoinClauses = "
                LEFT JOIN individual i ON h.household_head_individual_id = i.individual_id
                LEFT JOIN zone z ON h.zone_id = z.zone_id
                LEFT JOIN income_source_lookup isl ON h.household_source_of_income_id = isl.id
                LEFT JOIN household_type_lookup htl ON h.type_of_household_id = htl.id
                LEFT JOIN house_material_lookup hml ON h.type_of_house_material_id = hml.id
            ";

            if ($householdId) {
                $sql = "
                    SELECT
                        h.*,
                        CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname) AS head_of_household_name,
                        CONCAT(h.address, ', Zone ', z.zone_name) AS full_address,
                        z.zone_name,
                        isl.income_source_name,
                        htl.household_type_name,
                        hml.house_material_name
                    FROM household h
                    {$baseJoinClauses}
                    WHERE h.household_id = :household_id
                    GROUP BY h.household_id;
                ";
                $stmt = $pdo->prepare($sql);
                $stmt->bindParam(':household_id', $householdId, PDO::PARAM_INT);
                $stmt->execute();
                $household = $stmt->fetch(PDO::FETCH_ASSOC);

                if ($household) {
                    $household['has_water'] = isset($household['has_water']) ? (bool)$household['has_water'] : false;
                    $household['has_electricity'] = isset($household['has_electricity']) ? (bool)$household['has_electricity'] : false;
                    $household['has_internet'] = isset($household['has_internet']) ? (bool)$household['has_internet'] : false;
                    $household['has_toilet'] = isset($household['has_toilet']) ? (bool)$household['has_toilet'] : false;

                    // Fetch household members
                    $membersStmt = $pdo->prepare("
                        SELECT 
                            hm.individual_id, 
                            CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname) AS full_name,
                            hm.relationship_to_head
                        FROM household_member hm
                        JOIN individual i ON hm.individual_id = i.individual_id
                        WHERE hm.household_id = :household_id
                        ORDER BY hm.relationship_to_head, i.surname, i.first_name
                    ");
                    $membersStmt->bindParam(':household_id', $householdId, PDO::PARAM_INT);
                    $membersStmt->execute();
                    $household['members'] = $membersStmt->fetchAll(PDO::FETCH_ASSOC);

                    $response = ['status' => 'success', 'data' => $household];
                } else {
                    $response = ['status' => 'error', 'message' => 'Household not found.'];
                }

            } else {
                // Fetch total count with search filter
                $countSql = "
                    SELECT COUNT(DISTINCT h.household_id)
                    FROM household h
                    {$baseJoinClauses}
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
                        h.household_id,
                        CONCAT(h.address, ', Zone ', z.zone_name) AS full_address,
                        CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname) AS head_of_household_name,
                        h.monthly_household_income,
                        h.has_water,
                        h.has_toilet, 
                        h.has_electricity,
                        h.has_internet,
                        (
                            SELECT COUNT(*) FROM household_member hm WHERE hm.household_id = h.household_id
                        ) AS total_member_count
                    FROM household h
                    {$baseJoinClauses}
                    {$fullWhereClause}
                    GROUP BY h.household_id
                    ORDER BY $orderBy
                    LIMIT :limit OFFSET :offset;
                ";
                $stmt = $pdo->prepare($sql);
                foreach ($params as $key => $value) {
                    $stmt->bindValue($key, $value, is_int($value) ? PDO::PARAM_INT : PDO::PARAM_STR);
                }
                $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
                $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
                $stmt->execute();
                $households = $stmt->fetchAll(PDO::FETCH_ASSOC);

                foreach ($households as &$hh) {
                    $hh['has_water'] = isset($hh['has_water']) ? (bool)$hh['has_water'] : false;
                    $hh['has_electricity'] = isset($hh['has_electricity']) ? (bool)$hh['has_electricity'] : false;
                    $hh['has_internet'] = isset($hh['has_internet']) ? (bool)$hh['has_internet'] : false;
                    $hh['has_toilet'] = isset($hh['has_toilet']) ? (bool)$hh['has_toilet'] : false;
                }
                unset($hh);

                $response = [
                    'status' => 'success',
                    'data' => [
                        'households' => $households,
                        'totalRecords' => $totalRecords
                    ]
                ];
            }
            break;

        case 'POST':
            $input = json_decode(file_get_contents('php://input'), true);
            $householdId = $input['household_id'] ?? null;
            $members = $input['members'] ?? []; // Array of {individual_id, relationship_to_head}

            // Convert boolean values
            $has_water = filter_var($input['has_water'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $has_electricity = filter_var($input['has_electricity'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $has_internet = filter_var($input['has_internet'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $has_toilet = filter_var($input['has_toilet'] ?? false, FILTER_VALIDATE_BOOLEAN); 

            $pdo->beginTransaction();
            try {
                if ($householdId) {
                    // Update existing household
                    $sql = "UPDATE household SET
                                address = :address,
                                zone_id = :zone_id,
                                household_head_individual_id = :household_head_individual_id,
                                monthly_household_income = :monthly_household_income,
                                household_source_of_income_id = :household_source_of_income_id,
                                type_of_household_id = :type_of_household_id,
                                type_of_house_material_id = :type_of_house_material_id,
                                has_water = :has_water,
                                has_toilet = :has_toilet, 
                                has_electricity = :has_electricity,
                                has_internet = :has_internet,
                                updated_at = CURRENT_TIMESTAMP
                            WHERE household_id = :household_id";
                    $stmt = $pdo->prepare($sql);
                    $stmt->bindParam(':household_id', $householdId, PDO::PARAM_INT);
                } else {
                    // Add new household
                    $sql = "INSERT INTO household (
                                address, zone_id, household_head_individual_id,
                                monthly_household_income, household_source_of_income_id, type_of_household_id,
                                type_of_house_material_id, has_water, has_toilet, 
                                has_electricity, has_internet
                            ) VALUES (
                                :address, :zone_id, :household_head_individual_id,
                                :monthly_household_income, :household_source_of_income_id, :type_of_household_id,
                                :type_of_house_material_id, :has_water, :has_toilet, 
                                :has_electricity, :has_internet
                            )";
                    $stmt = $pdo->prepare($sql);
                }

                // Bind parameters common to both insert and update
                $stmt->bindParam(':address', $input['address']);
                $stmt->bindParam(':zone_id', $input['zone_id'], PDO::PARAM_INT);
                $stmt->bindParam(':household_head_individual_id', $input['household_head_individual_id'], PDO::PARAM_INT);
                $stmt->bindParam(':monthly_household_income', $input['monthly_household_income'], PDO::PARAM_STR); // Use PARAM_STR for DECIMAL
                $stmt->bindParam(':household_source_of_income_id', $input['household_source_of_income_id'], PDO::PARAM_INT);
                $stmt->bindParam(':type_of_household_id', $input['type_of_household_id'], PDO::PARAM_INT);
                $stmt->bindParam(':type_of_house_material_id', $input['type_of_house_material_id'], PDO::PARAM_INT);
                $stmt->bindParam(':has_water', $has_water, PDO::PARAM_BOOL);
                $stmt->bindParam(':has_toilet', $has_toilet, PDO::PARAM_BOOL); 
                $stmt->bindParam(':has_electricity', $has_electricity, PDO::PARAM_BOOL);
                $stmt->bindParam(':has_internet', $has_internet, PDO::PARAM_BOOL);

                if ($stmt->execute()) {
                    $currentHouseholdId = $householdId ?: $pdo->lastInsertId();

                    // --- Manage Household Members ---
                    // 1. Delete existing members for this household
                    $deleteMembersStmt = $pdo->prepare("DELETE FROM household_member WHERE household_id = :household_id");
                    $deleteMembersStmt->bindParam(':household_id', $currentHouseholdId, PDO::PARAM_INT);
                    $deleteMembersStmt->execute();

                    // 2. Insert new members
                    if (!empty($members)) {
                        $insertMemberStmt = $pdo->prepare("INSERT INTO household_member (household_id, individual_id, relationship_to_head) VALUES (:household_id, :individual_id, :relationship_to_head)");
                        foreach ($members as $member) {
                            $insertMemberStmt->bindParam(':household_id', $currentHouseholdId, PDO::PARAM_INT);
                            $insertMemberStmt->bindParam(':individual_id', $member['individual_id'], PDO::PARAM_INT);
                            $insertMemberStmt->bindParam(':relationship_to_head', $member['relationship_to_head']);
                            $insertMemberStmt->execute();
                        }
                    }
                    // --- End Manage Household Members ---

                    $pdo->commit();
                    $response = ['status' => 'success', 'message' => 'Household saved successfully.', 'id' => $currentHouseholdId];
                } else {
                    $pdo->rollBack();
                    error_log("PDO Error: " . print_r($stmt->errorInfo(), true));
                    $response = ['status' => 'error', 'message' => 'Failed to save household: ' . $stmt->errorInfo()[2]];
                }
            } catch (PDOException $e) {
                $pdo->rollBack();
                error_log("PDO Exception during POST: " . $e->getMessage());
                respondWithError('Database error saving household: ' . $e->getMessage(), 500);
            } catch (Exception $e) {
                $pdo->rollBack();
                error_log("General Exception during POST: " . $e->getMessage());
                respondWithError('An unexpected error occurred during save: ' . $e->getMessage(), 500);
            }
            break;

        case 'DELETE':
            $input = json_decode(file_get_contents('php://input'), true);
            $householdId = $input['household_id'] ?? null;

            if ($householdId) {
                $pdo->beginTransaction();
                try {
                    // Check if there are any household members linked to this household
                    $checkStmt = $pdo->prepare("SELECT COUNT(*) FROM household_member WHERE household_id = :household_id");
                    $checkStmt->bindParam(':household_id', $householdId, PDO::PARAM_INT);
                    $checkStmt->execute();
                    if ($checkStmt->fetchColumn() > 0) {
                        respondWithError('Cannot delete household: There are still individuals assigned to this household. Please reassign them first or delete them from the household.', 409);
                    }

                    // Delete the household record
                    $stmt = $pdo->prepare("DELETE FROM household WHERE household_id = :household_id");
                    $stmt->bindParam(':household_id', $householdId, PDO::PARAM_INT);
                    $stmt->execute();

                    $pdo->commit();
                    if ($stmt->rowCount() > 0) {
                        $response = ['status' => 'success', 'message' => 'Household deleted successfully.'];
                    } else {
                        $response = ['status' => 'error', 'message' => 'Household not found or already deleted.'];
                    }
                } catch (PDOException $e) {
                    $pdo->rollBack();
                    error_log("PDO Error deleting household: " . $e->getMessage());
                    respondWithError('Failed to delete household: ' . $e->getMessage(), 500);
                }
            } else {
                respondWithError('Household ID not provided for deletion.', 400);
            }
            break;

        default:
            http_response_code(405);
            $response = ['status' => 'error', 'message' => 'Method Not Allowed'];
            break;
    }

} catch (Exception $e) {
    error_log("General Exception in households.php: " . $e->getMessage());
    respondWithError('An unexpected error occurred: ' . $e->getMessage(), 500);
}

if (!isset($response)) {
    $response = ['status' => 'error', 'message' => 'No response generated by API.'];
}
echo json_encode($response);
exit;
?>
