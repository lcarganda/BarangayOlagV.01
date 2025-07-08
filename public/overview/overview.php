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
    <title>Barangay Olag Pequiño - Overview</title>

    <link rel="stylesheet" href="overview.css">


    <!-- Favicon/Logo in tab -->
    <link rel="icon" href="../../backend/logotab.png" type="image/jpeg"> 
    <!-- If you convert to .ico, use: <link rel="icon" href="../../backend/favicon.ico" type="image/x-icon"> -->


    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<!-- Body remains overflow-hidden to keep the overall page fixed except for designated scroll areas -->
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
            <a href="overview.php" class="flex items-center px-4 py-2 rounded-lg bg-secondary-green text-text-light">
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
        <header class="bg-white shadow-md p-4 flex items-center justify-between z-10">
            <!-- Added pl-16 for small screens to make space for the hamburger icon -->
            <h1 class="text-xl sm:text-2xl font-bold text-gray-800 pl-16 lg:pl-0">Overview Dashboard</h1>
            <div class="flex items-center space-x-4">
                <div class="relative">
                    <select id="zoneSelect"
        class="block appearance-none w-full bg-white border border-gray-300 text-gray-700 py-2 px-3 sm:px-4 pr-8 rounded-md leading-tight focus:outline-none focus:bg-white focus:border-gray-500 shadow-sm text-base sm:text-lg">
        <option value="All Zones">All Zones</option>
    </select>
                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                    </div>
                </div>  
                <a href="/olagpeq/logout.php"
                        class="flex items-center gap-2 bg-red-500 hover:bg-red-600 text-white font-semibold px-4 py-2 rounded-xl shadow-md transition-colors duration-200 text-base md:text-lg ml-auto">
                        <i class="fas fa-sign-out-alt"></i>
                        <span class="hidden sm:inline">Logout</span>
                </a>
            </div>
        </header>

        <!-- Dashboard Content Area (Scrollable) -->
        <div class="flex-1 overflow-y-auto p-6 space-y-6">
            <!-- Summary Statistics Section -->
            <section class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
                <!-- Total Residents Card -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg flex items-center justify-between mb-2 sm:mb-0">
                    <div>
                        <p class="text-base sm:text-lg text-gray-500 font-medium">Total Residents</p>
                        <p id="totalResidents" class="text-2xl sm:text-3xl font-bold text-gray-800 mt-1">0</p>
                    </div>
                    <i class="fas fa-users text-3xl sm:text-4xl text-blue-500 opacity-75"></i>
                </div>
                <!-- Total Households Card -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg flex items-center justify-between mb-2 sm:mb-0">
                    <div>
                        <p class="text-base sm:text-lg text-gray-500 font-medium">Total Households</p>
                        <p id="totalHouseholds" class="text-2xl sm:text-3xl font-bold text-gray-800 mt-1">0</p>
                    </div>
                    <i class="fas fa-home text-3xl sm:text-4xl text-green-500 opacity-75"></i>
                </div>
                <!-- Zones Covered Card -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg flex items-center justify-between mb-2 sm:mb-0">
                    <div>
                        <p class="text-base sm:text-lg text-gray-500 font-medium">Zones Covered</p>
                        <p id="zonesCovered" class="text-2xl sm:text-3xl font-bold text-gray-800 mt-1">0</p>
                    </div>
                    <i class="fas fa-map-marker-alt text-3xl sm:text-4xl text-purple-500 opacity-75"></i>
                </div>
                <!-- Total Solo Parents Card -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg flex items-center justify-between mb-2 sm:mb-0">
                    <div>
                        <p class="text-base sm:text-lg text-gray-500 font-medium">Total Solo Parents</p>
                        <p id="totalSoloParents" class="text-2xl sm:text-3xl font-bold text-gray-800 mt-1">0</p>
                    </div>
                    <i class="fas fa-user-friends text-3xl sm:text-4xl text-pink-500 opacity-75"></i>
                </div>
                <!-- Families with 4Ps Beneficiaries Card -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg flex items-center justify-between mb-2 sm:mb-0">
                    <div>
                        <p class="text-base sm:text-lg text-gray-500 font-medium">Families with 4Ps Beneficiaries</p>
                        <p id="families4Ps" class="text-2xl sm:text-3xl font-bold text-gray-800 mt-1">0</p>
                    </div>
                    <i class="fas fa-hand-holding-heart text-3xl sm:text-4xl text-yellow-500 opacity-75"></i>
                </div>
                <!-- Individuals with Disability Card -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg flex items-center justify-between mb-2 sm:mb-0">
                    <div>
                        <p class="text-base sm:text-lg text-gray-500 font-medium">Individuals with Disability</p>
                        <p id="individualsWithDisability" class="text-2xl sm:text-3xl font-bold text-gray-800 mt-1">0</p>
                    </div>
                    <i class="fas fa-wheelchair text-3xl sm:text-4xl text-indigo-500 opacity-75"></i>
                </div>
                <!-- Households with Water Card -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg flex items-center justify-between mb-2 sm:mb-0">
                    <div>
                        <p class="text-base sm:text-lg text-gray-500 font-medium">Households with Water</p>
                        <p id="householdsWithWater" class="text-2xl sm:text-3xl font-bold text-gray-800 mt-1">0/0</p>
                    </div>
                    <i class="fas fa-faucet-drip text-3xl sm:text-4xl text-blue-400 opacity-75"></i>
                </div>
                <!-- Households with Electricity Card -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg flex items-center justify-between mb-2 sm:mb-0">
                    <div>
                        <p class="text-base sm:text-lg text-gray-500 font-medium">Households with Electricity</p>
                        <p id="householdsWithElectricity" class="text-2xl sm:text-3xl font-bold text-gray-800 mt-1">0/0</p>
                    </div>
                    <i class="fas fa-lightbulb text-3xl sm:text-4xl text-yellow-400 opacity-75"></i>
                </div>
                <!-- Households with Internet Card -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg flex items-center justify-between mb-2 sm:mb-0">
                    <div>
                        <p class="text-base sm:text-lg text-gray-500 font-medium">Households with Internet</p>
                        <p id="householdsWithInternet" class="text-2xl sm:text-3xl font-bold text-gray-800 mt-1">0/0</p>
                    </div>
                    <i class="fas fa-wifi text-3xl sm:text-4xl text-purple-400 opacity-75"></i>
                </div>
                <!-- NEW: Total Scholars Card -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg flex items-center justify-between mb-2 sm:mb-0">
                    <div>
                        <p class="text-base sm:text-lg text-gray-500 font-medium">Total Scholars</p>
                        <p id="totalScholars" class="text-2xl sm:text-3xl font-bold text-gray-800 mt-1">0</p>
                    </div>
                    <i class="fas fa-graduation-cap text-3xl sm:text-4xl text-cyan-500 opacity-75"></i>
                </div>
                <!-- NEW: Total Registered Voters Card -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg flex items-center justify-between mb-2 sm:mb-0">
                    <div>
                        <p class="text-base sm:text-lg text-gray-500 font-medium">Total Registered Voters</p>
                        <p id="totalRegisteredVoters" class="text-2xl sm:text-3xl font-bold text-gray-800 mt-1">0</p>
                    </div>
                    <i class="fas fa-vote-yea text-3xl sm:text-4xl text-orange-500 opacity-75"></i>
                </div>
            </section>

            <!-- Charts Section -->
            <section class="grid grid-cols-1 md:grid-cols-2 gap-4 sm:gap-6">
                <!-- Age Group Distribution (Individuals) (Bar Chart) -->
                <div class="bg-white p-4 sm:p-6 rounded-2xl shadow-lg">
                    <h3 class="text-lg sm:text-xl font-semibold mb-4 text-text-dark">Age Group Distribution (Individuals)</h3>
                    <div id="ageGroupsChart" class="bar-chart-container">
                        <!-- Bars will be rendered here by JS -->
                    </div>
                    <!-- Updated labels for Age Group -->
                    <div class="flex flex-wrap justify-around text-xs text-gray-500 mt-2 px-2">
                        <span class="w-[25px] text-center">0-17</span>
                        <span class="w-[25px] text-center">18-59</span>
                        <span class="w-[25px] text-center">60+</span>
                    </div>
                </div>

                <!-- Gender Split (Individuals) (Pie Chart) -->
                <div class="bg-white p-6 rounded-2xl shadow-lg flex flex-col items-center justify-center">
                    <h3 class="text-xl font-semibold mb-4 text-text-dark">Gender Split (Individuals)</h3>
                    <div id="genderSplitChart" class="pie-chart-wrapper">
                        <div class="pie-chart">
                            <div class="pie-chart-total-number"></div>
                        </div>
                        <div class="pie-legend"></div>
                    </div>
                </div>

                <!-- Civil Status Distribution (Individuals) (Pie Chart) -->
                <div class="bg-white p-6 rounded-2xl shadow-lg flex flex-col items-center justify-center">
                    <h3 class="text-xl font-semibold mb-4 text-text-dark">Civil Status Distribution (Individuals)</h3>
                    <div id="civilStatusChart" class="pie-chart-wrapper">
                        <div class="pie-chart">
                            <div class="pie-chart-total-number"></div>
                        </div>
                        <div class="pie-legend"></div>
                    </div>
                </div>

                <!-- Educational Attainment (Individuals) (Bar Chart) -->
                <div class="bg-white p-6 rounded-2xl shadow-lg">
                    <h3 class="text-xl font-semibold mb-4 text-text-dark">Educational Attainment (Individuals)</h3>
                    <div id="educationalAttainmentChart" class="bar-chart-container">
                        <!-- Bars will be rendered here by JS -->
                    </div>
                    <!-- Labels will be rendered dynamically by JS -->
                    <div id="educationalAttainmentLabels" class="flex justify-around text-xs text-gray-500 mt-2 px-2">
                        <!-- Dynamic labels will be inserted here -->
                    </div>
                </div>

                <!-- Main Source of Water (Families) (Bar Chart) -->
                <div class="bg-white p-6 rounded-2xl shadow-lg">
                    <h3 class="text-xl font-semibold mb-4 text-text-dark">Main Source of Water (Households)</h3>
                    <div id="waterSourceChart" class="bar-chart-container">
                        <!-- Bars will be rendered here by JS -->
                    </div>
                    <!-- Updated labels for Main Source of Water -->
                    <div class="flex justify-around text-xs text-gray-500 mt-2 px-2">
                        <span class="w-[25px] text-center">Piped Water</span>
                        <span class="w-[25px] text-center">Deep Well</span>
                        <span class="w-[25px] text-center">Spring</span>
                        <span class="w-[25px] text-center">Bottled Water</span>
                        <span class="w-[25px] text-center">Shallow Well</span>
                        <span class="w-[25px] text-center">Rainwater</span>
                        <span class="w-[25px] text-center">Other</span>
                    </div>
                </div>
            </section>
        </div>
    </main>

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

        <script src="overview.js" defer></script>
</body>
</html>
