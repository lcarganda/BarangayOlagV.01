<?php
// PHP_FILE_VERSION_INDIVIDUALS_20240703_06 - CONFIRM THIS LINE IS PRESENT AFTER UPDATE

// Set content type to JSON for API responses
header('Content-Type: application/json');

// Include database connection file
require_once '../../backend/dbh.inc.php'; // Adjust path based on your folder structure

// Initialize response array
$response = ['status' => 'error', 'message' => 'Invalid request'];

try {
    // Get request method
    $method = $_SERVER['REQUEST_METHOD'];

    switch ($method) {
        case 'GET':
            $individualId = $_GET['id'] ?? null;
            $page = $_GET['page'] ?? 1;
            $limit = $_GET['limit'] ?? 10; // Default limit per page
            $searchTerm = $_GET['search'] ?? ''; // Get search term

            // New: Get and decode filters
            $filtersJson = $_GET['filters'] ?? '{}';
            $filters = json_decode($filtersJson, true);

            if (json_last_error() !== JSON_ERROR_NONE) {
                http_response_code(400);
                echo json_encode(['status' => 'error', 'message' => 'Invalid filters JSON: ' . json_last_error_msg()]);
                exit();
            }

            error_log("DEBUG: Received filters JSON: " . $filtersJson); // Log received JSON
            error_log("DEBUG: Decoded filters array: " . print_r($filters, true)); // Log decoded array

            $offset = ($page - 1) * $limit;

            // Build WHERE clause for search and filters
            $whereClauses = [];
            $params = [];

            if (!empty($searchTerm)) {
                $searchWildcard = '%' . $searchTerm . '%';
                $whereClauses[] = " (
                    i.first_name LIKE :searchTerm
                    OR i.middle_name LIKE :searchTerm
                    OR i.surname LIKE :searchTerm
                    OR h.address LIKE :searchTerm
                )";
                $params[':searchTerm'] = $searchWildcard;
            }

            // Apply filters
            if (!empty($filters)) {
                // Age Group
                if (!empty($filters['age_group']) && $filters['age_group'] !== 'all') {
                    $currentYear = date('Y');
                    switch ($filters['age_group']) {
                        case '0-17':
                            $whereClauses[] = "(:currentYear - YEAR(i.birth_date)) BETWEEN 0 AND 17";
                            break;
                        case '18-30':
                            $whereClauses[] = "(:currentYear - YEAR(i.birth_date)) BETWEEN 18 AND 30";
                            break;
                        case '31-50':
                            $whereClauses[] = "(:currentYear - YEAR(i.birth_date)) BETWEEN 31 AND 50";
                            break;
                        case '51-64':
                            $whereClauses[] = "(:currentYear - YEAR(i.birth_date)) BETWEEN 51 AND 64";
                            break;
                        case '65+':
                            $whereClauses[] = "(:currentYear - YEAR(i.birth_date)) >= 65";
                            break;
                    }
                    $params[':currentYear'] = $currentYear;
                }

                // Gender - Simplified logic
                if (!empty($filters['gender']) && $filters['gender'] !== 'all') {
                    $whereClauses[] = "i.gender = :gender";
                    $params[':gender'] = $filters['gender'];
                }

                // Boolean filters
                $booleanFilters = [
                    'is_alive' => 'i.is_alive',
                    'is_student' => 'i.is_student',
                    'is_4ps_beneficiary' => 'i.is_4ps_beneficiary',
                    'is_registered_voter' => 'i.is_registered_voter',
                    'is_ofw' => 'i.is_ofw',
                    'is_sss_member' => 'i.is_sss_member',
                    'is_gsis_member' => 'i.is_gsis_member',
                    'is_philhealth_member' => 'i.is_philhealth_member',
                    'has_disability' => 'i.has_disability',
                    'is_solo_parent' => 'i.is_solo_parent'
                ];

                foreach ($booleanFilters as $filterKey => $columnName) {
                    // Only add to where clause if it's explicitly 'true' or 'false', not 'all' or empty
                    if (isset($filters[$filterKey]) && ($filters[$filterKey] === 'true' || $filters[$filterKey] === 'false')) {
                        $whereClauses[] = "$columnName = :$filterKey";
                        // Convert string 'true'/'false' to boolean 1/0 for PDO
                        $params[":$filterKey"] = ($filters[$filterKey] === 'true' ? 1 : 0);
                    }
                }

                // Lookup-based filters (religion, civil_status, blood_type, educational_attainment)
                $lookupFilters = [
                    'religion_id' => 'i.religion_id',
                    'civil_status_id' => 'i.civil_status_id',
                    'blood_type_id' => 'i.blood_type_id',
                    'educational_attainment_id' => 'i.educational_attainment_id'
                ];

                foreach ($lookupFilters as $filterKey => $columnName) {
                    // Only add to where clause if it's not 'all' and not empty
                    if (isset($filters[$filterKey]) && $filters[$filterKey] !== '' && $filters[$filterKey] !== 'all') {
                        $whereClauses[] = "$columnName = :$filterKey";
                        $params[":$filterKey"] = $filters[$filterKey];
                    }
                }

                // Removed text-based filters (working_for, occupation)
            }

            $fullWhereClause = '';
            if (!empty($whereClauses)) {
                $fullWhereClause = ' WHERE ' . implode(' AND ', $whereClauses);
            }

            error_log("DEBUG: Constructed WHERE clause: " . $fullWhereClause); // Log constructed WHERE
            error_log("DEBUG: Final parameters for query: " . print_r($params, true)); // Log final parameters
            error_log("DEBUG: Final WHERE clause: " . implode(' AND ', $whereClauses));
            error_log("DEBUG: Params: " . print_r($params, true));


            if ($individualId) {
                // Fetch a single individual by ID with all lookup details
                $stmt = $pdo->prepare("
                    SELECT
                        i.individual_id,
                        i.surname,
                        i.first_name,
                        i.middle_name,
                        i.gender,
                        i.birth_date,
                        (YEAR(CURDATE()) - YEAR(i.birth_date)) - (RIGHT(CURDATE(), 5) < RIGHT(i.birth_date, 5)) AS age,
                        cs.status_name AS civil_status,
                        bt.blood_type_name AS blood_type,
                        r.religion_name AS religion,
                        ea.attainment_name AS educational_attainment,
                        i.contact_number,
                        i.email,
                        i.salary_income,
                        i.is_solo_parent,
                        i.has_disability,
                        i.is_student,
                        i.school_attending,
                        i.is_scholar,
                        i.is_alive,
                        i.working_for,
                        i.occupation,
                        i.is_registered_voter,
                        i.is_ofw,
                        i.is_sss_member,
                        i.is_gsis_member,
                        i.is_philhealth_member,
                        i.is_4ps_beneficiary,
                        COALESCE(h.address, 'N/A') AS household_address
                    FROM
                        individual i
                    LEFT JOIN
                        civil_status_lookup cs ON i.civil_status_id = cs.id
                    LEFT JOIN
                        blood_type_lookup bt ON i.blood_type_id = bt.id
                    LEFT JOIN
                        religion_lookup r ON i.religion_id = r.id
                    LEFT JOIN
                        educational_attainment_lookup ea ON i.educational_attainment_id = ea.id
                    LEFT JOIN
                        household_member hm ON i.individual_id = hm.individual_id
                    LEFT JOIN
                        household h ON hm.household_id = h.household_id
                    WHERE
                        i.individual_id = :individual_id
                    LIMIT 1
                ");
                $stmt->bindParam(':individual_id', $individualId, PDO::PARAM_INT);
                $stmt->execute();
                $individual = $stmt->fetch(PDO::FETCH_ASSOC);

                if ($individual) {
                    $response = ['status' => 'success', 'data' => $individual];
                } else {
                    $response = ['status' => 'error', 'message' => 'Individual not found.'];
                }
            } else {
                // Fetch all individuals with pagination, search, and filters
                // Count total records for pagination
                // First, get a raw count of individuals to see if the table is empty
                $rawCountStmt = $pdo->prepare("SELECT COUNT(*) FROM individual");
                $rawCountStmt->execute();
                $rawIndividualCount = $rawCountStmt->fetchColumn();
                error_log("DEBUG: Raw count of individuals in 'individual' table: " . $rawIndividualCount);


                $countSql = "
                    SELECT COUNT(DISTINCT i.individual_id)
                    FROM individual i
                    LEFT JOIN household_member hm ON i.individual_id = hm.individual_id
                    LEFT JOIN household h ON hm.household_id = h.household_id
                    " . $fullWhereClause;

                error_log("DEBUG: Count SQL: " . $countSql);
                error_log("DEBUG: Count Params: " . print_r($params, true));

                $countStmt = $pdo->prepare($countSql);
                $countStmt->execute($params);
                $totalRecords = $countStmt->fetchColumn();
                $totalPages = ceil($totalRecords / $limit);

                // Fetch paginated and filtered data
                $sql = "
                    SELECT
                        i.individual_id,
                        i.surname,
                        i.first_name,
                        i.middle_name,
                        i.gender,
                        i.civil_status_id,
                        i.blood_type_id,
                        i.religion_id,
                        i.educational_attainment_id,
                        (YEAR(CURDATE()) - YEAR(i.birth_date)) - (RIGHT(CURDATE(), 5) < RIGHT(i.birth_date, 5)) AS age,
                        COALESCE(h.address, 'N/A') AS household_address
                    FROM
                        individual i
                    LEFT JOIN
                        household_member hm ON i.individual_id = hm.individual_id
                    LEFT JOIN
                        household h ON hm.household_id = h.household_id
                    " . $fullWhereClause . "
                    GROUP BY i.individual_id
                    ORDER BY i.surname ASC, i.first_name ASC
                    LIMIT :limit OFFSET :offset;
                ";

                error_log("DEBUG: Main Data SQL Query: " . $sql);
                error_log("DEBUG: Main Data SQL Params: " . print_r($params, true));

                $stmt = $pdo->prepare($sql);
                // Bind all parameters for the main query
                foreach ($params as $key => $value) {
                    $stmt->bindValue($key, $value);
                }
                $stmt->bindParam(':limit', $limit, PDO::PARAM_INT);
                $stmt->bindParam(':offset', $offset, PDO::PARAM_INT);
                $stmt->execute();
                $individuals = $stmt->fetchAll(PDO::FETCH_ASSOC);

                error_log("DEBUG: Fetched Individuals Data (first 5 rows): " . print_r(array_slice($individuals, 0, 5), true));

                $response = [
                    'status' => 'success',
                    'data' => $individuals,
                    'currentPage' => (int)$page,
                    'totalPages' => (int)$totalPages,
                    'totalRecords' => (int)$totalRecords
                ];
            }
            break;

        case 'POST':
        case 'PUT':
            $input = json_decode(file_get_contents('php://input'), true);
            $individualId = $input['individual_id'] ?? null;

            // Convert boolean fields from JS true/false to PHP boolean (then to TINYINT in DB)
            $is_solo_parent = filter_var($input['is_solo_parent'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $has_disability = filter_var($input['has_disability'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $is_student = filter_var($input['is_student'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $is_scholar = filter_var($input['is_scholar'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $is_alive = filter_var($input['is_alive'] ?? true, FILTER_VALIDATE_BOOLEAN); // Default to true
            $is_registered_voter = filter_var($input['is_registered_voter'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $is_ofw = filter_var($input['is_ofw'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $is_sss_member = filter_var($input['is_sss_member'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $is_gsis_member = filter_var($input['is_gsis_member'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $is_philhealth_member = filter_var($input['is_philhealth_member'] ?? false, FILTER_VALIDATE_BOOLEAN);
            $is_4ps_beneficiary = filter_var($input['is_4ps_beneficiary'] ?? false, FILTER_VALIDATE_BOOLEAN);

            // Handle optional fields that might be empty strings from forms
            $middle_name = !empty($input['middle_name']) ? $input['middle_name'] : null;
            $blood_type_id = !empty($input['blood_type_id']) ? $input['blood_type_id'] : null;
            $religion_id = !empty($input['religion_id']) ? $input['religion_id'] : null;
            $contact_number = !empty($input['contact_number']) ? $input['contact_number'] : null;
            $email = !empty($input['email']) ? $input['email'] : null;
            $salary_income = isset($input['salary_income']) && $input['salary_income'] !== '' ? $input['salary_income'] : null;
            $school_attending = !empty($input['school_attending']) ? $input['school_attending'] : null;
            $educational_attainment_id = !empty($input['educational_attainment_id']) ? $input['educational_attainment_id'] : null;
            $working_for = !empty($input['working_for']) ? $input['working_for'] : null; // Kept for form submission, but not for filters
            $occupation = !empty($input['occupation']) ? $input['occupation'] : null; // Kept for form submission, but not for filters


            if ($individualId) {
                // Update existing individual
                $stmt = $pdo->prepare("
                    UPDATE individual SET
                        surname = :surname,
                        first_name = :first_name,
                        middle_name = :middle_name,
                        gender = :gender,
                        birth_date = :birth_date,
                        civil_status_id = :civil_status_id,
                        blood_type_id = :blood_type_id,
                        religion_id = :religion_id,
                        contact_number = :contact_number,
                        email = :email,
                        salary_income = :salary_income,
                        is_solo_parent = :is_solo_parent,
                        has_disability = :has_disability,
                        is_student = :is_student,
                        school_attending = :school_attending,
                        is_scholar = :is_scholar,
                        is_alive = :is_alive,
                        educational_attainment_id = :educational_attainment_id,
                        working_for = :working_for,
                        occupation = :occupation,
                        is_registered_voter = :is_registered_voter,
                        is_ofw = :is_ofw,
                        is_sss_member = :is_sss_member,
                        is_gsis_member = :is_gsis_member,
                        is_philhealth_member = :is_philhealth_member,
                        is_4ps_beneficiary = :is_4ps_beneficiary
                    WHERE individual_id = :individual_id
                ");
                $stmt->bindParam(':individual_id', $individualId, PDO::PARAM_INT);
            } else {
                // Add new individual
                $stmt = $pdo->prepare("
                    INSERT INTO individual (
                        surname, first_name, middle_name, gender, birth_date, civil_status_id,
                        blood_type_id, religion_id, contact_number, email, salary_income,
                        is_solo_parent, has_disability, is_student, school_attending, is_scholar,
                        is_alive, educational_attainment_id, working_for, occupation,
                        is_registered_voter, is_ofw, is_sss_member, is_gsis_member, is_philhealth_member, is_4ps_beneficiary
                    ) VALUES (
                        :surname, :first_name, :middle_name, :gender, :birth_date, :civil_status_id,
                        :blood_type_id, :religion_id, :contact_number, :email, :salary_income,
                        :is_solo_parent, :has_disability, :is_student, :school_attending, :is_scholar,
                        :is_alive, :educational_attainment_id, :working_for, :occupation,
                        :is_registered_voter, :is_ofw, :is_sss_member, :is_gsis_member, :is_philhealth_member, :is_4ps_beneficiary
                    )
                ");
            }

            // Bind common parameters
            $stmt->bindParam(':surname', $input['surname']);
            $stmt->bindParam(':first_name', $input['first_name']);
            $stmt->bindParam(':middle_name', $middle_name);
            $stmt->bindParam(':gender', $input['gender']);
            $stmt->bindParam(':birth_date', $input['birth_date']);
            $stmt->bindParam(':civil_status_id', $input['civil_status_id'], PDO::PARAM_INT);
            $stmt->bindParam(':blood_type_id', $blood_type_id, PDO::PARAM_INT);
            $stmt->bindParam(':religion_id', $religion_id, PDO::PARAM_INT);
            $stmt->bindParam(':contact_number', $contact_number);
            $stmt->bindParam(':email', $email);
            $stmt->bindParam(':salary_income', $salary_income);
            $stmt->bindParam(':is_solo_parent', $is_solo_parent, PDO::PARAM_BOOL);
            $stmt->bindParam(':has_disability', $has_disability, PDO::PARAM_BOOL);
            $stmt->bindParam(':is_student', $is_student, PDO::PARAM_BOOL);
            $stmt->bindParam(':school_attending', $school_attending);
            $stmt->bindParam(':is_scholar', $is_scholar, PDO::PARAM_BOOL);
            $stmt->bindParam(':is_alive', $is_alive, PDO::PARAM_BOOL);
            $stmt->bindParam(':educational_attainment_id', $educational_attainment_id, PDO::PARAM_INT);
            $stmt->bindParam(':working_for', $working_for); // Still bound for form submission
            $stmt->bindParam(':occupation', $occupation); // Still bound for form submission
            $stmt->bindParam(':is_registered_voter', $is_registered_voter, PDO::PARAM_BOOL);
            $stmt->bindParam(':is_ofw', $is_ofw, PDO::PARAM_BOOL);
            $stmt->bindParam(':is_sss_member', $is_sss_member, PDO::PARAM_BOOL);
            $stmt->bindParam(':is_gsis_member', $is_gsis_member, PDO::PARAM_BOOL);
            $stmt->bindParam(':is_philhealth_member', $is_philhealth_member, PDO::PARAM_BOOL);
            $stmt->bindParam(':is_4ps_beneficiary', $is_4ps_beneficiary, PDO::PARAM_BOOL);


            if ($stmt->execute()) {
                $response = ['status' => 'success', 'message' => 'Individual saved successfully.', 'id' => ($individualId ?: $pdo->lastInsertId())];
            } else {
                error_log("PDO Error: " . print_r($stmt->errorInfo(), true));
                $response = ['status' => 'error', 'message' => 'Failed to save individual: ' . $stmt->errorInfo()[2]];
            }
            break;

        case 'DELETE':
            $input = json_decode(file_get_contents('php://input'), true);
            $individualId = $input['id'] ?? null;

            if ($individualId) {
                // Start transaction
                $pdo->beginTransaction();

                try {
                    // Check if the individual is a household head
                    $stmt = $pdo->prepare("SELECT COUNT(*) FROM household WHERE household_head_individual_id = :individual_id");
                    $stmt->bindParam(':individual_id', $individualId, PDO::PARAM_INT);
                    $stmt->execute();
                    if ($stmt->fetchColumn() > 0) {
                        $pdo->rollBack();
                        echo json_encode(['status' => 'error', 'message' => 'Cannot delete individual: This individual is assigned as a household head. Please reassign the household head first.']);
                        exit();
                    }

                    // Delete from household_member table first
                    $stmt = $pdo->prepare("DELETE FROM household_member WHERE individual_id = :individual_id");
                    $stmt->bindParam(':individual_id', $individualId, PDO::PARAM_INT);
                    $stmt->execute();

                    // Delete the individual record
                    $stmt = $pdo->prepare("DELETE FROM individual WHERE individual_id = :individual_id");
                    $stmt->bindParam(':individual_id', $individualId, PDO::PARAM_INT);
                    $stmt->execute();

                    $pdo->commit();
                    $response = ['status' => 'success', 'message' => 'Individual deleted successfully.'];
                } catch (PDOException $e) {
                    $pdo->rollBack();
                    error_log("PDO Error deleting individual: " . $e->getMessage());
                    $response = ['status' => 'error', 'message' => 'Failed to delete individual: ' . $e->getMessage()];
                }
            } else {
                $response = ['status' => 'error', 'message' => 'Individual ID not provided for deletion.'];
            }
            break;

        default:
            // Method Not Allowed
            http_response_code(405);
            $response = ['status' => 'error', 'message' => 'Method Not Allowed'];
            break;
    }

} catch (PDOException $e) {
    // Catch any PDO exceptions
    http_response_code(500); // Internal Server Error
    error_log("PDO Exception: " . $e->getMessage()); // Log exception
    $response = ['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()];
} catch (Exception $e) {
    // Catch any other exceptions
    http_response_code(500); // Internal Server Error
    error_log("General Exception: " . $e->getMessage()); // Log exception
    $response = ['status' => 'error', 'message' => 'An unexpected error occurred: ' . $e->getMessage()];
}

echo json_encode($response);
?>
