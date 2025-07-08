document.addEventListener('DOMContentLoaded', () => {
    console.log('Families page loaded!');

    // --- DOM Elements ---
    const familiesTableBody = document.getElementById('familiesTableBody');
    const familySearch = document.getElementById('familySearch');
    const addNewFamilyBtn = document.getElementById('addNewFamilyBtn');
    const noFamilyResults = document.getElementById('noFamilyResults');

    // Pagination elements
    const prevPageBtn = document.getElementById('prevPageBtn');
    const nextPageBtn = document.getElementById('nextPageBtn');
    const paginationInfo = document.getElementById('paginationInfo');

    // Family Modal (Add/Edit)
    const familyModal = document.getElementById('familyModal');
    const familyModalTitle = document.getElementById('familyModalTitle');
    const familyForm = document.getElementById('familyForm');
    const familyIdInput = document.getElementById('familyId');
    const familyNameInput = document.getElementById('familyName');
    const cancelFamilyFormBtn = document.getElementById('cancelFamilyFormBtn');

    // Household Association Elements in Family Modal
    const availableHouseholdsSearch = document.getElementById('availableHouseholdsSearch'); // New search input
    const availableHouseholdsSearchResults = document.getElementById('availableHouseholdsSearchResults'); // New results container
    const associatedHouseholdsList = document.getElementById('associatedHouseholdsList');
    const noAssociatedHouseholdsEdit = document.getElementById('noAssociatedHouseholdsEdit'); // For edit modal
    const noAvailableHouseholdsSearch = document.getElementById('noAvailableHouseholdsSearch'); // For search results

    // Family View Modal
    const viewFamilyModal = document.getElementById('viewFamilyModal');
    const viewFamilyIdSpan = document.getElementById('viewFamilyId');
    const viewFamilyNameSpan = document.getElementById('viewFamilyName');
    const viewTotalHouseholdsSpan = document.getElementById('viewTotalHouseholds');
    const viewTotalMembersSpan = document.getElementById('viewTotalMembers');
    const viewHouseholdsList = document.getElementById('viewHouseholdsList');
    const noAssociatedHouseholdsView = document.getElementById('noAssociatedHouseholds'); // For view modal
    const closeViewFamilyModalBtn = document.getElementById('closeViewFamilyModalBtn');
    
    // Household Details Modal Elements
    const viewHouseholdDetailsModal = document.getElementById('viewHouseholdDetailsModal');
    const householdDetailsAddressSpan = document.getElementById('householdDetailsAddress');
    const householdDetailsIdSpan = document.getElementById('householdDetailsId');
    const householdDetailsHeadSpan = document.getElementById('householdDetailsHead');
    const householdDetailsZoneSpan = document.getElementById('householdDetailsZone');
    const householdDetailsIncomeSpan = document.getElementById('householdDetailsIncome');
    const householdDetailsTypeSpan = document.getElementById('householdDetailsType');
    const householdDetailsWaterSourceSpan = document.getElementById('householdDetailsWaterSource');
    const householdDetailsCookingFuelSpan = document.getElementById('householdDetailsCookingFuel');
    const householdDetailsTenureSpan = document.getElementById('householdDetailsTenure');
    const householdDetailsIncomeSourceSpan = document.getElementById('householdDetailsIncomeSource');
    const householdDetailsHouseMaterialSpan = document.getElementById('householdDetailsHouseMaterial');
    const householdDetailsHasToiletSpan = document.getElementById('householdDetailsHasToilet');
    const householdDetailsHasElectricitySpan = document.getElementById('householdDetailsHasElectricity');
    const householdDetailsHasWaterSpan = document.getElementById('householdDetailsHasWater');
    const householdDetailsHasInternetSpan = document.getElementById('householdDetailsInternet');
    const householdMembersTableBody = document.getElementById('householdMembersTableBody');
    const noHouseholdMembers = document.getElementById('noHouseholdMembers');
    const closeHouseholdDetailsModalBtn = document.getElementById('closeHouseholdDetailsModalBtn');


    // Custom Modal elements
    const customModal = document.getElementById('customModal');
    const customModalTitle = document.getElementById('customModalTitle');
    const customModalMessage = document.getElementById('customModalMessage');
    const customModalConfirmBtn = document.getElementById('customModalConfirm');
    const customModalCancelBtn = document.getElementById('customModalCancel');

    // --- Mobile Menu Elements ---
    console.log('Attempting to get mobile menu elements...');
    const mobileMenuButton = document.getElementById('mobileMenuButton');
    const mainSidebar = document.getElementById('mainSidebar');
    const mobileMenuOverlay = document.getElementById('mobileMenuOverlay');
    console.log('mobileMenuButton:', mobileMenuButton);
    console.log('mainSidebar:', mainSidebar);
    console.log('mobileMenuOverlay:', mobileMenuOverlay);


    let currentPage = 1;
    let currentSearchTerm = '';

    // Store all households fetched from the backend for filtering
    let allHouseholds = [];
    // Store currently associated households for the edit modal
    let currentAssociatedHouseholds = []; // Stores { household_id, display_name }

    // --- Filter Modal Elements ---
    const filterModal = document.getElementById('filterModal');
    const openFilterModalBtn = document.getElementById('openFilterModalBtn');
    const filterForm = document.getElementById('filterForm');
    const clearFiltersBtn = document.getElementById('clearFiltersBtn');
    const applyFiltersBtn = document.getElementById('applyFiltersBtn');

    // Filter form fields
    const sortBy = document.getElementById('sortBy');
    const sortOrder = document.getElementById('sortOrder');
    const filterRecordsPerPage = document.getElementById('filterRecordsPerPage'); // New records per page filter

    // Object to store current filter values
    let currentFilters = {
        sort_by: 'family_name', // Default sort
        sort_order: 'ASC',       // Default order
        records_per_page: 10     // Default records per page
    };

    // --- Mobile Menu Toggle Logic ---
    if (mobileMenuButton && mainSidebar && mobileMenuOverlay) {
        mobileMenuButton.addEventListener('click', () => {
            mainSidebar.classList.add('open');
            mobileMenuOverlay.classList.add('open');
            document.body.classList.add('sidebar-open', 'overflow-hidden-mobile');
        });

        mobileMenuOverlay.addEventListener('click', () => {
            mainSidebar.classList.remove('open');
            mobileMenuOverlay.classList.remove('open');
            document.body.classList.remove('sidebar-open', 'overflow-hidden-mobile');
        });

        // Optional: Close sidebar when a nav link is clicked (on mobile)
        mainSidebar.querySelectorAll('nav a').forEach(link => {
            link.addEventListener('click', () => {
                if (window.innerWidth < 1024) {
                    mainSidebar.classList.remove('open');
                    mobileMenuOverlay.classList.remove('open');
                    document.body.classList.remove('sidebar-open', 'overflow-hidden-mobile');
                }
            });
        });
    } else {
        // This block will be executed if any of the elements are null
        console.error('Failed to find one or more mobile menu elements:');
        if (!mobileMenuButton) console.error('  - mobileMenuButton is null');
        if (!mainSidebar) console.error('  - mainSidebar is null');
        if (!mobileMenuOverlay) console.error('  - mobileMenuOverlay is null');
        console.error('Mobile menu functionality will not be active.');
    }

    // --- Custom Modal Functions ---
    function showCustomModal(message, type, onConfirm = null, onCancel = null) {
        customModalTitle.textContent = type === 'confirm' ? 'Confirm Action' : 'Notification';
        customModalMessage.textContent = message;
        customModalCancelBtn.classList.add('hidden'); // Hide cancel by default
        customModalConfirmBtn.textContent = 'Okay'; // Default to Okay

        if (type === 'confirm') {
            customModalConfirmBtn.textContent = 'Confirm';
            customModalCancelBtn.classList.remove('hidden');
            customModalConfirmBtn.onclick = () => {
                customModal.classList.add('hidden');
                if (onConfirm) onConfirm();
            };
            customModalCancelBtn.onclick = () => {
                customModal.classList.add('hidden');
                if (onCancel) onCancel();
            };
        } else { // 'alert'
            customModalConfirmBtn.onclick = () => {
                customModal.classList.add('hidden');
                if (onConfirm) onConfirm(); // Still allow a callback for OK
            };
        }
        customModal.classList.remove('hidden');
        customModal.focus(); // Focus the modal to capture keyboard events if needed
    }

    // Override window.confirm and window.alert for consistent UX within the iframe
    window.confirm = function(message) {
        console.warn("Attempted to call window.confirm. Using custom modal instead.");
        return new Promise(resolve => {
            showCustomModal(message, 'confirm', () => resolve(true));
        });
    };

    window.alert = function(message) {
        console.warn("Attempted to call window.alert. Using custom modal instead.");
        showCustomModal(message, 'alert');
    };

    // --- API Calls ---
    async function fetchFamilies(offset, limit, searchQuery = '', filters = {}) {
        try {
            const queryParams = new URLSearchParams({
                offset: offset,
                limit: limit,
                search_query: searchQuery,
                filters: JSON.stringify(filters) // Send filters as a JSON string
            }).toString();

            const response = await fetch(`http://localhost/olagpeq/public/api/family.php?${queryParams}`);
            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.message || `Failed to fetch families data. Status: ${response.status}`);
            }
            const data = await response.json();
            return data.data; // Return the 'data' object which contains families and totalRecords
        } catch (error) {
            console.error('Error fetching families data:', error);
            showCustomModal(`Error fetching families data: ${error.message}`, 'alert');
            return { families: [], totalRecords: 0 }; // Return empty structure on error
        }
    }

    async function fetchFamilyDetails(familyId) {
        try {
            const response = await fetch(`http://localhost/olagpeq/public/api/family.php?id=${familyId}`);
            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.message || `Failed to fetch family details. Status: ${response.status}`);
            }
            const data = await response.json();
            return data.data; // The single family object
        } catch (error) {
            console.error('Error fetching family details:', error);
            showCustomModal(`Error fetching family details: ${error.message}`, 'alert');
            return null;
        }
    }

    // Fetch Household Details (for the new modal)
    async function fetchHouseholdDetails(householdId) {
        try {
            const response = await fetch(`http://localhost/olagpeq/public/api/household_details.php?id=${householdId}`);
            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.message || `Failed to fetch household details. Status: ${response.status}`);
            }
            const data = await response.json();
            return data.data; // The single household object with members
        } catch (error) {
            console.error('Error fetching household details:', error);
            showCustomModal(`Error fetching household details: ${error.message}`, 'alert');
            return null;
        }
    }

    // NEW: Fetch all households for association management
    async function fetchAllHouseholdsForAssociation() {
        try {
            const response = await fetch('http://localhost/olagpeq/public/api/family.php?action=getAllHouseholdsForAssociation');
            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.message || `Failed to fetch all households for association. Status: ${response.status}`);
            }
            const result = await response.json(); // Get the full result object
            if (result.status === 'success' && Array.isArray(result.data)) {
                allHouseholds = result.data.sort((a, b) => a.display_name.localeCompare(b.display_name)); // Store and sort the array
                return allHouseholds;
            } else {
                throw new Error(result.message || 'API response data is not an array.');
            }
        } catch (error) {
            console.error('Error fetching all households for association:', error);
            showCustomModal(`Error fetching households for association: ${error.message}`, 'alert');
            allHouseholds = [];
            return [];
        }
    }

    async function saveFamily(formData) {
        try {
            const response = await fetch('http://localhost/olagpeq/public/api/family.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });
            const result = await response.json();
            if (!response.ok) {
                throw new Error(result.message || 'Failed to save family.');
            }
            return result;
        } catch (error) {
            console.error('Error saving family:', error);
            showCustomModal(`Error saving family: ${error.message}`, 'alert');
            throw error; // Re-throw to allow form submission to stop
        }
    }

    async function deleteFamily(familyId) {
        try {
            const response = await fetch('http://localhost/olagpeq/public/api/family.php', {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ family_id: familyId })
            });
            const result = await response.json();
            if (!response.ok) {
                throw new Error(result.message || 'Failed to delete family.');
            }
            showCustomModal(result.message, 'alert', fetchAndRenderFamilies); // Refresh after success
            return true;
        } catch (error) {
            console.error('Error deleting family:', error);
            showCustomModal(`Error deleting family: ${error.message}`, 'alert');
            return false;
        }
    }

    // --- Render Functions ---
    async function fetchAndRenderFamilies() {
        const offset = (currentPage - 1) * currentFilters.records_per_page;
        const data = await fetchFamilies(offset, currentFilters.records_per_page, currentSearchTerm, currentFilters); // Pass filters
        const families = data.families;
        const totalRecords = data.totalRecords;

        familiesTableBody.innerHTML = '';
        if (families.length === 0) {
            noFamilyResults.classList.remove('hidden');
            paginationInfo.textContent = 'No results';
            prevPageBtn.disabled = true;
            nextPageBtn.disabled = true;
            return;
        } else {
            noFamilyResults.classList.add('hidden');
        }

        families.forEach(family => {
            const row = familiesTableBody.insertRow();
            row.className = 'hover:bg-gray-50';
            row.innerHTML = `
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${family.family_name}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${family.total_households}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${family.total_members}</td>
                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <button class="view-btn text-blue-600 hover:text-blue-900 mr-3" data-family-id="${family.family_id}">
                        <i class="fas fa-eye"></i> View
                    </button>
                    <button class="edit-btn text-indigo-600 hover:text-indigo-900 mr-3" data-family-id="${family.family_id}">
                        <i class="fas fa-edit"></i> Edit
                    </button>
                    <button class="delete-btn text-red-600 hover:text-red-900" data-family-id="${family.family_id}">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                </td>
            `;
        });

        totalPages = Math.ceil(totalRecords / currentFilters.records_per_page);
        paginationInfo.textContent = `Page ${currentPage} of ${totalPages} (${totalRecords} records)`;
        prevPageBtn.disabled = currentPage === 1;
        nextPageBtn.disabled = currentPage === totalPages;
    }

    // Function to render associated households in the edit modal
    function renderAssociatedHouseholds() {
        associatedHouseholdsList.innerHTML = '';
        if (currentAssociatedHouseholds.length === 0) {
            noAssociatedHouseholdsEdit.classList.remove('hidden');
        } else {
            noAssociatedHouseholdsEdit.classList.add('hidden');
            currentAssociatedHouseholds.forEach(household => {
                const li = document.createElement('li');
                li.className = 'bg-white p-2 rounded-md shadow-sm border border-gray-100 flex justify-between items-center';
                li.innerHTML = `
                    <span class="text-gray-800">${household.display_name}</span>
                    <button type="button" class="remove-associated-household-btn text-red-600 hover:text-red-900 text-sm" data-household-id="${household.household_id}">
                        <i class="fas fa-times-circle mr-1"></i> Remove
                    </button>
                `;
                associatedHouseholdsList.appendChild(li);
            });
        }
        // After rendering associated households, re-render available search results
        filterAndRenderAvailableHouseholds();
    }

    // Function to filter and render available households based on search term
    function filterAndRenderAvailableHouseholds() {
        const searchTerm = availableHouseholdsSearch.value.toLowerCase();
        availableHouseholdsSearchResults.innerHTML = ''; // Clear previous results

        const filteredHouseholds = allHouseholds.filter(household => {
            const isAssociated = currentAssociatedHouseholds.some(h => h.household_id === household.household_id);
            const matchesSearch = household.display_name.toLowerCase().includes(searchTerm);
            return !isAssociated && matchesSearch;
        });

        if (filteredHouseholds.length === 0) {
            noAvailableHouseholdsSearch.classList.remove('hidden');
        } else {
            noAvailableHouseholdsSearch.classList.add('hidden');
            filteredHouseholds.forEach(household => {
                const div = document.createElement('div');
                div.className = 'bg-white p-2 rounded-md shadow-sm border border-gray-100 flex justify-between items-center cursor-pointer hover:bg-gray-100 transition-colors duration-150 add-household-to-family-item';
                div.dataset.householdId = household.household_id;
                div.dataset.householdName = household.display_name;
                div.innerHTML = `
                    <span class="text-gray-800">${household.display_name}</span>
                    <button type="button" class="add-household-to-family-btn text-blue-600 hover:text-blue-900 text-sm" data-household-id="${household.household_id}" data-household-name="${household.display_name}">
                        <i class="fas fa-plus mr-1"></i> Add
                    </button>
                `;
                availableHouseholdsSearchResults.appendChild(div);
            });
        }
    }

    // Add household to associated list from search results
    availableHouseholdsSearchResults.addEventListener('click', (event) => {
        const targetBtn = event.target.closest('.add-household-to-family-btn');
        if (targetBtn) {
            const householdId = parseInt(targetBtn.dataset.householdId);
            const householdName = targetBtn.dataset.householdName;

            // Check if already added (should be prevented by filter, but as a safeguard)
            if (!currentAssociatedHouseholds.some(h => h.household_id === householdId)) {
                currentAssociatedHouseholds.push({ household_id: householdId, display_name: householdName });
                renderAssociatedHouseholds();
                availableHouseholdsSearch.value = ''; // Clear search after adding
                filterAndRenderAvailableHouseholds(); // Re-filter to remove added item
            } else {
                showCustomModal('This household is already associated with the family.', 'alert');
            }
        }
    });

    // Remove household from associated list (event delegation)
    associatedHouseholdsList.addEventListener('click', (event) => {
        const targetBtn = event.target.closest('.remove-associated-household-btn');
        if (targetBtn) {
            const householdIdToRemove = parseInt(targetBtn.dataset.householdId);
            const removedHousehold = currentAssociatedHouseholds.find(h => h.household_id === householdIdToRemove);

            if (removedHousehold) {
                currentAssociatedHouseholds = currentAssociatedHouseholds.filter(h => h.household_id !== householdIdToRemove);
                renderAssociatedHouseholds();
                filterAndRenderAvailableHouseholds(); // Re-filter to show removed item
            }
        }
    });

    // Debounce function
    const debounce = (func, delay) => {
        let timeout;
        return function(...args) {
            const context = this;
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(context, args), delay);
        };
    };

    // Live search for available households
    availableHouseholdsSearch.addEventListener('input', debounce(() => {
        filterAndRenderAvailableHouseholds();
    }, 300));


    async function openFamilyModal(family = null) {
        familyForm.reset();
        familyIdInput.value = '';
        currentAssociatedHouseholds = []; // Reset for new/edit
        availableHouseholdsSearch.value = ''; // Clear search input in modal

        // Fetch all households for association management
        await fetchAllHouseholdsForAssociation(); // This populates `allHouseholds`

        if (family) {
            familyModalTitle.textContent = 'Edit Family';
            familyIdInput.value = family.family_id;
            familyNameInput.value = family.family_name;

            // Populate currentAssociatedHouseholds from fetched data
            if (family.associated_household_ids && family.associated_household_ids.length > 0) {
                currentAssociatedHouseholds = allHouseholds.filter(
                    h => family.associated_household_ids.includes(h.household_id)
                );
            }
        } else {
            familyModalTitle.textContent = 'Add New Family';
        }
        renderAssociatedHouseholds(); // Render both associated and filter available
        familyModal.classList.remove('hidden');
    }

    function closeFamilyModal() {
        familyModal.classList.add('hidden');
        familyForm.reset();
        currentAssociatedHouseholds = []; // Clear state
        allHouseholds = []; // Clear all households cache
        availableHouseholdsSearch.value = ''; // Clear search input
        availableHouseholdsSearchResults.innerHTML = ''; // Clear search results
        noAvailableHouseholdsSearch.classList.add('hidden'); // Hide no results message
    }

    async function openViewFamilyModal(familyId) {
        const family = await fetchFamilyDetails(familyId);
        if (family) {
            viewFamilyIdSpan.textContent = family.family_id;
            viewFamilyNameSpan.textContent = family.family_name;
            viewTotalHouseholdsSpan.textContent = family.total_households;
            viewTotalMembersSpan.textContent = family.total_members;

            // Clear previous household list
            viewHouseholdsList.innerHTML = '';

            if (family.households && family.households.length > 0) {
                noAssociatedHouseholdsView.classList.add('hidden');
                family.households.forEach(household => {
                    const li = document.createElement('li');
                    li.className = 'bg-white p-3 rounded-md shadow-sm border border-gray-100 flex justify-between items-center';
                    li.innerHTML = `
                        <div>
                            <p class="font-semibold text-gray-800">Address: ${household.address}</p>
                            <p class="text-sm text-gray-600">Head: ${household.household_head_name || 'N/A'}</p>
                            <p class="text-sm text-gray-600">Members: ${household.total_member_count}</p>
                        </div>
                        <button class="view-household-btn bg-blue-100 text-blue-800 text-xs px-3 py-1 rounded-full hover:bg-blue-200" data-household-id="${household.household_id}">
                            View Household
                        </button>
                    `;
                    viewHouseholdsList.appendChild(li);
                });
            } else {
                noAssociatedHouseholdsView.classList.remove('hidden');
            }
            viewFamilyModal.classList.remove('hidden');
        }
    }

    function closeViewFamilyModal() {
        viewFamilyModal.classList.add('hidden');
    }

    // Open Household Details Modal
    async function openHouseholdDetailsModal(householdId) {
        const household = await fetchHouseholdDetails(householdId);
        if (household) {
            householdDetailsAddressSpan.textContent = household.address;
            householdDetailsIdSpan.textContent = household.household_id;
            householdDetailsHeadSpan.textContent = household.household_head_name || 'N/A';
            householdDetailsZoneSpan.textContent = household.zone_name || 'N/A';
            householdDetailsIncomeSpan.textContent = household.monthly_household_income ? `₱${parseFloat(household.monthly_household_income).toLocaleString('en-PH', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}` : 'N/A';
            householdDetailsTypeSpan.textContent = household.household_type_name || 'N/A';
            householdDetailsWaterSourceSpan.textContent = household.water_source_name || 'N/A';
            householdDetailsCookingFuelSpan.textContent = household.cooking_fuel_name || 'N/A';
            householdDetailsTenureSpan.textContent = household.tenure_status_name || 'N/A';
            householdDetailsIncomeSourceSpan.textContent = household.income_source_name || 'N/A';
            householdDetailsHouseMaterialSpan.textContent = household.house_material_name || 'N/A';
            householdDetailsHasToiletSpan.textContent = household.has_toilet ? 'Yes' : 'No';
            householdDetailsHasElectricitySpan.textContent = household.has_electricity ? 'Yes' : 'No';
            householdDetailsHasWaterSpan.textContent = household.has_water ? 'Yes' : 'No';
            householdDetailsHasInternetSpan.textContent = household.has_internet ? 'Yes' : 'No';

            // Clear previous members list
            householdMembersTableBody.innerHTML = '';

            if (household.members && household.members.length > 0) {
                noHouseholdMembers.classList.add('hidden');
                household.members.forEach(member => {
                    const row = householdMembersTableBody.insertRow();
                    row.className = 'hover:bg-gray-50';
                    row.innerHTML = `
                        <td class="px-3 py-2 whitespace-nowrap text-sm text-gray-900">${member.full_name}</td>
                        <td class="px-3 py-2 whitespace-nowrap text-sm text-gray-500">${member.relationship_to_head || 'N/A'}</td>
                        <td class="px-3 py-2 whitespace-nowrap text-sm text-gray-500">${member.gender || 'N/A'}</td>
                        <td class="px-3 py-2 whitespace-nowrap text-sm text-gray-500">${member.birth_date || 'N/A'}</td>
                        <td class="px-3 py-2 whitespace-nowrap text-sm text-gray-500">${member.civil_status || 'N/A'}</td>
                        <td class="px-3 py-2 whitespace-nowrap text-sm text-gray-500">${member.occupation || 'N/A'}</td>
                    `;
                });
            } else {
                noHouseholdMembers.classList.remove('hidden');
            }
            viewHouseholdDetailsModal.classList.remove('hidden');
        }
    }

    // Close Household Details Modal
    function closeHouseholdDetailsModal() {
        viewHouseholdDetailsModal.classList.add('hidden');
    }

    // --- Pagination & Search UI Updates ---
    function updatePaginationControls() {
        paginationInfo.textContent = `Page ${currentPage} of ${totalPages}`;
        prevPageBtn.disabled = currentPage <= 1;
        nextPageBtn.disabled = currentPage >= totalPages;

        prevPageBtn.classList.toggle('opacity-50', currentPage <= 1);
        prevPageBtn.classList.toggle('cursor-not-allowed', currentPage <= 1);
        nextPageBtn.classList.toggle('opacity-50', currentPage >= totalPages);
        nextPageBtn.classList.toggle('cursor-not-allowed', currentPage >= totalPages);
    }

    // --- Event Listeners ---

    // Check if addNewFamilyBtn exists before adding listener
    if (addNewFamilyBtn) {
        addNewFamilyBtn.addEventListener('click', () => openFamilyModal());
    } else {
        console.error("addNewFamilyBtn element not found. Add new family functionality will not be available.");
    }
    
    cancelFamilyFormBtn.addEventListener('click', closeFamilyModal);
    closeViewFamilyModalBtn.addEventListener('click', closeViewFamilyModal);
    closeHouseholdDetailsModalBtn.addEventListener('click', closeHouseholdDetailsModal);


    familyForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        const formData = {
            family_id: familyIdInput.value || null,
            family_name: familyNameInput.value.trim(), // familyName is mapped to main_family_surname
            associated_households: currentAssociatedHouseholds.map(h => h.household_id) // Send only IDs
        };

        if (!formData.family_name) {
            showCustomModal('Family Name (Surname) is required.', 'alert');
            return;
        }

        try {
            const result = await saveFamily(formData);
            showCustomModal(result.message, 'alert', () => {
                closeFamilyModal();
                fetchAndRenderFamilies();
            });
        } catch (error) {
            // Error handled in saveFamily function
        }
    });

    familiesTableBody.addEventListener('click', async (event) => {
        if (event.target.closest('.edit-btn')) {
            const familyId = event.target.closest('.edit-btn').dataset.familyId;
            const family = await fetchFamilyDetails(familyId);
            if (family) {
                openFamilyModal(family);
            }
        } else if (event.target.closest('.delete-btn')) {
            const familyId = event.target.closest('.delete-btn').dataset.familyId;
            showCustomModal('Are you sure you want to delete this family? This action cannot be undone.', 'confirm',
                () => deleteFamily(familyId) // onConfirm
            );
        } else if (event.target.closest('.view-btn')) {
            const familyId = event.target.closest('.view-btn').dataset.familyId;
            openViewFamilyModal(familyId);
        }
    });

    // Event listener for "View Household" buttons inside the Family View Modal
    viewHouseholdsList.addEventListener('click', async (event) => {
        if (event.target.closest('.view-household-btn')) {
            const householdId = event.target.closest('.view-household-btn').dataset.householdId;
            openHouseholdDetailsModal(householdId);
        }
    });


    if (prevPageBtn) prevPageBtn.addEventListener('click', () => {
        if (currentPage > 1) {
            currentPage--;
            fetchAndRenderFamilies();
        }
    });

    if (nextPageBtn) nextPageBtn.addEventListener('click', () => {
        if (currentPage < totalPages) {
            currentPage++;
            fetchAndRenderFamilies();
        }
    });

    // Search input with debounce
    let searchTimeout;
    if (familySearch) {
        familySearch.addEventListener('input', () => {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                currentSearchTerm = familySearch.value.trim().toLowerCase();
                currentPage = 1; // Reset to first page on new search
                fetchAndRenderFamilies();
            }, 300); // 300ms debounce
        });
    }

    // Function to hide edit/delete buttons based on user role
    function hideEditDeleteForUser() {
        // userRole is defined in the PHP file and passed as a global JS variable
        if (typeof userRole !== 'undefined' && userRole === 'user') {
            document.querySelectorAll('.edit-btn, .delete-btn, .edit-family-btn, .delete-family-btn').forEach(function(btn) {
                btn.style.display = 'none';
            });
            // Hide add new family button
            if (addNewFamilyBtn) { // Use the already defined addNewFamilyBtn
                addNewFamilyBtn.style.display = 'none';
            }
        }
    }

    // --- Filter Modal Logic ---
    if (openFilterModalBtn) {
        openFilterModalBtn.addEventListener('click', () => {
            // Set filter modal fields to currentFilters values before opening
            sortBy.value = currentFilters.sort_by;
            sortOrder.value = currentFilters.sort_order;
            filterRecordsPerPage.value = currentFilters.records_per_page; // Set records per page value

            filterModal.classList.remove('hidden');
        });
    }

    filterForm.addEventListener('submit', (event) => {
        event.preventDefault();
        // Update currentFilters with values from the form
        currentFilters.sort_by = sortBy.value;
        currentFilters.sort_order = sortOrder.value;
        
        // Update records per page and reset current page if it changes
        const newRecordsPerPage = parseInt(filterRecordsPerPage.value);
        if (newRecordsPerPage !== currentFilters.records_per_page) {
            currentFilters.records_per_page = newRecordsPerPage;
            currentPage = 1; // Reset to first page if records per page changes
        }

        filterModal.classList.add('hidden'); // Close modal
        fetchAndRenderFamilies(); // Re-fetch data with new filters
    });

    clearFiltersBtn.addEventListener('click', () => {
        // Reset all filter fields to default values
        sortBy.value = 'family_name'; // Default sort
        sortOrder.value = 'ASC';      // Default order
        filterRecordsPerPage.value = '10'; // Default records per page

        // Also reset the currentFilters object
        currentFilters = {
            sort_by: 'family_name',
            sort_order: 'ASC',
            records_per_page: 10
        };

        filterModal.classList.add('hidden'); // Close modal
        currentPage = 1; // Reset to first page
        fetchAndRenderFamilies(); // Re-fetch data without filters
    });

    // Close filter modal when clicking outside
    filterModal.addEventListener('click', (event) => {
        if (event.target === filterModal) {
            filterModal.classList.add('hidden');
        }
    });

    // Initial fetch when the page loads
    fetchAndRenderFamilies();
    hideEditDeleteForUser(); // Call this function on page load
});
