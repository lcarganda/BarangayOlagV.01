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
    <title>Barangay Olag Pequiño - Households</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="icon" href="../../backend/logotab.png" type="image/jpeg">
    <link rel="stylesheet" href="households.css">
    
    <style>
        .details-group {
            display: flex;
            margin-bottom: 0.5rem;
        }
        .details-label {
            font-weight: 600;
            margin-right: 0.5rem;
            color: #4b5563;
            min-width: 150px;
        }
        .details-value {
            color: #1f2937;
            flex-grow: 1;
        }
        .details-section-heading {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary-dark-green);
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 0.5rem;
            margin-bottom: 1rem;
            margin-top: 1.5rem;
        }
        /* Ensure the table header is always above the content */
        thead.sticky {
            z-index: 20;
        }

        .mb-6 {
            margin-top: 1.5rem;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans antialiased flex h-screen overflow-hidden">

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
            <a href="households.php" class="flex items-center px-4 py-2 rounded-lg bg-secondary-green text-text-light">
                <i class="fas fa-home mr-3"></i> Households
            </a>
            <a href="../families/families.php" class="flex items-center px-4 py-2 rounded-lg hover:bg-secondary-green transition-colors duration-200">
                <i class="fas fa-users mr-3"></i> Families
            </a>
            <a href="../zones/zone.php" class="flex items-center px-4 py-2 rounded-lg hover:bg-secondary-green transition-colors duration-200">
                <i class="fas fa-map-marker-alt mr-3"></i> Zones
            </a>
        </nav>
        <div class="p-6 text-center text-gray-400 text-xs border-t border-gray-700">
            © 2024 Barangay Olag Pequiño
        </div>
    </aside>

    <main id="mainContent" class="flex-1 flex flex-col bg-gray-100 overflow-hidden lg:ml-0 p-0">
        <!-- Header -->
        <header class="bg-white shadow-md p-4 flex items-center gap-2 z-10 sticky top-0">
            <!-- Hamburger button (visible on mobile only) -->
            <button id="mobileMenuButton" class="lg:hidden mr-2 p-2 rounded-md bg-primary-dark-green text-text-light shadow-lg">
                <i class="fas fa-bars text-xl"></i>
            </button>
            <!-- Title -->
            <h2 class="text-2xl font-bold text-gray-800 text-center flex-1 md:text-left m-0 w-full">
                Households Management
            </h2>
            <!-- Filter Button -->
            <button id="openFilterModalBtn" class="bg-blue-500 text-white py-2 px-4 rounded-xl shadow-md hover:bg-blue-600 transition-colors duration-200 text-lg font-semibold flex items-center">
                <i class="fas fa-filter mr-2"></i>
                <span class="hidden sm:inline">Filters</span>
            </button>
            <!-- Add New Button -->
            <button id="addNewHouseholdBtn"
                class="bg-secondary-green text-text-light py-1 px-2 rounded-xl shadow-md hover:bg-opacity-90 transition-colors duration-200 font-semibold flex items-center text-base
                       sm:py-2 sm:px-4 sm:text-lg">
                <i class="fas fa-plus text-lg sm:mr-2"></i>
                <span class="hidden sm:inline">Add New Household</span>
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
                <input type="text" id="householdSearch" placeholder="Search by address, head, income..." class="pl-10 pr-4 py-2 rounded-xl border border-gray-300 shadow-sm w-full focus:ring-secondary-green focus:border-secondary-green text-lg">    
            </div>
        </section>
        <!-- Main Content -->
        <section class="bg-white p-6 rounded-2xl shadow-lg flex-1 overflow-y-auto custom-scrollbar m-0">
            <h3 class="text-xl font-semibold mb-4 text-text-dark">Household List</h3>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200 text-sm md:text-base">
                    <thead class="bg-gray-50 sticky top-0 z-10">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Members</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider rounded-tl-xl">Address</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Head of Household</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Monthly Income</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Has Electricity?</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Has Toilet?</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Has Internet?</th>
                            <th scope="col" class="relative px-6 py-3">
                                <span class="sr-only">Actions</span>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="householdsTableBody" class="bg-white divide-y divide-gray-200">
                    </tbody>
                </table>
                <div id="noResults" class="hidden text-center py-8 text-gray-500">No matching households found.</div>
            </div>
            <div class="flex justify-between items-center mt-6">
                <button id="prevPageBtn" class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">Previous</button>
                <span id="paginationInfo" class="text-sm text-gray-700">Page 1 of 1</span>
                <button id="nextPageBtn" class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">Next</button>
            </div>
        </section>
    </main>

    <div id="householdModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50 modal-overlay">
        <div class="bg-white p-8 rounded-2xl shadow-xl max-w-3xl w-full mx-4 my-8 overflow-y-auto max-h-[90vh] modal-container">
            <div class="flex justify-between items-center mb-6 modal-header">
                <h2 id="householdModalTitle" class="text-2xl font-bold text-text-dark">Add New Household</h2>
                <button type="button" id="closeHouseholdModalBtn" class="text-gray-500 hover:text-gray-700 text-2xl">&times;</button>
            </div>
            <form id="householdForm" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <input type="hidden" id="householdId">

                <div class="col-span-full text-lg font-semibold text-primary-dark-green border-b pb-2 mb-4">Basic Information</div>

                <div class="col-span-full">
                    <label for="address" class="block text-sm font-medium text-gray-700">Address <span class="text-red-500">*</span></label>
                    <input type="text" id="address" name="address" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                </div>
                <div>
                    <label for="zone" class="block text-sm font-medium text-gray-700">Zone <span class="text-red-500">*</span></label>
                    <select id="zone" name="zone_id" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm"></select>
                </div>
                <div class="col-span-full">
                    <label for="headOfHouseholdSearch" class="block text-sm font-medium text-gray-700">Household Head</label>
                    <div class="relative">
                        <input type="text" id="headOfHouseholdSearch" name="headOfHouseholdSearch"
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm"
                            placeholder="Search by name or last name..." autocomplete="off" required>
                        <input type="hidden" id="headOfHousehold" name="head_of_household_id" required>
                        <ul id="headOfHouseholdSuggestions" class="absolute z-20 w-full bg-white border border-gray-300 rounded-md shadow-lg mt-1 hidden max-h-60 overflow-y-auto"></ul>
                    </div>
                </div>

                <div class="col-span-full text-lg font-semibold text-primary-dark-green border-b pb-2 mb-4 mt-6">Financial & Type Information</div>

                <div>
                    <label for="monthlyHouseholdIncome" class="block text-sm font-medium text-gray-700">Monthly Household Income (₱) <span class="text-red-500">*</span></label>
                    <input type="number" step="0.01" id="monthlyHouseholdIncome" name="monthly_household_income" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                </div>
                <div>
                    <label for="incomeSource" class="block text-sm font-medium text-gray-700">Main Income Source <span class="text-red-500">*</span></label>
                    <select id="incomeSource" name="household_source_of_income_id" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm"></select>
                </div>
                <div>
                    <label for="householdType" class="block text-sm font-medium text-gray-700">Household Type <span class="text-red-500">*</span></label>
                    <select id="householdType" name="type_of_household_id" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm"></select>
                </div>
                <div>
                    <label for="houseMaterial" class="block text-sm font-medium text-gray-700">House Material <span class="text-red-500">*</span></label>
                    <select id="houseMaterial" name="type_of_house_material_id" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm"></select>
                </div>

                <div class="col-span-full text-lg font-semibold text-primary-dark-green border-b pb-2 mb-4 mt-6">Utilities & Amenities</div>
                <div class="flex items-center mt-6">
                    <input type="checkbox" id="hasWater" name="has_water" class="h-4 w-4 text-secondary-green focus:ring-secondary-green border-gray-300 rounded">
                    <label for="hasWater" class="ml-2 block text-sm text-gray-900">Has Water?</label>
                </div>
                <div class="flex items-center mt-6">
                    <input type="checkbox" id="hasElectricity" name="has_electricity" class="h-4 w-4 text-secondary-green focus:ring-secondary-green border-gray-300 rounded">
                    <label for="hasElectricity" class="ml-2 block text-sm text-gray-900">Has Electricity?</label>
                </div>
                <div class="flex items-center mt-6">
                    <input type="checkbox" id="hasToilet" name="has_toilet" class="h-4 w-4 text-secondary-green focus:ring-secondary-green border-gray-300 rounded">
                    <label for="hasToilet" class="ml-2 block text-sm text-gray-900">Has a Toilet?</label>
                </div>
                <div class="flex items-center mt-6">
                    <input type="checkbox" id="hasInternet" name="has_internet" class="h-4 w-4 text-secondary-green focus:ring-secondary-green border-gray-300 rounded">
                    <label for="hasInternet" class="ml-2 block text-sm text-gray-900">Has Internet?</label>
                </div>

                <!-- Household Members Section -->
                <div class="col-span-full text-lg font-semibold text-primary-dark-green border-b pb-2 mb-4 mt-6">Household Members</div>
                <div id="householdMembersContainer" class="col-span-full space-y-4">
                    <!-- Member rows will be dynamically added here -->
                </div>
                <div class="col-span-full flex justify-end">
                    <button type="button" id="addMemberBtn" class="bg-blue-500 text-white py-2 px-4 rounded-xl shadow-md hover:bg-blue-600 transition-colors duration-200 text-sm font-semibold flex items-center">
                        <i class="fas fa-user-plus mr-2"></i> Add Member
                    </button>
                </div>


                <div class="col-span-full flex justify-end space-x-4 mt-8">
                    <button type="button" id="cancelHouseholdBtn" class="bg-gray-300 text-gray-800 py-2 px-6 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-lg font-semibold">Cancel</button>
                    <button type="submit" id="saveHouseholdBtn" class="bg-primary-dark-green text-text-light py-2 px-6 rounded-xl shadow-md hover:bg-green-800 transition-colors duration-200 text-lg font-semibold">Save Household</button>
                </div>
            </form>
        </div>
    </div>

    <div id="viewHouseholdModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50 modal-overlay">
        <div class="bg-white p-8 rounded-2xl shadow-xl max-w-2xl w-full mx-4 my-8 overflow-y-auto max-h-[90vh] modal-container">
            <div class="flex justify-between items-center mb-6 modal-header">
                <h2 class="text-2xl font-bold text-text-dark">Household Details</h2>
                <button type="button" id="closeViewHouseholdHeaderBtn" class="text-gray-500 hover:text-gray-700 text-2xl">&times;</button>
            </div>
            <!-- Modernized Household Details Content -->
            <div id="householdDetailsContent" class="space-y-8">

                <!-- Basic Information -->
                <div class="rounded-xl bg-gray-50 p-6 shadow flex flex-col gap-4">
                    <div class="flex items-center gap-3 mb-2">
                        <i class="fas fa-home text-primary-dark-green text-2xl"></i>
                        <h3 class="text-lg font-bold text-primary-dark-green">Basic Information</h3>
                    </div>
                    <div id="viewBasicInfo" class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="flex flex-col bg-white rounded-lg p-4 shadow-sm">
                            <span class="text-sm text-text-medium font-semibold mb-1">Address:</span>
                            <span class="text-base text-text-dark font-medium break-words">House 9, Zone D St., Zone Zone G</span>
                        </div>
                        <div class="flex flex-col bg-white rounded-lg p-4 shadow-sm">
                            <span class="text-sm text-text-medium font-semibold mb-1">Head of Household:</span>
                            <span class="text-base text-text-dark font-medium break-words">Maria F. Aquino</span>
                        </div>
                        <div class="flex flex-col bg-white rounded-lg p-4 shadow-sm md:col-span-2">
                            <span class="text-sm text-text-medium font-semibold mb-1">Zone:</span>
                            <span class="text-base text-text-dark font-medium break-words">Zone G</span>
                        </div>
                    </div>
                </div>

                <!-- Financial & Type Information -->
                <div class="rounded-xl bg-gray-50 p-6 shadow flex flex-col gap-4">
                    <div class="flex items-center gap-3 mb-2">
                        <i class="fas fa-coins text-yellow-500 text-2xl"></i>
                        <h3 class="text-lg font-bold text-yellow-700">Financial & Type Information</h3>
                    </div>
                    <div id="viewFinancialInfo" class="grid grid-cols-1 md:grid-cols-2 gap-4"></div>
                </div>

                <!-- Utilities & Amenities -->
                <div class="rounded-xl bg-gray-50 p-6 shadow flex flex-col gap-4">
                    <div class="flex items-center gap-3 mb-2">
                        <i class="fas fa-plug text-blue-500 text-2xl"></i>
                        <h3 class="text-lg font-bold text-blue-700">Utilities & Amenities</h3>
                    </div>
                    <div id="viewUtilitiesInfo" class="grid grid-cols-1 md:grid-cols-2 gap-4"></div>
                </div>

                <!-- Household Members -->
                <div class="rounded-xl bg-gray-50 p-6 shadow flex flex-col gap-4">
                    <div class="flex items-center gap-3 mb-2">
                        <i class="fas fa-users text-secondary-green text-2xl"></i>
                        <h3 class="text-lg font-bold text-secondary-green">Household Members</h3>
                    </div>
                    <div id="viewHouseholdMembers" class="grid grid-cols-1 gap-2"></div>
                </div>
            </div>
            <div class="flex justify-end mt-8">
                <button type="button" id="closeViewHouseholdBtn" class="bg-gray-300 text-gray-800 py-2 px-6 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-lg font-semibold">Close</button>
            </div>
        </div>
    </div>

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
    <div id="filterModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50 modal-overlay">
        <div class="bg-white p-8 rounded-2xl shadow-xl max-w-xl w-full mx-4 my-8 overflow-y-auto max-h-[90vh] modal-container">
            <!-- Mobile: Show only logo in header -->
            <div class="flex justify-center items-center mb-6 modal-header md:justify-between">
                <!-- Logo for mobile only -->
                <img src="../../backend/logo.jpg" alt="Logo" class="h-10 w-10 rounded-full object-cover block md:hidden">
                <!-- Title for desktop -->
                <h2 class="text-2xl font-bold text-text-dark hidden md:block">Filter Households</h2>
                <!-- Close button -->
                <button type="button" id="closeFilterModalBtn" class="text-gray-500 hover:text-gray-700 text-2xl absolute right-6 top-6 md:static md:ml-4">&times;</button>
            </div>
            <!-- Title for mobile (visually hidden, for accessibility) -->
            <h2 class="sr-only">Filter Households</h2>
            <form id="filterForm" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Monthly Income Filter -->
                <div>
                    <label for="filterMinMonthlyIncome" class="block text-sm font-medium text-gray-700">Min Monthly Income (₱)</label>
                    <input type="number" step="0.01" id="filterMinMonthlyIncome" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                </div>
                <div>
                    <label for="filterMaxMonthlyIncome" class="block text-sm font-medium text-gray-700">Max Monthly Income (₱)</label>
                    <input type="number" step="0.01" id="filterMaxMonthlyIncome" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                </div>

                <!-- Zone Filter -->
                <div>
                    <label for="filterZone" class="block text-sm font-medium text-gray-700">Zone</label>
                    <select id="filterZone" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                        <option value="all">All</option>
                        <!-- Options populated by JS -->
                    </select>
                </div>

                <!-- Household Type Filter -->
                <div>
                    <label for="filterHouseholdType" class="block text-sm font-medium text-gray-700">Household Type</label>
                    <select id="filterHouseholdType" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                        <option value="all">All</option>
                        <!-- Options populated by JS -->
                    </select>
                </div>

                <!-- House Material Filter -->
                <div>
                    <label for="filterHouseMaterial" class="block text-sm font-medium text-gray-700">House Material</label>
                    <select id="filterHouseMaterial" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                        <option value="all">All</option>
                        <!-- Options populated by JS -->
                    </select>
                </div>

                <!-- Has Water Filter -->
                <div>
                    <label for="filterHasWater" class="block text-sm font-medium text-gray-700">Has Water?</label>
                    <select id="filterHasWater" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                        <option value="all">All</option>
                        <option value="true">Yes</option>
                        <option value="false">No</option>
                    </select>
                </div>

                <!-- Has Electricity Filter -->
                <div>
                    <label for="filterHasElectricity" class="block text-sm font-medium text-gray-700">Has Electricity?</label>
                    <select id="filterHasElectricity" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                        <option value="all">All</option>
                        <option value="true">Yes</option>
                        <option value="false">No</option>
                    </select>
                </div>

                <!-- Has Toilet Filter -->
                <div>
                    <label for="filterHasToilet" class="block text-sm font-medium text-gray-700">Has Toilet?</label>
                    <select id="filterHasToilet" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                        <option value="all">All</option>
                        <option value="true">Yes</option>
                        <option value="false">No</option>
                    </select>
                </div>

                <!-- Has Internet Filter -->
                <div>
                    <label for="filterHasInternet" class="block text-sm font-medium text-gray-700">Has Internet?</label>
                    <select id="filterHasInternet" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                        <option value="all">All</option>
                        <option value="true">Yes</option>
                        <option value="false">No</option>
                    </select>
                </div>

                <!-- Records Per Page Filter -->
                <div>
                    <label for="filterRecordsPerPage" class="block text-sm font-medium text-gray-700">Show per page</label>
                    <select id="filterRecordsPerPage" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                        <option value="10">10</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                        <option value="500">500</option>
                        <option value="1000">1000</option>
                    </select>
                </div>

                <!-- Sort By Filter -->
                <div>
                    <label for="filterSortBy" class="block text-sm font-medium text-gray-700">Sort By</label>
                    <select id="filterSortBy" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                        <option value="head_last_name">Head Last Name</option>
                        <option value="member_count">Household Members</option>
                        <option value="zone">Zone</option>
                        <option value="income">Monthly Income</option>
                    </select>
                </div>

                <!-- Sort Order Filter -->
                <div>
                    <label for="filterSortOrder" class="block text-sm font-medium text-gray-700">Order</label>
                    <select id="filterSortOrder" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-secondary-green focus:border-secondary-green sm:text-sm">
                        <option value="asc">Ascending</option>
                        <option value="desc">Descending</option>
                    </select>
                </div>

                <!-- Filter Actions -->
                <div class="col-span-full flex justify-end space-x-4 mt-8">
                    <button type="button" id="clearFiltersBtn" class="bg-gray-300 text-gray-800 py-2 px-6 rounded-xl shadow-md hover:bg-gray-400 transition-colors duration-200 text-lg font-semibold">Clear Filters</button>
                    <button type="submit" id="applyFiltersBtn" class="bg-primary-dark-green text-text-light py-2 px-6 rounded-xl shadow-md hover:bg-green-800 transition-colors duration-200 text-lg font-semibold">Apply Filters</button>
                </div>
            </form>
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

        <script src="households.js" defer></script>
</body>
</html>
