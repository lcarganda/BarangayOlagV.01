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
    <title>Barangay Olag Pequiño - Zones</title>

    <link rel="stylesheet" href="zones.css">
    <!-- Defer loading of zones.js to ensure HTML is parsed and custom modal is ready -->

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
    lg:relative lg:flex lg:flex-col lg:rounded-r-xl lg:shadow-lg z-50 lg:pt-0">
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
            <a href="../families/families.php" class="flex items-center px-4 py-2 rounded-lg hover:bg-secondary-green transition-colors duration-200">
                <i class="fas fa-users mr-3"></i> Families
            </a>
            <a href="zones.php" class="flex items-center px-4 py-2 rounded-lg bg-secondary-green text-text-light">
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
    <header class="bg-white shadow-md p-4 flex items-center gap-2 z-10 sticky top-0">
        <!-- Hamburger button (visible on mobile only) -->
        <button id="mobileMenuButton" class="lg:hidden mr-2 p-2 rounded-md bg-primary-dark-green text-text-light shadow-lg">
            <i class="fas fa-bars text-xl"></i>
        </button>
        <!-- Title -->
        <h2 class="text-2xl font-bold text-gray-800 text-center flex-1 md:text-left m-0 w-full">
            Zone Management
        </h2>
        <!-- Add New Zone Button -->
        <button id="addNewZoneBtn"
    class="bg-primary-dark-green text-text-light py-2 px-3 rounded-xl shadow-md hover:bg-secondary-green transition-colors duration-200 flex items-center text-base
           sm:py-2 sm:px-4 sm:text-lg">
    <i class="fas fa-plus text-lg sm:mr-2"></i>
    <span class="hidden sm:inline">Add New Zone</span>
