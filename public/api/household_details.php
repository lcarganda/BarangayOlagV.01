<?php
// PHP_FILE_VERSION_HOUSEHOLD_DETAILS_20250707_01

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

try {
    $householdId = $_GET['id'] ?? null;

    if (!$householdId) {
        respondWithError("Household ID is required.", 400); // This is the error message in question
    }

    // Fetch household main details
    $stmt = $pdo->prepare("
        SELECT
            h.household_id,
            h.address,
            h.has_toilet,
            h.has_electricity,
            h.monthly_household_income,
            h.has_water,
            h.has_internet,
            CONCAT(i.first_name, ' ', i.middle_name, ' ', i.surname) AS household_head_name,
            i.individual_id AS household_head_individual_id,
            z.zone_name,
            wsl.water_source_name,
            cfl.cooking_fuel_name,
            tsl.tenure_status_name,
            isl.income_source_name,
            htl.household_type_name,
            hml.house_material_name
        FROM household h
        LEFT JOIN individual i ON h.household_head_individual_id = i.individual_id
        LEFT JOIN zone z ON h.zone_id = z.zone_id
        LEFT JOIN water_source_lookup wsl ON h.what_water_source_id = wsl.id
        LEFT JOIN cooking_fuel_lookup cfl ON h.main_source_of_cooking_fuel_id = cfl.id
        LEFT JOIN tenure_status_lookup tsl ON h.tenure_status_id = tsl.id
        LEFT JOIN income_source_lookup isl ON h.household_source_of_income_id = isl.id
        LEFT JOIN household_type_lookup htl ON h.type_of_household_id = htl.id
        LEFT JOIN house_material_lookup hml ON h.type_of_house_material_id = hml.id
        WHERE h.household_id = :household_id
    ");
    $stmt->bindParam(':household_id', $householdId, PDO::PARAM_INT);
    $stmt->execute();
    $household = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$household) {
        respondWithError("Household not found.", 404);
    }

    // Fetch household members
    $membersStmt = $pdo->prepare("
        SELECT
            hm.relationship_to_head,
            ind.individual_id,
            CONCAT(ind.first_name, ' ', ind.middle_name, ' ', ind.surname) AS full_name,
            ind.gender,
            ind.birth_date,
            csl.status_name AS civil_status,
            ind.occupation
        FROM household_member hm
        JOIN individual ind ON hm.individual_id = ind.individual_id
        LEFT JOIN civil_status_lookup csl ON ind.civil_status_id = csl.id
        WHERE hm.household_id = :household_id
        ORDER BY FIELD(hm.relationship_to_head, 'Head') DESC, ind.surname ASC, ind.first_name ASC
    ");
    $membersStmt->bindParam(':household_id', $householdId, PDO::PARAM_INT);
    $membersStmt->execute();
    $household['members'] = $membersStmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode(['status' => 'success', 'data' => $household]);

} catch (PDOException $e) {
    error_log("PDO Exception in household_details.php: " . $e->getMessage());
    respondWithError('Database error: ' . $e->getMessage(), 500);
} catch (Exception $e) {
    error_log("General Exception in household_details.php: " . $e->getMessage());
    respondWithError('An unexpected error occurred: ' . $e->getMessage(), 500);
}
?>
