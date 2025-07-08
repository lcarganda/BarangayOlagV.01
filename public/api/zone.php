<?php
// PHP_FILE_VERSION_INDIVIDUALS_20240703_03 - CONFIRM THIS LINE IS PRESENT AFTER UPDATE

// Set content type to JSON for API responses
header('Content-Type: application/json');

// Crucial: Set this to 1 temporarily for debugging. Remember to change back to 0 for production!
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Correct path to dbh.inc.php
require_once '../../backend/dbh.inc.php'; // Adjust path based on your folder structure

// Check if $pdo is available from dbh.inc.php. If connection failed, dbh.inc.php would have exited.
if (!isset($pdo)) {
    respondWithError("Database connection was not established.", 500);
}

$method = $_SERVER['REQUEST_METHOD'];

// For simplicity with fetch API, we'll handle PUT and DELETE via POST with a '_method' field
// This block handles the custom 'method' field sent in the JSON body for PUT/DELETE requests.
if ($method === 'POST' && isset(json_decode(file_get_contents('php://input'), true)['method'])) {
    $method = strtoupper(json_decode(file_get_contents('php://input'), true)['method']);
}

try {
    switch ($method) {
        case 'GET':
            $zoneId = $_GET['id'] ?? null;
            $page = $_GET['page'] ?? 1;
            $limit = $_GET['limit'] ?? 10; // Default limit per page
            $searchTerm = $_GET['search'] ?? ''; // Get search term
            $action = $_GET['action'] ?? null; // For specific actions like getOfficials

            // Handle fetching barangay officials for the dropdown
            if ($action === 'getOfficials') {
                $searchOfficialTerm = $_GET['search'] ?? '';
                $sql = "SELECT individual_id, CONCAT(first_name, ' ', surname) AS full_name 
                        FROM individual 
                        WHERE is_alive = 1 AND (LOWER(first_name) LIKE :search OR LOWER(surname) LIKE :search)
                        ORDER BY full_name LIMIT 10"; // Limit suggestions to 10
                $stmt = $pdo->prepare($sql);
                $stmt->bindValue(':search', '%' . strtolower($searchOfficialTerm) . '%', PDO::PARAM_STR);
                $stmt->execute();
                $officials = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo json_encode(['status' => 'success', 'data' => $officials]);
                exit(); // Exit after responding to the getOfficials request
            }

            // Handle fetching a single zone's details
            if ($zoneId) {
                // Query to fetch zone details, including the assigned official's name and household count
                $sql = "SELECT z.*, 
                               CONCAT(i.first_name, ' ', i.surname) AS assigned_official_name,
                               (SELECT COUNT(household_id) FROM household WHERE zone_id = z.zone_id) AS households_count
                        FROM zone z
                        LEFT JOIN individual i ON z.barangay_official_assigned_individual_id = i.individual_id
                        WHERE z.zone_id = :zone_id";
                $stmt = $pdo->prepare($sql);
                $stmt->bindValue(':zone_id', $zoneId, PDO::PARAM_INT);
                $stmt->execute();
                $zone = $stmt->fetch(PDO::FETCH_ASSOC);

                if ($zone) {
                    // If zone found, proceed to calculate population statistics for that zone
                    // Calculate age based on current date
                    $statsSql = "SELECT 
                                    COUNT(ind.individual_id) AS total_population,
                                    SUM(CASE WHEN ind.gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
                                    SUM(CASE WHEN ind.gender = 'Female' THEN 1 ELSE 0 END) AS female_count,
                                    SUM(CASE WHEN TIMESTAMPDIFF(YEAR, ind.birth_date, CURDATE()) < 18 THEN 1 ELSE 0 END) AS minors_count,
                                    SUM(CASE WHEN TIMESTAMPDIFF(YEAR, ind.birth_date, CURDATE()) >= 60 THEN 1 ELSE 0 END) AS seniors_count,
                                    (SELECT surname FROM individual 
                                     WHERE individual_id IN (SELECT individual_id FROM household_member hm JOIN household h ON hm.household_id = h.household_id WHERE h.zone_id = :zone_id_surname)
                                     GROUP BY surname ORDER BY COUNT(surname) DESC LIMIT 1) AS most_common_surname,
                                    (SELECT COUNT(surname) FROM individual 
                                     WHERE individual_id IN (SELECT individual_id FROM household_member hm JOIN household h ON hm.household_id = h.household_id WHERE h.zone_id = :zone_id_surname_count)
                                     GROUP BY surname ORDER BY COUNT(surname) DESC LIMIT 1) AS most_common_surname_count
                                FROM individual ind
                                JOIN household_member hm ON ind.individual_id = hm.individual_id
                                JOIN household h ON hm.household_id = h.household_id
                                WHERE h.zone_id = :zone_id_stats";
                    $statsStmt = $pdo->prepare($statsSql);
                    $statsStmt->bindValue(':zone_id_stats', $zoneId, PDO::PARAM_INT);
                    $statsStmt->bindValue(':zone_id_surname', $zoneId, PDO::PARAM_INT); // Bind again for subquery
                    $statsStmt->bindValue(':zone_id_surname_count', $zoneId, PDO::PARAM_INT); // Bind again for subquery
                    $statsStmt->execute();
                    $statistics = $statsStmt->fetch(PDO::FETCH_ASSOC);
                    
                    $zone['statistics'] = $statistics; // Add all calculated statistics to the zone data array

                    echo json_encode(['status' => 'success', 'data' => $zone]);
                } else {
                    http_response_code(404); // Not Found
                    echo json_encode(['status' => 'error', 'message' => 'Zone not found.']);
                }
                exit(); // Exit after responding to single zone details
            } else {
                // Fetch all zones with pagination and search (default behavior)
                getZones($pdo, $searchTerm, (int)$page, (int)$limit);
                // getZones function already echoes JSON and exits
            }
            break;

        case 'POST':
            $data = json_decode(file_get_contents('php://input'), true);
            if (json_last_error() !== JSON_ERROR_NONE) {
                respondWithError('Invalid JSON input: ' . json_last_error_msg());
            }

            // Determine if it's an actual POST (add) or a simulated PUT/DELETE based on the 'method' field in the JSON body
            $actualMethod = $data['method'] ?? 'POST';
            unset($data['method']); // Remove the custom method key to avoid issues with SQL insertion/update

            if ($actualMethod === 'PUT') {
                if (empty($data['zone_id'])) {
                    respondWithError('Zone ID is required for update.', 400);
                }
                updateZone($pdo, $data);
            } elseif ($actualMethod === 'DELETE') {
                if (!isset($data['zone_id']) || empty($data['zone_id'])) {
                    respondWithError('Zone ID is required for deletion.', 400);
                }
                deleteZone($pdo, $data['zone_id']);
            } else { // Actual POST for adding a new zone
                // Validate required fields for adding a new zone
                if (empty($data['zone_name'])) { 
                    respondWithError('Zone name is required.', 400);
                }
                addZone($pdo, $data);
            }
            // Functions called here already echo JSON and exit.
            break;

        default:
            // Method Not Allowed for any other HTTP method
            http_response_code(405);
            echo json_encode(['status' => 'error', 'message' => 'Method Not Allowed']);
            exit(); // Ensure exit for default case as well
            break;
    }

} catch (PDOException $e) {
    // Catch any PDO exceptions (database errors)
    http_response_code(500); // Internal Server Error
    error_log("PDO Exception: " . $e->getMessage()); // Log the detailed exception message
    echo json_encode(['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()]);
    exit(); // Exit on error
} catch (Exception $e) {
    // Catch any other general exceptions
    http_response_code(500); // Internal Server Error
    error_log("General Exception: " . $e->getMessage()); // Log the detailed exception message
    echo json_encode(['status' => 'error', 'message' => 'An unexpected error occurred: ' . $e->getMessage()]);
    exit(); // Exit on error
}


/**
 * Responds with a JSON error message and exits.
 * This function is used to send a standardized error response and terminate script execution.
 * @param string $message The error message to be sent in the JSON response.
 * @param int $statusCode The HTTP status code to set for the response (e.g., 400, 404, 500).
 */
function respondWithError($message, $statusCode = 400) {
    http_response_code($statusCode);
    echo json_encode(['status' => 'error', 'message' => $message]);
    exit();
}

/**
 * Fetches zones with pagination and search functionality, including household count and assigned official's name.
 * This function is used for the main table display of zones.
 * @param PDO $pdo The PDO database connection object.
 * @param string $searchTerm Search term for filtering zone names or descriptions.
 * @param int $page Current page number for pagination.
 * @param int $limit Number of items per page.
 */
function getZones(PDO $pdo, $searchTerm, $page, $limit) {
    $offset = ($page - 1) * $limit; // Calculate the offset for pagination
    $searchCondition = '';
    $params = [];

    // Add search condition if a search term is provided
    if (!empty($searchTerm)) {
        $searchCondition = 'WHERE LOWER(z.zone_name) LIKE :searchTerm OR LOWER(z.description) LIKE :searchTerm';
        $params[':searchTerm'] = '%' . strtolower($searchTerm) . '%';
    }

    // Query to get the total count of zones (for pagination metadata)
    $countSql = "SELECT COUNT(*) FROM zone z " . $searchCondition;
    $countStmt = $pdo->prepare($countSql);
    $countStmt->execute($params);
    $totalZones = $countStmt->fetchColumn();

    // Query to get paginated zones data, including household count and assigned official's full name
    $sql = "SELECT z.*, 
                   (SELECT COUNT(h.household_id) FROM household h WHERE h.zone_id = z.zone_id) AS households_count,
                   CONCAT(i.first_name, ' ', i.surname) AS assigned_official_name
            FROM zone z
            LEFT JOIN individual i ON z.barangay_official_assigned_individual_id = i.individual_id
            " . $searchCondition . "
            ORDER BY z.zone_name
            LIMIT :limit OFFSET :offset";
            
    $stmt = $pdo->prepare($sql);
    // Bind parameters for the main query, including search and pagination limits
    foreach ($params as $key => &$val) {
        $stmt->bindValue($key, $val, PDO::PARAM_STR);
    }
    $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
    $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
    $stmt->execute();
    $zones = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Encode and echo the successful response with data and pagination metadata
    echo json_encode(['status' => 'success', 'data' => $zones, 'total' => $totalZones, 'page' => $page, 'limit' => $limit]);
    exit(); // Exit after sending response
}

/**
 * Adds a new zone to the database.
 * @param PDO $pdo The PDO database connection object.
 * @param array $data An associative array containing the zone_name, description, and barangay_official_assigned_individual_id.
 */
function addZone(PDO $pdo, array $data) {
    $sql = "INSERT INTO zone (zone_name, description, barangay_official_assigned_individual_id) VALUES (:zone_name, :description, :barangay_official_assigned_individual_id)";
    $stmt = $pdo->prepare($sql);
    $stmt->bindValue(':zone_name', $data['zone_name'], PDO::PARAM_STR);
    $stmt->bindValue(':description', $data['description'] ?? null, PDO::PARAM_STR); // Use null if description is not provided
    $stmt->bindValue(':barangay_official_assigned_individual_id', $data['barangay_official_assigned_individual_id'], PDO::PARAM_INT);
    
    if ($stmt->execute()) {
        echo json_encode(['status' => 'success', 'message' => 'Zone added successfully!', 'id' => $pdo->lastInsertId()]);
    } else {
        respondWithError('Failed to add zone.', 500);
    }
    exit(); // Exit after sending response
}

/**
 * Updates an existing zone in the database.
 * @param PDO $pdo The PDO database connection object.
 * @param array $data An associative array containing the zone_id, zone_name, description, and barangay_official_assigned_individual_id.
 */
function updateZone(PDO $pdo, array $data) {
    $sql = "UPDATE zone SET zone_name = :zone_name, description = :description, barangay_official_assigned_individual_id = :barangay_official_assigned_individual_id WHERE zone_id = :zone_id";
    $stmt = $pdo->prepare($sql);
    $stmt->bindValue(':zone_name', $data['zone_name'], PDO::PARAM_STR);
    $stmt->bindValue(':description', $data['description'] ?? null, PDO::PARAM_STR); // Use null if description is not provided
    $stmt->bindValue(':barangay_official_assigned_individual_id', $data['barangay_official_assigned_individual_id'], PDO::PARAM_INT);
    $stmt->bindValue(':zone_id', $data['zone_id'], PDO::PARAM_INT);

    if ($stmt->execute()) {
        echo json_encode(['status' => 'success', 'message' => 'Zone updated successfully!']);
    } else {
        respondWithError('Failed to update zone.', 500);
    }
    exit(); // Exit after sending response
}

/**
 * Deletes a zone from the database.
 * Includes a check to prevent deletion if there are associated households.
 * @param PDO $pdo The PDO database connection object.
 * @param int $zoneId The ID of the zone to delete.
 */
function deleteZone(PDO $pdo, $zoneId) {
    // First, check if there are any households associated with this zone
    $checkSql = "SELECT COUNT(*) FROM household WHERE zone_id = :zone_id";
    $checkStmt = $pdo->prepare($checkSql);
    $checkStmt->bindValue(':zone_id', $zoneId, PDO::PARAM_INT);
    $checkStmt->execute();
    if ($checkStmt->fetchColumn() > 0) {
        // If households exist, return an error and prevent deletion
        respondWithError('Cannot delete zone: There are households associated with this zone. Please reassign or delete them first.', 409); // 409 Conflict
        return; // This return is important to stop execution here
    }

    // If no associated households, proceed with deletion
    $sql = "DELETE FROM zone WHERE zone_id = :zone_id";
    $stmt = $pdo->prepare($sql);
    $stmt->bindValue(':zone_id', $zoneId, PDO::PARAM_INT);

    if ($stmt->execute()) {
        echo json_encode(['status' => 'success', 'message' => 'Zone deleted successfully!']);
    } else {
        respondWithError('Failed to delete zone.', 500);
    }
    exit(); // Exit after sending response
}
