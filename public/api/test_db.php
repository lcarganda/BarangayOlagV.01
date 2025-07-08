<?php
// test_db.php - For debugging database connection and specific queries

ini_set('display_errors', 1);
error_reporting(E_ALL);

// Ensure correct path to dbh.inc.php
require_once __DIR__ . '/../../backend/dbh.inc.php'; 

header('Content-Type: application/json');

if (!isset($pdo)) {
    echo json_encode(['status' => 'error', 'message' => 'Database connection was not established in test_db.php.']);
    exit();
}

try {
    // Attempt to fetch data from the 'zone' table, specifically 'zone_name'
    $stmt = $pdo->query("SELECT zone_id, zone_name, description FROM zone LIMIT 1");
    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($result) {
        echo json_encode(['status' => 'success', 'message' => 'Successfully fetched from zone table!', 'data' => $result]);
    } else {
        echo json_encode(['status' => 'success', 'message' => 'Zone table is empty or no rows found.']);
    }

} catch (PDOException $e) {
    error_log("PDO Exception in test_db.php: " . $e->getMessage());
    echo json_encode(['status' => 'error', 'message' => 'Database error in test_db.php: ' . $e->getMessage()]);
} catch (Exception $e) {
    error_log("General Exception in test_db.php: " . $e->getMessage());
    echo json_encode(['status' => 'error', 'message' => 'Server error in test_db.php: ' . $e->getMessage()]);
}
?>
