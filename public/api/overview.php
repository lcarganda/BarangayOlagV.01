<?php
// Ensure absolutely NO whitespace or characters before this opening <?php tag.
header('Content-Type: application/json');
// Crucial: Set this to 1 temporarily for debugging. Remember to change back to 0 for production!
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Correct path to dbh.inc.php
require_once __DIR__ . '/../../backend/dbh.inc.php'; 

// Check if $pdo is available from dbh.inc.php. If connection failed, dbh.inc.php would have exited.
if (!isset($pdo)) {
    respondWithError("Database connection was not established.", 500);
}

/**
 * Responds with a JSON error message and exits.
 * @param string $message The error message.
 * @param int    $statusCode The HTTP status code.
 */
function respondWithError($message, $statusCode = 400) {
    http_response_code($statusCode);
    echo json_encode(['status' => 'error', 'message' => $message]);
    exit();
}

/**
 * Fetches the zone_id from the zone_name.
 * @param PDO    $pdo The PDO database connection object.
 * @param string $zoneName The name of the zone.
 * @return int|null The zone_id if found, null otherwise.
 */
function getZoneIdFromName($pdo, $zoneName) {
    if (empty($zoneName) || $zoneName === "All Zones") {
        return null;
    }
    try {
        $stmt = $pdo->prepare("SELECT zone_id FROM zone WHERE zone_name = :zone_name LIMIT 1");
        $stmt->bindParam(':zone_name', $zoneName, PDO::PARAM_STR);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result ? (int)$result['zone_id'] : null;
    } catch (PDOException $e) {
        error_log("Database error fetching zone ID for '{$zoneName}': " . $e->getMessage());
        return null; 
    }
}

/**
 * Fetches summary statistics for the dashboard.
 * @param PDO $pdo The PDO database connection object.
 * @param string $zoneJoin Optional JOIN clause for zone filtering.
 * @param string $zoneWhere Optional WHERE clause for zone filtering.
 * @param array $zoneParams Parameters for the zone WHERE clause.
 * @param int|null $zoneId The ID of the selected zone, or null for all zones.
 * @return array Summary statistics.
 */
