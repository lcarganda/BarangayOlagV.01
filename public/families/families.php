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
    <title>Barangay Olag Pequiño - Families</title>

    <!-- Favicon/Logo in tab -->
    <link rel="icon" href="../../backend/logotab.png" type="image/jpeg"> 

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="families.css">

</head>
<body class="bg-gray-100 font-sans antialiased flex h-screen overflow-hidden">

    <!-- Mobile Menu Toggle Button (Hamburger) -->
    <button id="mobileMenuButton" class="lg:hidden fixed top-4 left-4 z-50 p-2 rounded-md bg-primary-dark-green text-text-light shadow-lg">
        <i class="fas fa-bars text-xl"></i>
    </button>

    <!-- Mobile Menu Overlay -->
    <div id="mobileMenuOverlay" class="fixed inset-0 bg-black bg-opacity-50 z-40 hidden lg:hidden"></div>

    <!-- Sidebar / Mobile Navigation -->
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
            <a href="../individuals/individuals.php" class="flex items-center px-4 py-2 rounded-lg hover:bg-secondary-green transition-colors duration-200">
                <i class="fas fa-user-friends mr-3"></i> Individuals
            </a>
            <a href="../households/households.php" class="flex items-center px-4 py-2 rounded-lg hover:bg-secondary-green transition-colors duration-200">
                <i class="fas fa-home mr-3"></i> Households
            </a>
            <a href="families.php" class="flex items-center px-4 py-2 rounded-lg bg-secondary-green text-text-light">
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
    <main id="mainContent" class="flex-1 flex flex-col bg-gray-100 overflow-hidden lg:ml-0">
        <!-- Header -->
        <header class="bg-white shadow-sm p-4 flex justify-between items-center z-10">
            <h2 class="text-2xl font-semibold text-gray-800 pl-16 lg:pl-0">Families Management</h2>
            <div class="flex items-center space-x-4">
                <button id="addNewFamilyBtn" class="bg-primary-dark-green text-text-light py-2 px-4 rounded-xl shadow-md hover:bg-green-800 transition-colors duration-200 text-lg font-semibold flex items-center">
                    <i class="fas fa-plus-circle mr-2"></i> Add New
                </button>
                <button id="openFilterModalBtn" class="bg-blue-500 text-white py-2 px-4 rounded-xl shadow-md hover:bg-blue-600 transition-colors duration-200 text-lg font-semibold flex items-center">
                    <i class="fas fa-filter mr-2"></i> Filters
                </button>
                <a href="/olagpeq/logout.php"
                        class="flex items-center gap-2 bg-red-500 hover:bg-red-600 text-white font-semibold px-4 py-2 rounded-xl shadow-md transition-colors duration-200 text-base md:text-lg ml-auto">
                        <i class="fas fa-sign-out-alt"></i>
                        <span class="hidden sm:inline">Logout</span>
                </a>
            </div>
        </header>

        <!-- Family Search Section (Moved outside header) -->
        <section class="p-4 bg-gray-100">
            <div class="relative w-full">
                <input type="text" id="familySearch" placeholder="Search families..."
                       class="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-secondary-green focus:border-transparent transition duration-200 shadow-sm text-gray-700 w-full">
            </div>
        </section>

        <!-- Families Table Section -->
        <section class="p-6 flex-1 overflow-y-auto custom-scrollbar">
            <div class="bg-white p-6 rounded-2xl shadow-lg flex-1 flex flex-col">
                <h3 class="text-xl font-semibold mb-4 text-text-dark">Family List</h3>
                <div class="table-container overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50 sticky top-0 z-10">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Family Name</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Total Households</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Total Members</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="familiesTableBody" class="bg-white divide-y divide-gray-200">
                            <!-- Data will be dynamically loaded here by JavaScript -->
                        </tbody>
                    </table>
                </div>
                <div id="noFamilyResults" class="hidden text-center py-8 text-gray-500 text-lg">
                    No families found.
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

    <!-- Add/Edit Family Modal -->
    <div id="familyModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-40">
        <div class="bg-white p-8 rounded-2xl shadow-xl max-w-3xl w-full mx-4 my-8 overflow-y-auto max-h-[90vh]">
            <h2 id="familyModalTitle" class="text-2xl font-bold mb-6 text-text-dark">Add New Family</h2>
            <form id="familyForm" class="grid grid-cols-1 md:grid-cols-2 gap-x-6 gap-y-4">
                <input type="hidden" id="familyId">
                
                <div class="col-span-full">
                    <label for="familyName" class="block text-sm font-medium text-gray-700 mb-1">Family Name (Surname) *</label>
                    <input type="text" id="familyName" name="familyName" required
                           class="form-input">
                </div>

                <!-- Household Association Section -->
                <div class="md:col-span-2 details-section-heading">Associated Households</div>
                
                <div class="md:col-span-2">
                    <label for="availableHouseholdsSearch" class="block text-sm font-medium text-gray-700 mb-1">Search & Add Households</label>
                    <input type="text" id="availableHouseholdsSearch" placeholder="Search available households by address or head..."
                           class="form-input mb-2">
                    <div id="availableHouseholdsSearchResults" class="bg-gray-50 border border-gray-200 rounded-md max-h-40 overflow-y-auto space-y-1 p-2">
                        <p id="noAvailableHouseholdsSearch" class="text-center text-gray-500 hidden">No households found.</p>
                        <!-- Search results will be dynamically loaded here -->
                    </div>
                </div>

                <div class="md:col-span-2">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Currently Associated Households</label>
                    <div id="associatedHouseholdsList" class="bg-gray-50 border border-gray-200 rounded-md max-h-40 overflow-y-auto space-y-1 p-2">
                        <p id="noAssociatedHouseholdsEdit" class="text-center text-gray-500 hidden">No households associated yet.</p>
                        <!-- Associated households will be dynamically loaded here -->
                    </div>
                </div>

                <div class="md:col-span-2 flex justify-end space-x-3 mt-6">
                    <button type="button" id="cancelFamilyFormBtn" class="bg-gray-300 text-gray-800 py-2 px-6 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-lg font-semibold">Cancel</button>
                    <button type="submit" id="saveFamilyBtn" class="bg-primary-dark-green text-text-light py-2 px-6 rounded-xl shadow-md hover:bg-green-800 transition-colors duration-200 text-lg font-semibold">Save Family</button>
                </div>
            </form>
        </div>
    </div>

    <!-- View Family Details Modal -->
    <div id="viewFamilyModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50">
        <div class="bg-white p-8 rounded-2xl shadow-xl max-w-2xl w-full mx-4 my-8 overflow-y-auto max-h-[90vh]">
            <h2 class="text-2xl font-bold mb-6 text-text-dark">Family Details</h2>
            <div class="details-section-heading">Family Information</div>
            <div class="details-group">
                <span class="details-label">Family ID:</span>
                <span id="viewFamilyId" class="details-value"></span>
            </div>
            <div class="details-group">
                <span class="details-label">Family Name:</span>
                <span id="viewFamilyName" class="details-value"></span>
            </div>
            <div class="details-group">
                <span class="details-label">Total Households:</span>
                <span id="viewTotalHouseholds" class="details-value"></span>
            </div>
            <div class="details-group">
                <span class="details-label">Total Members:</span>
                <span id="viewTotalMembers" class="details-value"></span>
            </div>

            <div class="details-section-heading">Associated Households</div>
            <div id="viewHouseholdsList" class="space-y-3">
                <p id="noAssociatedHouseholds" class="text-gray-500 text-center py-4 hidden">No households associated with this family.</p>
                <!-- Associated households will be loaded here -->
            </div>
            <div class="flex justify-end mt-8">
                <button type="button" id="closeViewFamilyModalBtn" class="bg-gray-300 text-gray-800 py-2 px-6 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-lg font-semibold">Close</button>
            </div>
        </div>
    </div>

    <!-- View Household Details Modal (Reused from Households page) -->
    <div id="viewHouseholdDetailsModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50">
        <div class="bg-white p-8 rounded-2xl shadow-xl max-w-2xl w-full mx-4 my-8 overflow-y-auto max-h-[90vh]">
            <h2 class="text-2xl font-bold mb-6 text-text-dark">Household Details</h2>
            <div class="details-section-heading">Basic Information</div>
            <div class="details-group"><span class="details-label">Household ID:</span><span id="householdDetailsId" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">Address:</span><span id="householdDetailsAddress" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">Head of Household:</span><span id="householdDetailsHead" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">Zone:</span><span id="householdDetailsZone" class="details-value"></span></div>

            <div class="details-section-heading">Financial & Type Information</div>
            <div class="details-group"><span class="details-label">Monthly Income:</span><span id="householdDetailsIncome" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">Income Source:</span><span id="householdDetailsIncomeSource" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">Household Type:</span><span id="householdDetailsType" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">House Material:</span><span id="householdDetailsHouseMaterial" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">Tenure Status:</span><span id="householdDetailsTenure" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">Cooking Fuel:</span><span id="householdDetailsCookingFuel" class="details-value"></span></div>

            <div class="details-section-heading">Utilities & Amenities</div>
            <div class="details-group"><span class="details-label">Has Water:</span><span id="householdDetailsHasWater" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">Has Electricity:</span><span id="householdDetailsHasElectricity" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">Has Toilet:</span><span id="householdDetailsHasToilet" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">Has Internet:</span><span id="householdDetailsHasInternet" class="details-value"></span></div>
            <div class="details-group"><span class="details-label">Water Source:</span><span id="householdDetailsWaterSource" class="details-value"></span></div>

            <div class="details-section-heading">Household Members</div>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                            <th class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Relationship</th>
                            <th class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Gender</th>
                            <th class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Birth Date</th>
                            <th class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Civil Status</th>
                            <th class="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Occupation</th>
                        </tr>
                    </thead>
                    <tbody id="householdMembersTableBody" class="bg-white divide-y divide-gray-200">
                        <!-- Members will be loaded here by JavaScript -->
                    </tbody>
                </table>
                <p id="noHouseholdMembers" class="text-gray-500 text-center py-4 hidden">No members found for this household.</p>
            </div>
            <div class="flex justify-end mt-8">
                <button type="button" id="closeHouseholdDetailsModalBtn" class="bg-gray-300 text-gray-800 py-2 px-6 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-lg font-semibold">Close</button>
            </div>
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

    <!-- Filter Modal -->
    <div id="filterModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50">
        <div class="bg-white p-8 rounded-2xl shadow-xl max-w-xl w-full mx-4 my-8 overflow-y-auto max-h-[90vh]">
            <h2 class="text-2xl font-bold mb-6 text-text-dark">Filter Families</h2>
            <form id="filterForm" class="grid grid-cols-1 md:grid-cols-2 gap-x-6 gap-y-4">
                <!-- Sort By -->
                <div class="col-span-full">
                    <label for="sortBy" class="block text-sm font-medium text-gray-700 mb-1">Sort By</label>
                    <select id="sortBy" class="form-input">
                        <option value="family_name">Family Name</option>
                        <option value="total_households">Total Households</option>
                        <option value="total_members">Total Members</option>
                    </select>
                </div>

                <!-- Sort Order -->
                <div class="col-span-full">
                    <label for="sortOrder" class="block text-sm font-medium text-gray-700 mb-1">Sort Order</label>
                    <select id="sortOrder" class="form-input">
                        <option value="ASC">Ascending</option>
                        <option value="DESC">Descending</option>
                    </select>
                </div>

                <!-- Records per Page -->
                <div class="col-span-full">
                    <label for="filterRecordsPerPage" class="block text-sm font-medium text-gray-700 mb-1">Records per Page</label>
                    <select id="filterRecordsPerPage" class="form-input">
                        <option value="10">10</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                        <option value="500">500</option>
                        <option value="1000">1000</option>
                    </select>
                </div>

                <div class="col-span-full flex justify-end space-x-3 mt-6">
                    <button type="button" id="clearFiltersBtn" class="bg-gray-300 text-gray-800 py-2 px-6 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-lg font-semibold">Clear Filters</button>
                    <button type="submit" id="applyFiltersBtn" class="bg-primary-dark-green text-text-light py-2 px-6 rounded-xl shadow-md hover:bg-green-800 transition-colors duration-200 text-lg font-semibold">Apply Filters</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Get user role from PHP session (make sure your page is .php and session_start() is at the top)
        var userRole = "<?php echo $_SESSION['role'] ?? ''; ?>";
        document.addEventListener('DOMContentLoaded', function() {
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
    <script src="families.js" defer></script>
</body>
</html>