</button>
        <!-- Logout Button -->
        <a href="/olagpeq/logout.php"
            class="flex items-center gap-2 bg-red-500 hover:bg-red-600 text-white font-semibold px-4 py-2 rounded-xl shadow-md transition-colors duration-200 text-base md:text-lg ml-auto">
            <i class="fas fa-sign-out-alt"></i>
            <span class="hidden sm:inline">Logout</span>
        </a>
    </header>
    <!-- Search Bar -->
    <section class="p-2">
        <div class="relative">
            <input type="text" id="zoneSearch" placeholder="Search zones..." class="pl-10 pr-4 py-2 rounded-xl border border-gray-300 shadow-sm w-full focus:ring-secondary-green focus:border-secondary-green text-lg">
        </div>
    </section>
        <!-- Zones List Section -->
        <section class="flex-1 p-6 overflow-y-auto">
            <div class="bg-white rounded-xl shadow-lg">
                <div class="table-container">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50 sticky top-0 z-10">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Zone Name</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Households</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Assigned Official</th>
                                <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="zonesTableBody" class="bg-white divide-y divide-gray-200">
                            <!-- Zone rows will be loaded here by JavaScript -->
                        </tbody>
                    </table>
                    <div id="noZoneResults" class="hidden text-center py-4 text-gray-500">No zones found.</div>
                </div>
                <!-- Pagination -->
                <nav class="flex items-center justify-between px-4 py-3 bg-white border-t border-gray-200 sm:px-6 rounded-b-xl">
                    <div class="flex-1 flex justify-between sm:hidden">
                        <button id="prevPageBtn" class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Previous</button>
                        <button id="nextPageBtn" class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Next</button>
                    </div>
                    <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                        <div>
                            <p class="text-sm text-gray-700">
                                Showing <span id="paginationInfo"></span>
                            </p>
                        </div>
                        <div>
                            <nav class="relative z-0 inline-flex -space-x-px rounded-md shadow-sm" aria-label="Pagination">
                                <button id="prevPageBtn" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <span class="sr-only">Previous</span>
                                    <i class="fas fa-chevron-left"></i>
                                </button>
                                <button id="nextPageBtn" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <span class="sr-only">Next</span>
                                    <i class="fas fa-chevron-right"></i>
                                </button>
                            </nav>
                        </div>
                    </div>
                </nav>
            </div>
        </section>
    </main>

    <!-- Zone Add/Edit Modal -->
    <div id="zoneModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50">
        <div class="bg-white p-8 rounded-xl shadow-2xl max-w-lg w-full mx-4 max-h-[90vh] overflow-y-auto">
            <h3 id="zoneModalTitle" class="text-2xl font-bold text-primary-dark-green mb-6 text-center">Add New Zone</h3>
            <form id="zoneForm" class="space-y-4">
                <div>
                    <label for="zoneName" class="block text-sm font-medium text-gray-700 mb-1">Zone Name</label>
                    <input type="text" id="zoneName" name="zone_name" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-secondary-green focus:border-secondary-green">
                    <input type="hidden" id="zoneId" name="zone_id">
                </div>
                <div>
                    <label for="zoneDescription" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                    <textarea id="zoneDescription" name="description" rows="3" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-secondary-green focus:border-secondary-green"></textarea>
                </div>
                <!-- NEW: Barangay Official Assigned Search Input and Suggestions -->
                <div class="mb-4 relative"> 
                    <label for="barangayOfficialSearch" class="block text-sm font-medium text-gray-700 mb-1">Assigned Barangay Official</label>
                    <input type="text" id="barangayOfficialSearch" placeholder="Search for an individual..."
                           class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                    <input type="hidden" id="barangayOfficialId" name="barangay_official_assigned_individual_id">
                    <div id="barangayOfficialSuggestions" class="absolute bg-white border border-gray-300 w-full rounded-md shadow-lg z-10 max-h-60 overflow-y-auto hidden">
                        <!-- Suggestions will be appended here by JavaScript -->
                    </div>
                </div>
                <!-- END NEW -->
                <div class="flex justify-end space-x-3 pt-4">
                    <button type="button" id="cancelZoneFormBtn" class="bg-gray-300 text-gray-800 py-2 px-4 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-sm font-semibold">Cancel</button>
                    <button type="submit" class="bg-primary-dark-green text-text-light py-2 px-4 rounded-xl shadow-md hover:bg-secondary-green transition-colors duration-200 text-sm font-semibold">Save Zone</button>
                </div>
            </form>
        </div>
    </div>

    <!-- New: View Zone Details Modal -->
    <div id="viewZoneModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50">
        <div class="bg-white p-8 rounded-xl shadow-2xl max-w-md w-full mx-4 max-h-[90vh] overflow-y-auto">
            <h3 class="text-2xl font-bold text-primary-dark-green mb-6 text-center">Zone Details</h3>
            <div class="space-y-4">
                <div>
                    <p class="text-sm font-medium text-gray-700">Zone Name:</p>
                    <p id="viewZoneName" class="text-lg font-semibold text-gray-900"></p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-700">Assigned Official:</p>
                    <p id="viewAssignedOfficial" class="text-lg font-semibold text-gray-900"></p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-700">Description:</p>
                    <p id="viewZoneDescription" class="text-gray-800"></p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-700">Households in Zone:</p>
                    <p id="viewHouseholdsCount" class="text-lg font-semibold text-gray-900"></p>
                </div>

                <!-- NEW: Population Statistics Section -->
                <div class="details-section-heading">Population Statistics</div>
                <div>
                    <p class="text-sm font-medium text-gray-700">Total Population:</p>
                    <p id="viewTotalPopulation" class="text-lg font-semibold text-gray-900"></p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-700">Most Common Surname:</p>
                    <p id="viewMostCommonSurname" class="text-lg font-semibold text-gray-900"></p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-700">Males:</p>
                    <p id="viewMaleCount" class="text-lg font-semibold text-gray-900"></p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-700">Females:</p>
                    <p id="viewFemaleCount" class="text-lg font-semibold text-gray-900"></p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-700">Minors (Under 18):</p>
                    <p id="viewMinorsCount" class="text-lg font-semibold text-gray-900"></p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-700">Seniors (60+):</p>
                    <p id="viewSeniorsCount" class="text-lg font-semibold text-gray-900"></p>
                </div>
                <!-- END NEW -->

            </div>
            <div class="flex justify-end pt-6">
                <button type="button" id="closeViewZoneModalBtn" class="bg-gray-300 text-gray-800 py-2 px-4 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-sm font-semibold">Close</button>
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
                <button id="customModalConfirm" class="bg-primary-dark-green text-text-light py-2 px-4 rounded-md shadow-sm hover:bg-secondary-green transition-colors duration-200 text-sm font-semibold">Confirm</button>
            </div>
        </div>
    </div>

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

<script src="zones.js" defer></script>

</body>
</html>
