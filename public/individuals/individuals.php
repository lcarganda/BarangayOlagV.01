<?php
session_start();
if (!isset($_SESSION['username']) || !isset($_SESSION['role'])) {
    header("Location: /olagpeq/index.php");
    exit;
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Santa Cruz - Individuals</title>

    <!-- Favicon/Logo in tab -->
    <link rel="icon" href="../../backend/logotab.png" type="image/jpeg"> 

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="individuals.css">

</head>
<body class="bg-gray-100 font-sans antialiased flex h-screen overflow-hidden">
    <!-- Sidebar -->
    <aside id="mainSidebar" class="w-64 bg-primary-dark-green text-text-light flex flex-col rounded-r-xl shadow-lg
    fixed inset-y-0 left-0 transform -translate-x-full lg:translate-x-0 transition-transform duration-300 ease-in-out
    lg:relative lg:flex lg:flex-col lg:rounded-r-xl lg:shadow-lg z-50">
        <div class="p-6 flex items-center justify-center border-b border-gray-700">
            <img src="../../backend/logo.jpg" id="logo" class="h-12 w-12 rounded-full object-cover mr-3">
            <div>
                <h1 class="text-xl font-bold">Olag Pequiño</h1>
                <p class="text-xs text-gray-300">Barangay Profiling</p>
            </div>
        </div>
        <nav class="flex-1 px-4 py-6 space-y-2 overflow-y-auto">
            <a href="../overview/overview.php" class="flex items-center px-4 py-2 rounded-lg hover:bg-secondary-green transition-colors duration-200">
                <i class="fas fa-chart-line mr-3"></i> Overview
            </a>
            <a href="individuals.php" class="flex items-center px-4 py-2 rounded-lg bg-secondary-green text-text-light">
                <i class="fas fa-user-friends mr-3"></i> Individuals
            </a>
            <a href="../households/households.php" class="flex items-center px-4 py-2 rounded-lg hover:bg-secondary-green transition-colors duration-200">
                <i class="fas fa-home mr-3"></i> Households
            </a>
            <a href="../families/families.php" class="flex items-center px-4 py-2 rounded-lg hover:bg-secondary-green transition-colors duration-200">
                <i class="fas fa-users mr-3"></i> Families
            </a>
            <a href="../zones/zones.php" class="flex items-center px-4 py-2 rounded-lg hover:bg-secondary-green transition-colors duration-200">
                <i class="fas fa-map-marker-alt mr-3"></i> Zones
            </a>
        </nav>
        <div class="p-6 text-center text-gray-400 text-xs border-t border-gray-700">
            © 2024 Barangay Olag Pequiño
        </div>
    </aside>

    <!-- Main Content Area -->
    <main class="flex-1 flex flex-col bg-gray-100 overflow-hidden md:pt-0">
        <!-- Header -->
        <header class="bg-white shadow-sm p-4 flex items-center gap-2 z-10 relative">
            <!-- Hamburger button (visible on mobile only) -->
            <button id="mobileMenuButton" class="lg:hidden mr-2 p-2 rounded-md bg-primary-dark-green text-text-light shadow-lg">
                <i class="fas fa-bars text-xl"></i>
            </button>
            <!-- Centered header text -->
            <h2 class="text-xl font-semibold text-gray-800 text-center flex-1 md:text-2xl md:text-left m-0">
                Individuals Management
            </h2>
            <!-- Filter Button -->
            <button id="openFilterModalBtn" class="bg-blue-500 text-white py-2 px-4 rounded-xl shadow-md hover:bg-blue-600 transition-colors duration-200 text-base md:text-lg font-semibold flex items-center">
                <i class="fas fa-filter mr-2"></i>
                <span class="hidden sm:inline">Filters</span>
            </button>
            <!-- Add New Button -->
            <button id="addNewIndividualBtn" class="bg-primary-dark-green text-text-light py-2 px-4 rounded-xl shadow-md hover:bg-green-800 transition-colors duration-200 text-base md:text-lg font-semibold flex items-center">
                <i class="fas fa-plus-circle mr-2"></i>
                <span class="hidden sm:inline">Add New Individual</span>
            </button>
            <!-- Logout Button -->
            <a href="/olagpeq/logout.php"
                class="flex items-center gap-2 bg-red-500 hover:bg-red-600 text-white font-semibold px-4 py-2 rounded-xl shadow-md transition-colors duration-200 text-base md:text-lg">
                <i class="fas fa-sign-out-alt"></i>
                <span class="hidden sm:inline">Logout</span>
            </a>
        </header>
        <!-- Search Bar (below header, full width) -->
        <section class="p-4">
            <div class="relative">
                <input type="text" id="individualSearch" placeholder="Search individuals..." class="pl-10 pr-4 py-2 rounded-lg border border-gray-300 shadow-sm w-full focus:ring-secondary-green focus:border-secondary-green text-base">
            </div>
        </section>
        <!-- Individuals Table Section -->
        <section class="p-6 flex-1 overflow-y-auto custom-scrollbar">
            <div class="bg-white p-6 rounded-2xl shadow-lg flex-1 flex flex-col">
                <h3 class="text-xl font-semibold mb-4 text-text-dark">Individual List</h3>
                <!-- Responsive Table Container -->
                <div class="overflow-x-auto w-full">
                  <table class="min-w-full divide-y divide-gray-200 text-sm md:text-base">
                        <!-- Example table header -->
                        <thead>
                          <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Age</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Gender</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Civil Status</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Household Address</th>
                            <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                          </tr>
                        </thead>
                        <tbody id="individualsTableBody" class="bg-white divide-y divide-gray-200">
                            <!-- Data will be dynamically loaded here by JavaScript -->
                        </tbody>
                    </table>
                </div>
                <div id="noResults" class="hidden text-center py-8 text-gray-500 text-lg">
                    No individuals found.
                </div>
                <!-- Pagination Controls -->
                <div class="flex justify-between items-center mt-6">
                    <button id="prevPageBtn" class="bg-gray-200 text-gray-700 py-2 px-4 rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-300 transition-colors">Previous</button>
                    <span id="paginationInfo" class="text-gray-600 text-sm">Page 1 of 1</span>
                    <button id="nextPageBtn" class="bg-gray-200 text-gray-700 py-2 px-4 rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-300 transition-colors">Next</button>
                </div>
            </div>
        </section>
    </main>

    <!-- Add/Edit Individual Modal -->
    <div id="individualModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-40">
        <div class="bg-white p-8 rounded-2xl shadow-xl max-w-3xl w-full mx-4 my-8 overflow-y-auto max-h-[90vh]">
            <h2 id="modalTitle" class="text-2xl font-bold mb-6 text-text-dark">Add New Individual</h2>
            <form id="individualForm" class="grid grid-cols-1 md:grid-cols-2 gap-x-6 gap-y-4">
                <input type="hidden" id="individualId">
                
                <!-- Basic Information Section -->
                <div class="md:col-span-2 details-section-heading">Basic Information</div>
                <div>
                    <label for="surname" class="block text-sm font-medium text-gray-700 mb-1">Surname *</label>
                    <input type="text" id="surname" name="surname" required
                           class="form-input">
                </div>
                <div>
                    <label for="firstName" class="block text-sm font-medium text-gray-700 mb-1">First Name *</label>
                    <input type="text" id="firstName" name="firstName" required
                           class="form-input">
                </div>
                <div>
                    <label for="middleName" class="block text-sm font-medium text-gray-700 mb-1">Middle Name</label>
                    <input type="text" id="middleName" name="middleName"
                           class="form-input">
                </div>
                <div>
                    <label for="gender" class="block text-sm font-medium text-gray-700 mb-1">Gender *</label>
                    <select id="gender" name="gender" required
                            class="form-input">
                        <!-- Options populated by JS -->
                    </select>
                </div>
                <div>
                    <label for="birthDate" class="block text-sm font-medium text-gray-700 mb-1">Birth Date *</label>
                    <input type="date" id="birthDate" name="birthDate" required
                           class="form-input">
                </div>
                <div>
                    <label for="civilStatus" class="block text-sm font-medium text-gray-700 mb-1">Civil Status *</label>
                    <select id="civilStatus" name="civilStatus" required
                            class="form-input">
                        <!-- Options populated by JS -->
                    </select>
                </div>
                <div>
                    <label for="bloodType" class="block text-sm font-medium text-gray-700 mb-1">Blood Type</label>
                    <select id="bloodType" name="bloodType"
                            class="form-input">
                        <!-- Options populated by JS -->
                    </select>
                </div>
                <div>
                    <label for="religion" class="block text-sm font-medium text-gray-700 mb-1">Religion</label>
                    <select id="religion" name="religion"
                            class="form-input">
                        <!-- Options populated by JS -->
                    </select>
                </div>
                <div>
                    <label for="contactNumber" class="block text-sm font-medium text-gray-700 mb-1">Contact Number</label>
                    <input type="text" id="contactNumber" name="contactNumber"
                           class="form-input">
                </div>
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                    <input type="email" id="email" name="email"
                           class="form-input">
                </div>
                
                <!-- Status Information Section -->
                <div class="md:col-span-2 details-section-heading">Status Information</div>
                <div>
                    <label for="salaryIncome" class="block text-sm font-medium text-gray-700 mb-1">Salary/Income</label>
                    <input type="number" id="salaryIncome" name="salaryIncome" step="0.01"
                           class="form-input">
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="isSoloParent" name="isSoloParent"
                           class="form-checkbox">
                    <label for="isSoloParent" class="ml-2 block text-sm font-medium text-gray-700">Is Solo Parent?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="hasDisability" name="hasDisability"
                           class="form-checkbox">
                    <label for="hasDisability" class="ml-2 block text-sm font-medium text-gray-700">Has Disability?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="isStudent" name="isStudent"
                           class="form-checkbox">
                    <label for="isStudent" class="ml-2 block text-sm font-medium text-gray-700">Is Student?</label>
                </div>
                <div id="studentFields" class="md:col-span-2 grid grid-cols-1 md:grid-cols-2 gap-x-6 gap-y-4 hidden">
                    <div>
                        <label for="schoolAttending" class="block text-sm font-medium text-gray-700 mb-1">School Attending</label>
                        <input type="text" id="schoolAttending" name="schoolAttending"
                               class="form-input">
                    </div>
                    <div class="flex items-center">
                        <input type="checkbox" id="isScholar" name="isScholar"
                               class="form-checkbox">
                        <label for="isScholar" class="ml-2 block text-sm font-medium text-gray-700">Is Scholar?</label>
                    </div>
                </div>
                <div>
                    <label for="educationalAttainment" class="block text-sm font-medium text-gray-700 mb-1">Educational Attainment</label>
                    <select id="educationalAttainment" name="educationalAttainment"
                            class="form-input">
                        <!-- Options populated by JS -->
                    </select>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="isAlive" name="isAlive" checked
                           class="form-checkbox">
                    <label for="isAlive" class="ml-2 block text-sm font-medium text-gray-700">Is Alive?</label>
                </div>

                <!-- Additional Information Section -->
                <div class="md:col-span-2 details-section-heading">Additional Information</div>
                <div class="flex items-center">
                    <input type="checkbox" id="isRegisteredVoter" name="isRegisteredVoter"
                           class="form-checkbox">
                    <label for="isRegisteredVoter" class="ml-2 block text-sm font-medium text-gray-700">Is Registered Voter?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="isOfw" name="isOfw"
                           class="form-checkbox">
                    <label for="isOfw" class="ml-2 block text-sm font-medium text-gray-700">Is OFW?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="isSssMember" name="isSssMember"
                           class="form-checkbox">
                    <label for="isSssMember" class="ml-2 block text-sm font-medium text-gray-700">Is SSS Member?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="isGsisMember" name="isGsisMember"
                           class="form-checkbox">
                    <label for="isGsisMember" class="ml-2 block text-sm font-medium text-gray-700">Is GSIS Member?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="isPhilhealthMember" name="isPhilhealthMember"
                           class="form-checkbox">
                    <label for="isPhilhealthMember" class="ml-2 block text-sm font-medium text-gray-700">Is PhilHealth Member?</label>
                </div>
                <div>
                    <label for="workingFor" class="block text-sm font-medium text-gray-700 mb-1">Working For</label>
                    <input type="text" id="workingFor" name="workingFor"
                           class="form-input">
                </div>
                <div>
                    <label for="occupation" class="block text-sm font-medium text-gray-700 mb-1">Occupation</label>
                    <input type="text" id="occupation" name="occupation"
                           class="form-input">
                </div>
                 <div class="flex items-center">
                    <input type="checkbox" id="is4psBeneficiary" name="is4psBeneficiary"
                           class="form-checkbox">
                    <label for="is4psBeneficiary" class="ml-2 block text-sm font-medium text-gray-700">Is 4Ps Beneficiary?</label>
                </div>

                <div class="md:col-span-2 flex justify-end space-x-3 mt-6">
                    <button type="button" id="cancelIndividualBtn" class="bg-gray-300 text-gray-800 py-2 px-6 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-lg font-semibold">Cancel</button>
                    <button type="submit" id="saveIndividualBtn" class="bg-primary-dark-green text-text-light py-2 px-6 rounded-xl shadow-md hover:bg-green-800 transition-colors duration-200 text-lg font-semibold">Save Individual</button>
                </div>
            </form>
        </div>
    </div>

    <!-- View Individual Details Modal -->
    <div id="viewIndividualModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50">
        <div class="bg-white p-8 rounded-2xl shadow-xl max-w-2xl w-full mx-4 my-8 overflow-y-auto max-h-[90vh]">
            <h2 class="text-2xl font-bold mb-6 text-text-dark">Individual Details</h2>
            <div id="individualDetailsContent">
                <!-- Details will be loaded here by JavaScript -->
            </div>
            <div class="flex justify-end mt-8">
                <button type="button" id="closeViewIndividualBtn" class="bg-gray-300 text-gray-800 py-2 px-6 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-lg font-semibold">Close</button>
            </div>
        </div>
    </div>

    <!-- Filter Modal -->
    <div id="filterModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-40">
        <div class="bg-white p-8 rounded-2xl shadow-xl max-w-xl w-full mx-4 my-8 overflow-y-auto max-h-[90vh]">
            <h2 class="text-2xl font-bold mb-6 text-text-dark">Filter Individuals</h2>
            <form id="filterForm" class="grid grid-cols-1 md:grid-cols-2 gap-x-6 gap-y-4">
                <!-- Age Group -->
                <div>
                    <label for="filterAgeGroup" class="block text-sm font-medium text-gray-700 mb-1">Age Group</label>
                    <select id="filterAgeGroup" name="filterAgeGroup" class="form-input">
                        <option value="all">All Age Groups</option>
                        <option value="0-17">0-17 (Minors)</option>
                        <option value="18-30">18-30 (Young Adults)</option>
                        <option value="31-50">31-50 (Adults)</option>
                        <option value="51-64">51-64 (Middle-Aged)</option>
                        <option value="65+">65+ (Seniors)</option>
                    </select>
                </div>

                <!-- Gender -->
                <div>
                    <label for="filterGender" class="block text-sm font-medium text-gray-700 mb-1">Gender</label>
                    <select id="filterGender" name="filterGender" class="form-input">
                        <!-- Options populated by JS -->
                    </select>
                </div>

                <!-- Civil Status -->
                <div>
                    <label for="filterCivilStatus" class="block text-sm font-medium text-gray-700 mb-1">Civil Status</label>
                    <select id="filterCivilStatus" name="filterCivilStatus" class="form-input">
                        <!-- Options populated by JS -->
                    </select>
                </div>

                <!-- Blood Type -->
                <div>
                    <label for="filterBloodType" class="block text-sm font-medium text-gray-700 mb-1">Blood Type</label>
                    <select id="filterBloodType" name="filterBloodType" class="form-input">
                        <!-- Options populated by JS -->
                    </select>
                </div>

                <!-- Religion -->
                <div>
                    <label for="filterReligion" class="block text-sm font-medium text-gray-700 mb-1">Religion</label>
                    <select id="filterReligion" name="filterReligion" class="form-input">
                        <!-- Options populated by JS -->
                    </select>
                </div>

                <!-- Educational Attainment -->
                <div>
                    <label for="filterEducationalAttainment" class="block text-sm font-medium text-gray-700 mb-1">Educational Attainment</label>
                    <select id="filterEducationalAttainment" name="filterEducationalAttainment" class="form-input">
                        <!-- Options populated by JS -->
                    </select>
                </div>
                
                <!-- Boolean Filters -->
                <div class="md:col-span-2 details-section-heading">Boolean Filters</div>
                <div class="flex items-center">
                    <input type="checkbox" id="filterIsAlive" name="filterIsAlive" value="true" class="form-checkbox">
                    <label for="filterIsAlive" class="ml-2 block text-sm font-medium text-gray-700">Is Alive?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="filterIsStudent" name="filterIsStudent" value="true" class="form-checkbox">
                    <label for="filterIsStudent" class="ml-2 block text-sm font-medium text-gray-700">Is Student?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="filterIs4ps" name="filterIs4ps" value="true" class="form-checkbox">
                    <label for="filterIs4ps" class="ml-2 block text-sm font-medium text-gray-700">Is 4Ps Beneficiary?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="filterIsRegisteredVoter" name="filterIsRegisteredVoter" value="true" class="form-checkbox">
                    <label for="filterIsRegisteredVoter" class="ml-2 block text-sm font-medium text-gray-700">Is Registered Voter?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="filterIsOfw" name="filterIsOfw" value="true" class="form-checkbox">
                    <label for="filterIsOfw" class="ml-2 block text-sm font-medium text-gray-700">Is OFW?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="filterIsSssMember" name="filterIsSssMember" value="true" class="form-checkbox">
                    <label for="filterIsSssMember" class="ml-2 block text-sm font-medium text-gray-700">Is SSS Member?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="filterIsGsisMember" name="filterIsGsisMember" value="true" class="form-checkbox">
                    <label for="filterIsGsisMember" class="ml-2 block text-sm font-medium text-gray-700">Is GSIS Member?</label>
                </div>
                <div class="flex items-center">
                    <input type="checkbox" id="filterPhilhealthMember" name="filterPhilhealthMember" value="true" class="form-checkbox">
                    <label for="filterPhilhealthMember" class="ml-2 block text-sm font-medium text-gray-700">Is PhilHealth Member?</label>
                </div>

                <div>
                    <label for="filterItemsPerPage" class="block text-sm font-medium text-gray-700 mb-1">Items Per Page</label>
                    <select id="filterItemsPerPage" name="filterItemsPerPage" class="form-input">
                        <option value="10">10</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                        <option value="500">500</option>
                        <option value="1000">1000</option>
                    </select>
                </div>

                <div class="md:col-span-2 flex justify-end space-x-3 mt-6">
                    <button type="button" id="clearFiltersBtn" class="bg-gray-300 text-gray-800 py-2 px-6 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-lg font-semibold">Clear Filters</button>
                    <button type="submit" id="applyFiltersBtn" class="bg-primary-dark-green text-text-light py-2 px-6 rounded-xl shadow-md hover:bg-green-800 transition-colors duration-200 text-lg font-semibold">Apply Filters</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Custom Confirmation/Alert Modal (replaces window.confirm/alert) -->
    <div id="customModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-[100]">
        <div class="bg-white p-6 rounded-lg shadow-xl max-w-md w-full mx-4 max-h-[80vh] overflow-y-auto">
            <h3 id="customModalTitle" class="text-xl font-bold text-gray-800 mb-4"></h3>
            <p id="customModalMessage" class="text-gray-700 mb-6"></p>
            <div class="flex justify-end space-x-3">
                <button id="customModalCancel" class="bg-gray-300 text-gray-800 py-2 px-4 rounded-md shadow-sm hover:bg-gray-400 transition-colors duration-200 text-sm font-semibold hidden">Cancel</button>
                <button id="customModalConfirm" class="bg-primary-dark-green text-text-light py-2 px-4 rounded-md shadow-sm hover:bg-secondary-green transition-colors duration-200 text-sm font-semibold">Okay</button>
            </div>
        </div>
    </div>


    <div id="mobileMenuOverlay" class="fixed inset-0 bg-black bg-opacity-40 z-40 hidden lg:hidden"></div>

    <script>

var userRole = "<?php echo $_SESSION['role']; ?>";


        document.addEventListener('DOMContentLoaded', function() {
    // Get user role from PHP session (make sure your page is .php and session_start() is at the top)
    var userRole = "<?php echo $_SESSION['role'] ?? ''; ?>";
    if (userRole === 'user') {
        // Hide all add buttons by ID
        ['addNewHouseholdBtn', 'addNewIndividualBtn', 'addNewFamilyBtn', 'addNewZoneBtn'].forEach(function(id) {
            var btn = document.getElementById(id);
            if (btn) btn.style.display = 'none';
        });
        // Hide all edit and delete buttons by class
        document.querySelectorAll(
            '.edit-btn, .delete-btn, .edit-family-btn, .delete-family-btn'
        ).forEach(function(btn) {
            btn.style.display = 'none';
        });
        // Optionally: Hide any "add" buttons with class add-btn
        document.querySelectorAll('.add-btn').forEach(function(btn) {
            btn.style.display = 'none';
        });
    }
});
    </script>

    
    <!-- Link the JavaScript file -->
    <script src="individuals.js"></script>
</body>
</html>