function getSummaryStatistics(PDO $pdo, $zoneJoin, $zoneWhere, $zoneParams, $zoneId) {
    $summary = [];
    try {
        // Total Residents (Individuals who are alive)
        $sqlResidents = "SELECT COUNT(*) FROM individual i $zoneJoin WHERE i.is_alive = TRUE $zoneWhere";
        $stmtResidents = $pdo->prepare($sqlResidents);
        $stmtResidents->execute($zoneParams);
        $summary['totalResidents'] = (int)$stmtResidents->fetchColumn();

        // Total Households
        $sqlHouseholds = "SELECT COUNT(*) FROM household h $zoneJoin WHERE 1=1 $zoneWhere";
        $stmtHouseholds = $pdo->prepare($sqlHouseholds);
        $stmtHouseholds->execute($zoneParams);
        $summary['totalHouseholds'] = (int)$stmtHouseholds->fetchColumn();

        // Total Zones Covered
        if ($zoneId !== null) {
            $summary['zonesCovered'] = 1;
        } else {
            $stmtZones = $pdo->query("SELECT COUNT(*) FROM zone");
            $summary['zonesCovered'] = (int)$stmtZones->fetchColumn();
        }

        // Total Solo Parents (using the is_solo_parent flag in the individual table)
        $sqlSoloParents = "SELECT COUNT(*) FROM individual i 
                           $zoneJoin 
                           WHERE i.is_solo_parent = TRUE AND i.is_alive = TRUE $zoneWhere";
        $stmtSoloParents = $pdo->prepare($sqlSoloParents);
        $stmtSoloParents->execute($zoneParams);
        $summary['totalSoloParents'] = (int)$stmtSoloParents->fetchColumn();

        // Families with 4Ps Beneficiaries
        $sql4Ps = "SELECT COUNT(DISTINCT h.household_id) FROM household h
                   JOIN individual i ON h.household_head_individual_id = i.individual_id
                   $zoneJoin
                   WHERE i.is_4ps_beneficiary = TRUE AND i.is_alive = TRUE $zoneWhere";
        $stmt4Ps = $pdo->prepare($sql4Ps);
        $stmt4Ps->execute($zoneParams);
        $summary['families4Ps'] = (int)$stmt4Ps->fetchColumn();

        // Families in Poverty (Removed as 'is_in_poverty' column does not exist in household table.
        // Default to 0 as it's no longer calculated.)
        $summary['familiesInPoverty'] = 0;

        // Individuals with Disability
        $sqlPWD = "SELECT COUNT(*) FROM individual i $zoneJoin WHERE i.has_disability = TRUE AND i.is_alive = TRUE $zoneWhere";
        $stmtPWD = $pdo->prepare($sqlPWD);
        $stmtPWD->execute($zoneParams);
        $summary['individualsWithDisability'] = (int)$stmtPWD->fetchColumn();

        // Households with Water
        $sqlWater = "SELECT COUNT(*) FROM household h $zoneJoin WHERE h.has_water = TRUE $zoneWhere";
        $stmtWater = $pdo->prepare($sqlWater);
        $stmtWater->execute($zoneParams);
        $summary['householdsWithWater'] = (int)$stmtWater->fetchColumn();

        // Households with Electricity
        $sqlElectricity = "SELECT COUNT(*) FROM household h $zoneJoin WHERE h.has_electricity = TRUE $zoneWhere";
        $stmtElectricity = $pdo->prepare($sqlElectricity);
        $stmtElectricity->execute($zoneParams);
        $summary['householdsWithElectricity'] = (int)$stmtElectricity->fetchColumn();

        // Households with Internet
        $sqlInternet = "SELECT COUNT(*) FROM household h $zoneJoin WHERE h.has_internet = TRUE $zoneWhere";
        $stmtInternet = $pdo->prepare($sqlInternet);
        $stmtInternet->execute($zoneParams);
        $summary['householdsWithInternet'] = (int)$stmtInternet->fetchColumn();

        // NEW: Total Scholars
        $sqlScholars = "SELECT COUNT(*) FROM individual i $zoneJoin WHERE i.is_scholar = TRUE AND i.is_alive = TRUE $zoneWhere";
        $stmtScholars = $pdo->prepare($sqlScholars);
        $stmtScholars->execute($zoneParams);
        $summary['totalScholars'] = (int)$stmtScholars->fetchColumn();

        // NEW: Total Registered Voters
        $sqlVoters = "SELECT COUNT(*) FROM individual i $zoneJoin WHERE i.is_registered_voter = TRUE AND i.is_alive = TRUE $zoneWhere";
        $stmtVoters = $pdo->prepare($sqlVoters);
        $stmtVoters->execute($zoneParams);
        $summary['totalRegisteredVoters'] = (int)$stmtVoters->fetchColumn();

    } catch (PDOException $e) {
        error_log("PDO Exception in getSummaryStatistics: " . $e->getMessage());
        return [
            'totalResidents' => 0, 'totalHouseholds' => 0, 'zonesCovered' => 0,
            'totalSoloParents' => 0, 'families4Ps' => 0, 'familiesInPoverty' => 0,
            'individualsWithDisability' => 0, 'householdsWithWater' => 0,
            'householdsWithElectricity' => 0, 'householdsWithInternet' => 0,
            'totalScholars' => 0, 'totalRegisteredVoters' => 0 // Initialize new fields
        ];
    }
    return $summary;
}

/**
 * Fetches data for various charts.
 * @param PDO $pdo The PDO database connection object.
 * @param string $zoneJoin Optional JOIN clause for zone filtering.
 * @param string $zoneWhere Optional WHERE clause for zone filtering.
 * @param array $zoneParams Parameters for the zone WHERE clause.
 * @param int|null $zoneId The ID of the selected zone, or null for all zones.
 * @return array Chart data.
 */
function getChartData(PDO $pdo, $zoneJoin, $zoneWhere, $zoneParams, $zoneId) {
    $charts = [];

    try {
        // Age Group Distribution (Individuals)
        $stmtAge = $pdo->prepare("
            SELECT
                SUM(CASE WHEN TIMESTAMPDIFF(YEAR, i.birth_date, CURDATE()) < 18 THEN 1 ELSE 0 END) AS '0-17',
                SUM(CASE WHEN TIMESTAMPDIFF(YEAR, i.birth_date, CURDATE()) BETWEEN 18 AND 59 THEN 1 ELSE 0 END) AS '18-59',
                SUM(CASE WHEN TIMESTAMPDIFF(YEAR, i.birth_date, CURDATE()) >= 60 THEN 1 ELSE 0 END) AS '60+'
            FROM individual i
            $zoneJoin
            WHERE i.is_alive = TRUE $zoneWhere
        ");
        $stmtAge->execute($zoneParams);
        $ageGroups = $stmtAge->fetch(PDO::FETCH_ASSOC);

        $charts['ageGroups'] = [
            ['label' => '0-17', 'value' => (int)$ageGroups['0-17'], 'color' => '#f97316'],
            ['label' => '18-59', 'value' => (int)$ageGroups['18-59'], 'color' => '#22c55e'],
            ['label' => '60+', 'value' => (int)$ageGroups['60+'], 'color' => '#3b82f6']
        ];
        error_log("DEBUG: Age Groups Data: " . json_encode($charts['ageGroups']));

        // Gender Split (Individuals) - Corrected to use 'Male' and 'Female'
        $stmtGender = $pdo->prepare("
            SELECT
                SUM(CASE WHEN i.gender = 'Male' THEN 1 ELSE 0 END) AS male,
                SUM(CASE WHEN i.gender = 'Female' THEN 1 ELSE 0 END) AS female,
                COUNT(*) AS total_individuals_for_gender_check
            FROM individual i
            $zoneJoin
            WHERE i.is_alive = TRUE $zoneWhere
        ");
        $stmtGender->execute($zoneParams);
        $genderSplitRaw = $stmtGender->fetch(PDO::FETCH_ASSOC);
        error_log("DEBUG: Gender Split RAW DB Result (Corrected): " . json_encode($genderSplitRaw)); // Updated DEBUG LOG

        $charts['genderSplit'] = [
            'male' => (int)$genderSplitRaw['male'],
            'female' => (int)$genderSplitRaw['female'],
            'maleColor' => '#2563EB',
            'femaleColor' => '#F97316'
        ];
        error_log("DEBUG: Gender Split Data (Processed for JS - Corrected): " . json_encode($charts['genderSplit'])); // Updated DEBUG LOG

        // Civil Status Distribution (Individuals)
        $stmtCivilStatus = $pdo->prepare("
            SELECT csl.status_name AS label, COUNT(i.individual_id) AS value
            FROM individual i
            JOIN civil_status_lookup csl ON i.civil_status_id = csl.id
            $zoneJoin
            WHERE i.is_alive = TRUE $zoneWhere
            GROUP BY csl.status_name
            ORDER BY COUNT(i.individual_id) DESC
        ");
        $stmtCivilStatus->execute($zoneParams);
        $charts['civilStatus'] = $stmtCivilStatus->fetchAll(PDO::FETCH_ASSOC);
        error_log("DEBUG: Civil Status Raw Data: " . json_encode($charts['civilStatus']));

        // Define colors for civil status chart
        $civilStatusColors = [
            'Single' => '#3b82f6', 
            'Married' => '#16a34a', 
            'Widowed' => '#ef4444', 
            'Divorced' => '#f59e0b', 
            'Separated' => '#8b5cf6', 
            'Annulled' => '#a020f0', // Added color for Annulled
            'N/A' => '#6b7280'
        ];
        // Map colors to the civil status data
        foreach ($charts['civilStatus'] as &$item) {
            $item['color'] = $civilStatusColors[$item['label']] ?? '#6b7280';
        }
        error_log("DEBUG: Civil Status Colored Data: " . json_encode($charts['civilStatus']));


        // Educational Attainment Distribution (Individuals)
        // Modified to only return categories with a count > 0
        $stmtEducationalAttainment = $pdo->prepare("
            SELECT eal.attainment_name AS label, COUNT(i.individual_id) AS value
            FROM individual i
            JOIN educational_attainment_lookup eal ON i.educational_attainment_id = eal.id
            $zoneJoin
            WHERE i.is_alive = TRUE $zoneWhere
            GROUP BY eal.attainment_name
            HAVING COUNT(i.individual_id) > 0
            ORDER BY FIELD(eal.attainment_name, 
                'None', 'Elementary Level', 'Elementary Graduate', 
                'High School Level', 'High School Graduate', 'Vocational', 
                'College Level', 'College Graduate', 'Post-Graduate')
        ");
        $stmtEducationalAttainment->execute($zoneParams);
        $charts['educationalAttainment'] = $stmtEducationalAttainment->fetchAll(PDO::FETCH_ASSOC);
        error_log("DEBUG: Educational Attainment Raw Data: " . json_encode($charts['educationalAttainment']));
        
        // Define colors for educational attainment chart
        $educationalAttainmentColors = [
            'None' => '#ef4444',
            'Elementary Level' => '#f97316',
            'Elementary Graduate' => '#eab308',
            'High School Level' => '#a3e635',
            'High School Graduate' => '#84cc16',
            'Vocational' => '#22c55e',
            'College Level' => '#06b6d4',
            'College Graduate' => '#3b82f6',
            'Post-Graduate' => '#6366f1',
            'N/A' => '#6b7280'
        ];
        // Map colors to the educational attainment data
        foreach ($charts['educationalAttainment'] as &$item) {
            $item['color'] = $educationalAttainmentColors[$item['label']] ?? '#6b7280';
        }
        error_log("DEBUG: Educational Attainment Colored Data: " . json_encode($charts['educationalAttainment']));


        // Main Source of Water (Households)
        $stmtWaterSource = $pdo->prepare("
            SELECT wsl.water_source_name AS label, COUNT(h.household_id) AS value
            FROM household h
            JOIN water_source_lookup wsl ON h.what_water_source_id = wsl.id
            $zoneJoin
            WHERE 1=1 $zoneWhere
            GROUP BY wsl.water_source_name
            ORDER BY COUNT(h.household_id) DESC
        ");
        $stmtWaterSource->execute($zoneParams);
        $waterSourceMap = [];
        foreach ($stmtWaterSource->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $waterSourceMap[$row['label']] = $row['value'];
        }

        // Ensure all expected categories are present, even if count is 0
        $expectedWaterSources = [
            'Piped Water', 'Deep Well', 'Spring', 'Bottled Water', 'Shallow Well', 'Rainwater', 'Other'
        ];
        foreach ($expectedWaterSources as $source) {
            if (!isset($waterSourceMap[$source])) {
                $waterSourceMap[$source] = 0;
            }
        }
        
        // Define colors for water source chart (example colors)
        $waterSourceColors = [
            'Piped Water' => '#22c55e',
            'Deep Well' => '#10b981',
            'Spring' => '#06b6d4',
            'Bottled Water' => '#3b82f6',
            'Shallow Well' => '#6366f1',
            'Rainwater' => '#8b5cf6',
            'Other' => '#ef4444',
            'N/A' => '#6b7280'
        ];
        $charts['waterSource'] = [];
        foreach ($waterSourceMap as $label => $value) {
            $charts['waterSource'][] = [
                'label' => $label, 
                'value' => $value, 
                'color' => $waterSourceColors[$label] ?? '#6b7280'
            ];
        }
        error_log("DEBUG: Water Source Data: " . json_encode($charts['waterSource']));

    } catch (PDOException $e) {
        error_log("PDO Exception in getChartData: " . $e->getMessage());
        return [
            'ageGroups' => [],
            'genderSplit' => ['male' => 0, 'female' => 0, 'maleColor' => '#2563EB', 'femaleColor' => '#F97316'],
            'civilStatus' => [],
            'educationalAttainment' => [],
            'waterSource' => []
        ];
    }
    return $charts;
}

// Main request handling logic
try {
    $zoneName = $_GET['zone'] ?? 'All Zones';
    $zoneId = getZoneIdFromName($pdo, $zoneName);

    $zoneJoinIndividual = '';
    $zoneWhereIndividual = '';
    $zoneParams = [];

    // If a specific zone is selected, add a JOIN and WHERE clause for individual and household tables
    if ($zoneId !== null) {
        // For individual table, join through household_member and then household to get zone_id
        $zoneJoinIndividual = "JOIN household_member hm ON i.individual_id = hm.individual_id 
                               JOIN household h_zone ON hm.household_id = h_zone.household_id";
        $zoneWhereIndividual = "AND h_zone.zone_id = :zone_id";
        $zoneParams[':zone_id'] = $zoneId;
    }

    // Pass filtering parameters to the functions
    $dashboardData = [
        'summary' => getSummaryStatistics($pdo, $zoneJoinIndividual, $zoneWhereIndividual, $zoneParams, $zoneId),
        'charts' => getChartData($pdo, $zoneJoinIndividual, $zoneWhereIndividual, $zoneParams, $zoneId)
    ];

    echo json_encode(['status' => 'success', 'data' => $dashboardData]);
    error_log("DEBUG: Final Dashboard Data Sent: " . json_encode($dashboardData));

} catch (Exception $e) {
    error_log("General Exception in overview.php: " . $e->getMessage());
    respondWithError('An unexpected error occurred: ' . $e->getMessage(), 500);
}
?>
