document.addEventListener('DOMContentLoaded', () => {
    console.log('Families page loaded!');

    const hierarchyContainer = document.getElementById('hierarchyContainer');
    const familySearch = document.getElementById('familySearch');
    const addNewFamilyBtn = document.getElementById('addNewFamilyBtn');
    const noResultsMessage = document.getElementById('noFamilyResults');

    // Pagination elements
    const prevPageBtn = document.getElementById('prevPageBtn');
    const nextPageBtn = document.getElementById('nextPageBtn');
    const paginationInfo = document.getElementById('paginationInfo');

    let currentPage = 1;
    const itemsPerPage = 10;
    let totalPages = 1;
    let currentSearchTerm = '';

    // Family Modal elements
    const familyModal = document.getElementById('familyModal');
    const familyModalTitle = document.getElementById('familyModalTitle');
    const familyForm = document.getElementById('familyForm');
    const familyIdInput = document.getElementById('familyId');
    const familyNameInput = document.getElementById('familyName');
    const familyNotesInput = document.getElementById('familyNotes');
    const closeFamilyModalBtn = document.getElementById('closeFamilyModalBtn');
    const cancelFamilyFormBtn = document.getElementById('cancelFamilyFormBtn');

    // Household Add/Edit Modal elements
    const householdModal = document.getElementById('householdModal');
    const householdModalTitle = document.getElementById('householdModalTitle');
    const householdForm = document.getElementById('householdForm');
    const householdIdInput = document.getElementById('householdId');
    const householdFamilyIdInput = document.getElementById('householdFamilyId');
    const householdFamilyNameDisplay = document.getElementById('householdFamilyNameDisplay');
    const selectFamilyForHouseholdBtn = document.getElementById('selectFamilyForHouseholdBtn');
    const clearFamilyForHouseholdBtn = document.getElementById('clearFamilyForHouseholdBtn');

    // New Household Form Fields (inside householdModal)
    const householdHeadIndividualIdInput = document.getElementById('householdHeadIndividualId');
    const householdHeadNameDisplay = document.getElementById('householdHeadNameDisplay');
    const selectHouseholdHeadBtn = document.getElementById('selectHouseholdHeadBtn');
    const zoneIdSelect = document.getElementById('zoneId');
    const addressInput = document.getElementById('address');
    const waterSourceIdSelect = document.getElementById('waterSourceId');
    const hasToiletCheckbox = document.getElementById('hasToilet');
    const hasElectricityCheckbox = document.getElementById('hasElectricity');
    const cookingFuelIdSelect = document.getElementById('cookingFuelId');
    const tenureStatusIdSelect = document.getElementById('tenureStatusId');
    const incomeSourceIdSelect = document.getElementById('incomeSourceId');
    const monthlyIncomeInput = document.getElementById('monthlyIncome');
    const householdTypeIdSelect = document.getElementById('householdTypeId');
    const houseMaterialIdSelect = document.getElementById('houseMaterialId');
    const closeHouseholdModalBtn = document.getElementById('closeHouseholdModalBtn');
    const cancelHouseholdFormBtn = document.getElementById('cancelHouseholdFormBtn');

    // Select Individual Modal (for Household Head)
    const selectIndividualModal = document.getElementById('selectIndividualModal');
    const searchIndividualForHousehold = document.getElementById('searchIndividualForHousehold');
    const availableIndividualsList = document.getElementById('availableIndividualsList');
    const closeSelectIndividualModalBtn = document.getElementById('closeSelectIndividualModalBtn');
    const closeSelectIndividualModalBtnBottom = document.getElementById('closeSelectIndividualModalBtnBottom');

    // Select Family Modal (for linking household)
    const selectFamilyModal = document.getElementById('selectFamilyModal');
    const searchFamilyForHousehold = document.getElementById('searchFamilyForHousehold');
    const availableFamiliesList = document.getElementById('availableFamiliesList');
    const closeSelectFamilyModalBtn = document.getElementById('closeSelectFamilyModalBtn');
    const closeSelectFamilyModalBtnBottom = document.getElementById('closeSelectFamilyModalBtnBottom');

    // NEW: Select Household to Assign Modal Elements
    const selectHouseholdToAssignModal = document.getElementById('selectHouseholdToAssignModal');
    const searchHouseholdToAssign = document.getElementById('searchHouseholdToAssign');
    const availableHouseholdsToAssignList = document.getElementById('availableHouseholdsToAssignList');
    const closeSelectHouseholdToAssignModalBtn = document.getElementById('closeSelectHouseholdToAssignModalBtn');
    const closeSelectHouseholdToAssignModalBtnBottom = document.getElementById('closeSelectHouseholdToAssignModalBtnBottom');
    let tempFamilyIdForHouseholdAssignment = null; // To store family_id when opening this modal


    // Custom Modal elements (for alerts/confirms)
    const customModal = document.getElementById('customModal');
    const customModalTitle = document.getElementById('customModalTitle');
    const customModalMessage = document.getElementById('customModalMessage');
    const customModalConfirmBtn = document.getElementById('customModalConfirm');
    const customModalCancelBtn = document.getElementById('customModalCancel');
    let customModalCallback = null; // To store the callback for confirm actions

    // --- Mobile Menu Elements and Logic (Copied from Overview) ---
    const mobileMenuButton = document.getElementById('mobileMenuButton');
    const mainSidebar = document.getElementById('mainSidebar');
    const mobileMenuOverlay = document.getElementById('mobileMenuOverlay');

    if (mobileMenuButton && mainSidebar && mobileMenuOverlay) {
        console.log('Mobile menu elements found. Attaching event listeners.');
        mobileMenuButton.addEventListener('click', () => {
            mainSidebar.classList.toggle('open');
            mobileMenuOverlay.classList.toggle('open');
            document.body.classList.toggle('overflow-hidden-mobile'); // Prevent scroll on body when menu is open
            console.log('Mobile menu button clicked. Sidebar open:', mainSidebar.classList.contains('open'));
            console.log('Overlay open:', mobileMenuOverlay.classList.contains('open'));
            console.log('Body overflow hidden:', document.body.classList.contains('overflow-hidden-mobile'));
        });

        mobileMenuOverlay.addEventListener('click', () => {
            mainSidebar.classList.remove('open');
            mobileMenuOverlay.classList.remove('open');
            document.body.classList.remove('overflow-hidden-mobile');
            console.log('Overlay clicked. Sidebar open:', mainSidebar.classList.contains('open'));
        });

        const navLinks = mainSidebar.querySelectorAll('nav a');
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                if (window.innerWidth < 1024) {
                    mainSidebar.classList.remove('open');
                    mobileMenuOverlay.classList.remove('open');
                    document.body.classList.remove('overflow-hidden-mobile');
                    console.log('Nav link clicked. Sidebar closed.');
                }
            });
        });
    } else {
        console.error('One or more mobile menu elements not found:', { mobileMenuButton, mainSidebar, mobileMenuOverlay });
    }


    // --- Utility Functions ---

    /**
     * Shows a custom modal for alerts or confirmations.
     * @param {string} message The message to display.
     * @param {'alert'|'confirm'} type The type of modal (alert or confirm).
     * @param {function} callback Function to call on confirm (optional).
     */
    function showCustomModal(message, type, callback = null) {
        customModalMessage.innerHTML = message; // Changed to innerHTML to support rich text from view-household-btn
        customModalCallback = callback; // Store the callback

        // Reset buttons visibility
        customModalConfirmBtn.classList.remove('hidden');
        customModalCancelBtn.classList.add('hidden');

        if (type === 'confirm') {
            customModalTitle.textContent = 'Confirmation';
            customModalConfirmBtn.textContent = 'Confirm';
            customModalCancelBtn.classList.remove('hidden'); // Show cancel button for confirm
        } else { // type === 'alert'
            customModalTitle.textContent = 'Notification';
            customModalConfirmBtn.textContent = 'OK';
        }

        customModal.classList.remove('hidden');
    }

    // Event listeners for custom modal buttons
    customModalConfirmBtn.addEventListener('click', () => {
        customModal.classList.add('hidden');
        if (customModalCallback) {
            customModalCallback(true); // Call callback with true for confirm
            customModalCallback = null; // Clear callback
        }
    });

    customModalCancelBtn.addEventListener('click', () => {
        customModal.classList.add('hidden');
        if (customModalCallback) {
            customModalCallback(false); // Call callback with false for cancel
            customModalCallback = null; // Clear callback
        }
    });


    // Override window.confirm and window.alert for consistent UX
    window.confirm = function(message) {
        return new Promise(resolve => {
            showCustomModal(message, 'confirm', (confirmed) => {
                resolve(confirmed);
            });
        });
    };
    window.alert = function(message) {
        showCustomModal(message, 'alert');
    };


    // --- API Fetching Functions ---

    /**
     * Fetches lookup data from the API.
     * @param {string} type The type of lookup data to fetch (e.g., 'zones', 'water_source').
     * @returns {Promise<Array>} A promise that resolves to an array of lookup items.
     */
    async function fetchLookupData(type) {
        try {
            const response = await fetch(`../api/lookups.php?type=${type}`);
            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`Failed to fetch ${type} data. Status: ${response.status}. Response: ${errorText}`);
            }
            const result = await response.json();
            if (result.status === 'success' && result.data) {
                return result.data;
            } else {
                console.error(`API Error for ${type}:`, result.message);
                return [];
            }
        } catch (error) {
            console.error(`Error fetching ${type} lookup data:`, error);
            showCustomModal(`Error loading ${type}: ${error.message}`, 'alert');
            return [];
        }
    }

    /**
     * Populates a select element with options from lookup data.
     * @param {HTMLSelectElement} selectElement The select element to populate.
     * @param {Array<Object>} data The array of lookup items ({id: value, name: "Text"}).
     * @param {string} selectedId The ID of the item to be selected (optional).
     */
    function populateSelect(selectElement, data, selectedId = null) {
        selectElement.innerHTML = '<option value="">Select an option</option>'; // Default option
        data.forEach(item => {
            const option = document.createElement('option');
            option.value = item.id;
            option.textContent = item.name;
            if (selectedId && item.id == selectedId) { // Use == for type coercion if IDs might be mixed string/number
                option.selected = true;
            }
            selectElement.appendChild(option);
        });
    }

    /**
     * Fetches individuals for the household head selection modal.
     * @param {string} searchTerm
     * @returns {Promise<Array>}
     */
    async function fetchIndividualsForSelection(searchTerm = '') {
        try {
            const response = await fetch(`../api/individuals.php?search=${encodeURIComponent(searchTerm)}&limit=50`); // Fetch more if needed
            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`Failed to fetch individuals. Status: ${response.status}. Response: ${errorText}`);
            }
            const result = await response.json();
            if (result.status === 'success' && result.data) {
                return result.data;
            } else {
                console.error('API Error for individuals:', result.message);
                return [];
            }
        } catch (error) {
            console.error('Error fetching individuals for selection:', error);
            showCustomModal(`Error loading individuals: ${error.message}`, 'alert');
            return [];
        }
    }

    /**
     * Renders the list of individuals in the selection modal.
     * @param {Array<Object>} individuals
     */
    function renderIndividualsForSelection(individuals) {
        availableIndividualsList.innerHTML = '';
        if (individuals.length === 0) {
            availableIndividualsList.innerHTML = '<p class="text-center text-gray-500 py-4">No individuals found.</p>';
            return;
        }

        individuals.forEach(individual => {
            const div = document.createElement('div');
            div.className = 'p-3 hover:bg-gray-100 cursor-pointer border-b border-gray-200 last:border-b-0';
            div.dataset.individualId = individual.individual_id;
            div.dataset.individualName = `${individual.first_name} ${individual.middle_name ? individual.middle_name + ' ' : ''}${individual.surname}`;
            div.innerHTML = `<p class="font-semibold text-gray-800">${div.dataset.individualName}</p><p class="text-sm text-gray-500">ID: ${individual.individual_id} - ${individual.address || 'N/A'}</p>`;
            availableIndividualsList.appendChild(div);
        });
    }

    /**
     * Fetches existing households for the assignment modal.
     * @param {string} searchTerm
     * @returns {Promise<Array>}
     */
    async function fetchHouseholdsForAssignment(searchTerm = '') {
        try {
            const response = await fetch(`../api/families.php?action=get_all_households_for_selection&search=${encodeURIComponent(searchTerm)}`);
            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`Failed to fetch households for assignment. Status: ${response.status}. Response: ${errorText}`);
            }
            const result = await response.json();
            if (result.status === 'success' && result.data) {
                return result.data;
            } else {
                console.error('API Error for households for assignment:', result.message);
                return [];
            }
        } catch (error) {
            console.error('Error fetching households for assignment:', error);
            showCustomModal(`Error loading households for assignment: ${error.message}`, 'alert');
            return [];
        }
    }

    /**
     * Renders the list of households in the assignment selection modal.
     * @param {Array<Object>} households
     */
    function renderHouseholdsForAssignment(households) {
        availableHouseholdsToAssignList.innerHTML = '';
        if (households.length === 0) {
            availableHouseholdsToAssignList.innerHTML = '<p class="text-center text-gray-500 py-4">No households found.</p>';
            return;
        }

        households.forEach(household => {
            const div = document.createElement('div');
            div.className = 'p-3 hover:bg-gray-100 cursor-pointer border-b border-gray-200 last:border-b-0';
            div.dataset.householdId = household.household_id;
            div.dataset.householdAddress = household.address; // Store address for display
            div.innerHTML = `<p class="font-semibold text-gray-800">Address: ${household.address || 'N/A'}</p>
                             <p class="text-sm text-gray-500">Head: ${household.household_head_name || 'N/A'}</p>
                             <p class="text-sm text-gray-500">Zone: ${household.zone_name || 'N/A'}</p>`;
            availableHouseholdsToAssignList.appendChild(div);
        });
    }


    // --- Modal Functions ---

    function openFamilyModal() {
        familyModal.classList.remove('hidden');
        // Reset form for new entry
        familyForm.reset();
        familyIdInput.value = '';
        familyModalTitle.textContent = 'Add New Family';
    }

    async function openEditFamilyModal(familyId) {
        try {
            const response = await fetch(`../api/families.php?family_id=${familyId}`);
            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`Failed to fetch family details for editing. Status: ${response.status}. Response: ${errorText}`);
            }
            const result = await response.json();
            console.log('API Response (Single Family for Edit):', result);

            if (result.status === 'success' && result.data) {
                const family = result.data;
                document.getElementById('familyId').value = family.family_id || '';
                document.getElementById('familyName').value = family.family_name || '';
                document.getElementById('familyNotes').value = family.notes || '';

                familyModalTitle.textContent = 'Edit Family';
                familyModal.classList.remove('hidden');
            } else {
                showCustomModal(result.message || 'Family details not found for editing.', 'alert');
            }
        } catch (error) {
            console.error('Error fetching family for edit:', error);
            showCustomModal(`Error loading family details for edit: ${error.message}`, 'alert');
        }
    }

    function closeFamilyModal() {
        familyModal.classList.add('hidden');
        familyForm.reset(); // Clear form on close
    }

    async function openHouseholdModal(householdData = null) {
        householdModal.classList.remove('hidden');
        householdForm.reset(); // Clear form initially
        householdIdInput.value = ''; // Ensure no ID for new household

        // Reset Household Head and Family displays
        householdHeadIndividualIdInput.value = '';
        householdHeadNameDisplay.value = 'Not selected';
        householdFamilyIdInput.value = '';
        householdFamilyNameDisplay.textContent = 'Not selected';
        clearFamilyForHouseholdBtn.classList.add('hidden');


        householdModalTitle.textContent = 'Add New Household';

        // Load all lookup data for dropdowns
        const [zones, waterSources, cookingFuels, tenureStatuses, incomeSources, householdTypes, houseMaterials] = await Promise.all([
            fetchLookupData('zone'),
            fetchLookupData('water_source'),
            fetchLookupData('cooking_fuel'),
            fetchLookupData('tenure_status'),
            fetchLookupData('income_source'),
            fetchLookupData('household_type'),
            fetchLookupData('house_material')
        ]);

        populateSelect(zoneIdSelect, zones);
        populateSelect(waterSourceIdSelect, waterSources);
        populateSelect(cookingFuelIdSelect, cookingFuels);
        populateSelect(tenureStatusIdSelect, tenureStatuses);
        populateSelect(incomeSourceIdSelect, incomeSources);
        populateSelect(householdTypeIdSelect, householdTypes);
        populateSelect(houseMaterialIdSelect, houseMaterials);


        if (householdData) {
            // Editing an existing household
            householdModalTitle.textContent = 'Edit Household';
            householdIdInput.value = householdData.household_id;
            zoneIdSelect.value = householdData.zone_id || '';
            addressInput.value = householdData.address || '';

            // Set Household Head
            householdHeadIndividualIdInput.value = householdData.household_head_individual_id || '';
            householdHeadNameDisplay.value = householdData.household_head_first_name && householdData.household_head_surname
                ? `${householdData.household_head_first_name} ${householdData.household_head_surname}`
                : 'Not selected';

            // Set Associated Family
            if (householdData.family_id) {
                householdFamilyIdInput.value = householdData.family_id;
                // Fetch family name if it's not directly provided (should be if household is fetched via getHouseholdDetails)
                try {
                    const familyResponse = await fetch(`../api/families.php?family_id=${householdData.family_id}`);
                    const familyResult = await familyResponse.json();
                    if (familyResult.status === 'success' && familyResult.data) {
                        householdFamilyNameDisplay.textContent = familyResult.data.family_name;
                        clearFamilyForHouseholdBtn.classList.remove('hidden');
                    } else {
                        householdFamilyNameDisplay.textContent = 'Family not found';
                        console.error('Family not found for household display:', householdData.family_id);
                    }
                } catch (error) {
                    console.error('Error fetching family name for household display:', error);
                    householdFamilyNameDisplay.textContent = 'Error loading family';
                }
            } else {
                householdFamilyIdInput.value = '';
                householdFamilyNameDisplay.textContent = 'Not selected';
                clearFamilyForHouseholdBtn.classList.add('hidden');
            }

            // Populate other new fields
            waterSourceIdSelect.value = householdData.water_source_id || '';
            hasToiletCheckbox.checked = householdData.has_toilet == 1;
            hasElectricityCheckbox.checked = householdData.has_electricity == 1;
            cookingFuelIdSelect.value = householdData.cooking_fuel_id || '';
            tenureStatusIdSelect.value = householdData.tenure_status_id || '';
            incomeSourceIdSelect.value = householdData.income_source_id || '';
            monthlyIncomeInput.value = householdData.monthly_income || '';
            householdTypeIdSelect.value = householdData.household_type_id || '';
            houseMaterialIdSelect.value = householdData.house_material_id || '';

        }
    }

    function closeHouseholdModal() {
        householdModal.classList.add('hidden');
        householdForm.reset(); // Clear form on close
        // Reset specific fields that might hold non-form data or need explicit reset
        householdHeadIndividualIdInput.value = '';
        householdHeadNameDisplay.value = 'Not selected';
        householdFamilyIdInput.value = '';
        householdFamilyNameDisplay.textContent = 'Not selected';
        clearFamilyForHouseholdBtn.classList.add('hidden');
    }

    function openSelectIndividualModal() {
        selectIndividualModal.classList.remove('hidden');
        searchIndividualForHousehold.value = '';
        fetchIndividualsForSelection().then(renderIndividualsForSelection);
    }

    function closeSelectIndividualModal() {
        selectIndividualModal.classList.add('hidden');
    }

    function openSelectFamilyModal() {
        selectFamilyModal.classList.remove('hidden');
        searchFamilyForHousehold.value = '';
        fetchFamiliesForSelection().then(renderFamiliesForSelection);
    }

    function closeSelectFamilyModal() {
        selectFamilyModal.classList.add('hidden');
    }

    // NEW: Open/Close Select Household to Assign Modal
    function openSelectHouseholdToAssignModal(familyId) {
        tempFamilyIdForHouseholdAssignment = familyId; // Store the target family ID
        selectHouseholdToAssignModal.classList.remove('hidden');
        searchHouseholdToAssign.value = ''; // Clear search on open
        fetchHouseholdsForAssignment().then(renderHouseholdsForAssignment); // Load all households
    }

    function closeSelectHouseholdToAssignModal() {
        selectHouseholdToAssignModal.classList.add('hidden');
        tempFamilyIdForHouseholdAssignment = null; // Clear stored family ID
    }


    // --- API Fetch and Render Families Hierarchy ---

    async function fetchAndRenderFamilies() {
        hierarchyContainer.innerHTML = `<p id="loadingFamilies" class="text-center text-gray-500 py-8">Loading families and households...</p>`;
        if (noResultsMessage) noResultsMessage.classList.add('hidden');
        try {
            const response = await fetch(`../api/families.php?page=${currentPage}&limit=${itemsPerPage}&search=${encodeURIComponent(currentSearchTerm)}`);
            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`Failed to fetch families. Status: ${response.status}. Response: ${errorText}`);
            }
            const result = await response.json();
            console.log('API Response (Families List):', result);

            if (result.status === 'success' && result.data) {
                renderFamiliesHierarchy(result.data);
                totalPages = result.totalPages;
                updatePaginationInfo(result.totalItems);
            } else {
                hierarchyContainer.innerHTML = ''; // Clear loading message
                if (noResultsMessage) noResultsMessage.classList.remove('hidden');
                updatePaginationInfo(0);
            }
        } catch (error) {
            console.error('Error fetching and rendering families:', error);
            hierarchyContainer.innerHTML = `<p class="text-center text-red-500 py-8">Error loading data: ${error.message}</p>`;
            if (noResultsMessage) noResultsMessage.classList.add('hidden');
            updatePaginationInfo(0);
        }
    }

    /**
     * Renders the family hierarchy, robustly handling missing or malformed data.
     * Includes collapsible household sections.
     * @param {Array<Object>} families The array of family data from the API.
     */
    function renderFamiliesHierarchy(families) {
        hierarchyContainer.innerHTML = '';
        if (!Array.isArray(families) || families.length === 0) {
            if (noResultsMessage) {
                noResultsMessage.textContent = currentSearchTerm ? `No families found matching "${currentSearchTerm}".` : `No families to display.`;
                noResultsMessage.classList.remove('hidden');
            }
            return;
        } else {
            if (noResultsMessage) noResultsMessage.classList.add('hidden');
        }

        families.forEach(family => {
            // Calculate totals for direct display in the card
            const totalHouseholds = (typeof family.household_ids === 'string' && family.household_ids.trim() !== '')
                ? family.household_ids.split(',').filter(Boolean).length
                : 0;
            const totalIndividuals = (typeof family.individual_names === 'string' && family.individual_names.trim() !== '')
                ? family.individual_names.split(';').filter(Boolean).length
                : 0;

            const familyDiv = document.createElement('div');
            familyDiv.className = 'family-card border border-gray-200 rounded-lg shadow-sm mb-4 bg-white';
            familyDiv.innerHTML = `
                <div class="family-header p-4 bg-gray-50 flex justify-between items-center cursor-pointer hover:bg-gray-100 rounded-t-lg transition-colors duration-200" data-family-id="${family.family_id}">
                    <h3 class="text-xl font-bold text-primary-dark-green flex-1">
                        <i class="fas fa-users mr-2"></i> Family: ${family.family_name || 'N/A'}
                        <span class="text-sm font-normal text-gray-500 ml-2">(ID: ${family.family_id})</span>
                    </h3>
                    <div class="family-actions flex items-center space-x-2">
                        <button class="view-family-btn bg-green-100 text-green-700 py-1 px-3 rounded-md hover:bg-green-200 transition-colors" data-family-id="${family.family_id}">
                            <i class="fas fa-eye"></i> View
                        </button>
                        <button class="edit-family-btn bg-blue-200 text-blue-800 py-1 px-3 rounded-md hover:bg-blue-300 transition-colors" data-family-id="${family.family_id}">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <button class="delete-family-btn bg-red-200 text-red-800 py-1 px-3 rounded-md hover:bg-red-300 transition-colors" data-family-id="${family.family_id}" data-family-name="${family.family_name}">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                        <i class="fas fa-chevron-down text-gray-500 expand-icon transition-transform duration-200"></i>
                    </div>
                </div>
                <div class="households-container hidden p-4 border-t border-gray-200">
                    <p class="text-sm text-gray-600 mb-3">${family.notes || 'No family notes provided.'}</p>

                    <!-- NEW: Inline Summary Information -->
                    <div class="flex flex-wrap gap-4 mb-3">
                        <div class="bg-white rounded-lg shadow px-4 py-2 flex items-center gap-2 text-sm">
                            <i class="fas fa-home text-secondary-green"></i>
                            <span class="font-semibold text-gray-700">Households:</span>
                            <span class="text-base font-bold text-primary-dark-green">${totalHouseholds}</span>
                        </div>
                        <div class="bg-white rounded-lg shadow px-4 py-2 flex items-center gap-2 text-sm">
                            <i class="fas fa-user-friends text-blue-500"></i>
                            <span class="font-semibold text-gray-700">Individuals:</span>
                            <span class="text-base font-bold text-blue-700">${totalIndividuals}</span>
                        </div>
                    </div>

                    <button
                        class="add-household-to-family-btn bg-secondary-green text-black py-1 px-3 rounded-md shadow-sm hover:bg-opacity-90 transition-colors duration-200 text-sm font-semibold flex items-center mb-3"
                        style="color: #000 !important;"
                        data-family-id="${family.family_id}" data-family-name="${family.family_name}">
                        <i class="fas fa-plus mr-1"></i> Add Existing Household
                    </button>
                    ${(() => {
                        // Defensive parsing for household related arrays
                        const householdIds = typeof family.household_ids === 'string' && family.household_ids.trim() !== ''
                            ? family.household_ids.split(',').map(s => s.trim()).filter(Boolean)
                            : [];
                        const householdAddresses = typeof family.household_addresses === 'string' && family.household_addresses.trim() !== ''
                            ? family.household_addresses.split('; ').map(s => s.trim())
                            : [];
                        const zoneNames = typeof family.zone_names === 'string' && family.zone_names.trim() !== ''
                            ? family.zone_names.split('; ').map(s => s.trim())
                            : [];
                        const individualNames = typeof family.individual_names === 'string' && family.individual_names.trim() !== ''
                            ? family.individual_names.split('; ').map(s => s.trim())
                            : [];

                        if (householdIds.length > 0) {
                            return `
                                <h5 class="text-md font-medium text-gray-700 mb-2">Households:</h5>
                                <div class="space-y-3">
                                    ${householdIds.map((householdId, index) => {
                                        const address = householdAddresses[index] || 'N/A';
                                        const zoneName = zoneNames[index] || 'N/A';
                                        const headIndividualDisplay = individualNames[index] ? `(${individualNames[index]})` : ''; // Display head if available

                                        return `
                                            <div class="household-item border border-gray-200 p-3 rounded-md bg-white shadow-sm mb-2 flex flex-col md:flex-row md:justify-between md:items-center">
                                                <div>
                                                    <p class="font-medium text-gray-800"><i class="fas fa-house-user mr-1 text-secondary-green"></i> Address: ${address}</p>
                                                    <p class="text-sm text-gray-600 ml-5">Zone: ${zoneName}</p>
                                                    <p class="text-sm text-gray-600 ml-5">Household ID: ${householdId} ${headIndividualDisplay}</p>
                                                </div>
                                                <div class="flex space-x-2 mt-2 md:mt-0">
                                                    <button class="view-household-btn bg-green-100 text-green-700 py-1 px-3 rounded-md hover:bg-green-200 transition-colors" data-household-id="${householdId}">
                                                        <i class="fas fa-eye"></i> View
                                                    </button>
                                                    <button class="edit-household-btn bg-blue-100 text-blue-700 py-1 px-3 rounded-md hover:bg-blue-200 transition-colors" data-household-id="${householdId}">
                                                        <i class="fas fa-edit"></i> Edit
                                                    </button>
                                                    <button class="delete-household-btn bg-red-100 text-red-700 py-1 px-3 rounded-md hover:bg-red-200 transition-colors" data-household-id="${householdId}" data-household-address="${address}">
                                                        <i class="fas fa-trash"></i> Delete
                                                    </button>
                                                </div>
                                            </div>
                                        `;
                                    }).join('')}
                                </div>
                            `;
                        } else {
                            return '<p class="text-gray-500 text-sm">No households associated with this family.</p>';
                        }
                    })()}
                </div>
            `;
            hierarchyContainer.appendChild(familyDiv);
        });
    }


    function updatePaginationInfo(totalItems) {
        paginationInfo.textContent = `Page ${currentPage} of ${totalPages} (${totalItems} items)`;
        prevPageBtn.disabled = currentPage === 1;
        nextPageBtn.disabled = currentPage === totalPages || totalPages === 0;
    }

    // --- Data Submission Handlers ---

    familyForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        const familyId = familyIdInput.value;
        const familyName = familyNameInput.value.trim();
        const notes = familyNotesInput.value.trim();

        if (!familyName) {
            showCustomModal('Family Name is required.', 'alert');
            return;
        }

        const data = {
            family_id: familyId,
            family_name: familyName,
            notes: notes
        };
        const method = familyId ? 'PUT' : 'POST'; // Use PUT for update, POST for new

        try {
            const response = await fetch('../api/families.php', {
                method: method,
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            });
            const result = await response.json();

            if (response.ok && result.status === 'success') {
                showCustomModal(result.message, 'alert', () => {
                    closeFamilyModal();
                    currentPage = 1; // Go back to first page on successful add/edit
                    fetchAndRenderFamilies();
                });
            } else {
                throw new Error(result.message || 'Failed to save family.');
            }
        } catch (error) {
            console.error('Error saving family:', error);
            showCustomModal(`Error saving family: ${error.message}`, 'alert');
        }
    });

    householdForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        const householdId = householdIdInput.value;
        const zoneId = zoneIdSelect.value;
        const householdHeadIndividualId = householdHeadIndividualIdInput.value;
        const address = addressInput.value.trim();
        const familyId = householdFamilyIdInput.value; // May be empty if not linked

        // New fields
        const waterSourceId = waterSourceIdSelect.value;
        const hasToilet = hasToiletCheckbox.checked ? 1 : 0;
        const hasElectricity = hasElectricityCheckbox.checked ? 1 : 0;
        const cookingFuelId = cookingFuelIdSelect.value;
        const tenureStatusId = tenureStatusIdSelect.value;
        const incomeSourceId = incomeSourceIdSelect.value;
        const monthlyIncome = monthlyIncomeInput.value;
        const householdTypeId = householdTypeIdSelect.value;
        const houseMaterialId = houseMaterialIdSelect.value;


        if (!zoneId || !householdHeadIndividualId || !address) {
            showCustomModal('Zone, Household Head, and Address are required.', 'alert');
            return;
        }

        const data = {
            type: 'household', // Indicate this is a household operation
            household_id: householdId,
            zone_id: zoneId,
            household_head_individual_id: householdHeadIndividualId,
            address: address,
            family_id: familyId, // Include familyId to link/unlink

            // New fields
            water_source_id: waterSourceId,
            has_toilet: hasToilet,
            has_electricity: hasElectricity,
            cooking_fuel_id: cookingFuelId,
            tenure_status_id: tenureStatusId,
            income_source_id: incomeSourceId,
            monthly_income: monthlyIncome,
            household_type_id: householdTypeId,
            house_material_id: houseMaterialId
        };

        const method = householdId ? 'PUT' : 'POST'; // Use PUT for update, POST for new

        try {
            const response = await fetch('../api/families.php', {
                method: method,
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            });
            const result = await response.json();

            if (response.ok && result.status === 'success') {
                showCustomModal(result.message, 'alert', () => {
                    closeHouseholdModal();
                    currentPage = 1; // Go back to first page on successful add/edit
                    fetchAndRenderFamilies();
                });
            } else {
                throw new Error(result.message || 'Failed to save household.');
            }
        } catch (error) {
            console.error('Error saving household:', error);
            showCustomModal(`Error saving household: ${error.message}`, 'alert');
        }
    });

    // --- Event Listeners ---

    addNewFamilyBtn.addEventListener('click', openFamilyModal);
    closeFamilyModalBtn.addEventListener('click', closeFamilyModal);
    cancelFamilyFormBtn.addEventListener('click', closeFamilyModal);

    // This button still adds a new household (the primary 'Add New Household' button)
    cancelHouseholdFormBtn.addEventListener('click', closeHouseholdModal);

    // NEW: Listeners for Select Household to Assign Modal
    closeSelectHouseholdToAssignModalBtn.addEventListener('click', closeSelectHouseholdToAssignModal);
    closeSelectHouseholdToAssignModalBtnBottom.addEventListener('click', closeSelectHouseholdToAssignModal);

    searchHouseholdToAssign.addEventListener('input', debounce(async (event) => {
        const searchTerm = event.target.value.trim();
        const households = await fetchHouseholdsForAssignment(searchTerm);
        renderHouseholdsForAssignment(households);
    }, 300));

    availableHouseholdsToAssignList.addEventListener('click', async (event) => {
        const selectedDiv = event.target.closest('div[data-household-id]');
        if (selectedDiv) {
            const householdId = selectedDiv.dataset.householdId;
            // Retrieve the family ID stored when the modal was opened
            const targetFamilyId = tempFamilyIdForHouseholdAssignment;

            if (!targetFamilyId) {
                showCustomModal('Error: Target family not set for household assignment.', 'alert');
                return;
            }

            try {
                // Fetch the existing household details first to get all its current data
                const response = await fetch(`../api/families.php?household_id=${householdId}`);
                if (!response.ok) {
                    const errorText = await response.text();
                    throw new Error(`Failed to fetch household for assignment update. Status: ${response.status}. Response: ${errorText}`);
                }
                const result = await response.json();

                if (result.status === 'success' && result.data) {
                    const householdDataToUpdate = result.data;
                    // Update only the family_id for this household
                    householdDataToUpdate.family_id = targetFamilyId;
                    householdDataToUpdate.type = 'household'; // Ensure API knows it's a household update

                    const updateResponse = await fetch('../api/families.php', {
                        method: 'POST', // <-- FIXED
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            ...householdDataToUpdate,
                            action: 'update_household_family' // Add a custom action to distinguish this update
                        })
                    });
                    const updateResult = await updateResponse.json();

                    if (updateResponse.ok && updateResult.status === 'success') {
                        showCustomModal(`Household ${householdDataToUpdate.address} successfully assigned to family.`, 'alert', () => {
                            closeSelectHouseholdToAssignModal();
                            currentPage = 1; // Refresh view to show changes
                            fetchAndRenderFamilies();
                        });
                    } else {
                        throw new Error(updateResult.message || `Failed to assign household to family.`);
                    }
                } else {
                    throw new Error(result.message || 'Household details not found for assignment.');
                }
            } catch (error) {
                console.error('Error assigning household to family:', error);
                showCustomModal(`Error assigning household: ${error.message}`, 'alert');
            }
        }
    });


    // Delegated event listener for Edit/Delete Family/Household buttons
    hierarchyContainer.addEventListener('click', async (event) => {
        // --- Specific Button Handlers (Checked First) ---
        if (event.target.classList.contains('edit-family-btn')) {
            const familyId = event.target.dataset.familyId;
            openEditFamilyModal(familyId);
            return; // Exit after handling this specific button click
        }

        if (event.target.classList.contains('delete-family-btn')) {
            const familyId = event.target.dataset.familyId;
            const familyName = event.target.dataset.familyName;
            const confirmed = await window.confirm(`Are you sure you want to delete the family "${familyName}" and all its associations? This cannot be undone.`);
            if (confirmed) {
                try {
                    const response = await fetch('../api/families.php', {
                        method: 'DELETE',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ family_id: familyId, type: 'family' }) // Specify type for API
                    });
                    const result = await response.json();

                    if (response.ok && result.status === 'success') {
                        showCustomModal(`${familyName} deleted successfully!`, 'alert', () => {
                            currentPage = 1;
                            fetchAndRenderFamilies();
                        });
                    } else {
                        throw new Error(result.message || `Failed to delete family: ${response.statusText}`);
                    }
                } catch (error) {
                    console.error('Error deleting family:', error);
                    showCustomModal(`Error deleting family: ${error.message}`, 'alert');
                }
            }
            return; // Exit after handling this specific button click
        }

        if (event.target.classList.contains('view-household-btn')) {
            const householdId = event.target.dataset.householdId;
            try {
                const response = await fetch(`../api/families.php?household_id=${householdId}`); // Use the new GET endpoint for single household
                if (!response.ok) {
                    const errorText = await response.text();
                    throw new Error(`Failed to fetch household details for viewing. Status: ${response.status}. Response: ${errorText}`);
                }
                const result = await response.json();
                console.log('API Response (Single Household for View):', result);

                if (result.status === 'success' && result.data) {
                    const household = result.data;
                    // Format monthly_income with commas
                    const formattedMonthlyIncome = household.monthly_income ? `₱${parseFloat(household.monthly_income).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}` : 'N/A';

                    let detailsHtml = `
                        <div class="space-y-4 text-left">
                            <h4 class="text-lg font-semibold text-gray-800 border-b pb-2 mb-2">Household Details (ID: ${household.household_id})</h4>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <!-- Basic Information -->
                                <div class="col-span-1 md:col-span-2">
                                    <h5 class="details-section-heading">Basic Information</h5>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Household Head:</label>
                                    <p class="detail-value">${household.household_head_first_name} ${household.household_head_surname || ''} (ID: ${household.household_head_individual_id})</p>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Associated Family:</label>
                                    <p class="detail-value">${household.family_id ? (household.household_family_name || 'N/A') + ` (ID: ${household.family_id})` : 'N/A'}</p>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Address:</label>
                                    <p class="detail-value">${household.address || 'N/A'}</p>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Zone:</label>
                                    <p class="detail-value">${household.zone_name || 'N/A'}</p>
                                </div>

                                <!-- Living Conditions -->
                                <div class="col-span-1 md:col-span-2">
                                    <h5 class="details-section-heading">Living Conditions</h5>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Main Water Source:</label>
                                    <p class="detail-value">${household.water_source || 'N/A'}</p>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Main Cooking Fuel:</label>
                                    <p class="detail-value">${household.cooking_fuel || 'N/A'}</p>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Has Toilet:</label>
                                    <p class="detail-value">${household.has_toilet == 1 ? 'Yes' : 'No'}</p>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Has Electricity:</label>
                                    <p class="detail-value">${household.has_electricity == 1 ? 'Yes' : 'No'}</p>
                                </div>

                                <!-- Socio-Economic & Housing Details -->
                                <div class="col-span-1 md:col-span-2">
                                    <h5 class="details-section-heading">Socio-Economic & Housing Details</h5>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Tenure Status:</label>
                                    <p class="detail-value">${household.tenure_status || 'N/A'}</p>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Household Income Source:</label>
                                    <p class="detail-value">${household.income_source || 'N/A'}</p>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Monthly Income:</label>
                                    <p class="detail-value">${formattedMonthlyIncome}</p>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Type of Household:</label>
                                    <p class="detail-value">${household.household_type || 'N/A'}</p>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Type of House Material:</label>
                                    <p class="detail-value">${household.house_material || 'N/A'}</p>
                                </div>
                            </div>
                        </div>
                    `;
                    showCustomModal(detailsHtml, 'alert'); // Use alert for displaying details
                } else {
                    showCustomModal(result.message || 'Household details not found.', 'alert');
                }
            } catch (error) {
                console.error('Error fetching household for view:', error);
                showCustomModal(`Error loading household details: ${error.message}`, 'alert');
            }
            return; // Exit after handling this specific button click
        }

        if (event.target.classList.contains('edit-household-btn')) {
            const householdId = event.target.dataset.householdId;
            try {
                const response = await fetch(`../api/families.php?household_id=${householdId}`);
                if (!response.ok) {
                    const errorText = await response.text();
                    throw new Error(`Failed to fetch household details for editing. Status: ${response.status}. Response: ${errorText}`);
                }
                const result = await response.json();
                if (result.status === 'success' && result.data) {
                    openHouseholdModal(result.data); // Pass data to openHouseholdModal for editing
                } else {
                    showCustomModal(result.message || 'Household details not found for editing.', 'alert');
                }
            } catch (error) {
                console.error('Error fetching household for edit:', error);
                showCustomModal(`Error loading household details for edit: ${error.message}`, 'alert');
            }
            return; // Exit after handling this specific button click
        }

        if (event.target.classList.contains('delete-household-btn')) {
            const householdId = event.target.dataset.householdId;
            const householdAddress = event.target.dataset.householdAddress;
            const confirmed = await window.confirm(`Are you sure you want to delete the household at "${householdAddress}" (ID: ${householdId}) and its members? This cannot be undone.`);
            if (confirmed) {
                try {
                    const response = await fetch('../api/families.php', {
                        method: 'DELETE',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ household_id: householdId, type: 'household' })
                    });
                    const result = await response.json();

                    if (response.ok && result.status === 'success') {
                        showCustomModal(`${householdAddress} deleted successfully!`, 'alert', () => {
                            currentPage = 1;
                            fetchAndRenderFamilies();
                        });
                    } else {
                        throw new Error(result.message || `Failed to delete household: ${response.statusText}`);
                    }
                } catch (error) {
                    console.error('Error deleting household:', error);
                    showCustomModal(`Error deleting household: ${error.message}`, 'alert');
                }
            }
            return; // Exit after handling this specific button click
        }

        if (event.target.classList.contains('add-household-to-family-btn')) {
            // Changed: Now opens the "Select Household to Assign" modal
            const familyId = event.target.dataset.familyId;
            openSelectHouseholdToAssignModal(familyId); // Pass family ID to the new modal
            return; // Exit after handling this specific button click
        }

        // --- General Family Header Toggle (Fallback if no specific button was clicked) ---
        const familyHeader = event.target.closest('.family-header');
        if (familyHeader) {
            const expandIcon = familyHeader.querySelector('.expand-icon');
            const householdsContainer = familyHeader.nextElementSibling;

            if (householdsContainer && expandIcon) {
                householdsContainer.classList.toggle('hidden');
                expandIcon.classList.toggle('rotate-180'); // Rotate icon for expand/collapse
            }
            // No return here, as this is the general click handler for the header
        }
    });


    // --- Select Individual (Household Head) Logic ---
    selectHouseholdHeadBtn.addEventListener('click', openSelectIndividualModal);
    closeSelectIndividualModalBtn.addEventListener('click', closeSelectIndividualModal);
    closeSelectIndividualModalBtnBottom.addEventListener('click', closeSelectIndividualModal); // Also close from bottom button

    searchIndividualForHousehold.addEventListener('input', debounce(async (event) => {
        const searchTerm = event.target.value.trim();
        const individuals = await fetchIndividualsForSelection(searchTerm);
        renderIndividualsForSelection(individuals);
    }, 300)); // Debounce to prevent excessive API calls

    availableIndividualsList.addEventListener('click', (event) => {
        const selectedDiv = event.target.closest('div[data-individual-id]');
        if (selectedDiv) {
            const individualId = selectedDiv.dataset.individualId;
            const individualName = selectedDiv.dataset.individualName;

            householdHeadIndividualIdInput.value = individualId;
            householdHeadNameDisplay.value = individualName;
            closeSelectIndividualModal();
        }
    });

    // --- Select Family (for Household) Logic ---
    selectFamilyForHouseholdBtn.addEventListener('click', openSelectFamilyModal);
    closeSelectFamilyModalBtn.addEventListener('click', closeSelectFamilyModal);
    closeSelectFamilyModalBtnBottom.addEventListener('click', closeSelectFamilyModal); // Also close from bottom button

    clearFamilyForHouseholdBtn.addEventListener('click', () => {
        householdFamilyIdInput.value = '';
        householdFamilyNameDisplay.textContent = 'Not selected';
        clearFamilyForHouseholdBtn.classList.add('hidden');
    });


    searchFamilyForHousehold.addEventListener('input', debounce(async (event) => {
        const searchTerm = event.target.value.trim();
        const families = await fetchFamiliesForSelection(searchTerm);
        renderFamiliesForSelection(families);
    }, 300));

    // This fetchFamiliesForSelection is different from fetchAndRenderFamilies; it's specifically for selection modal
    async function fetchFamiliesForSelection(searchTerm = '') {
        try {
            const response = await fetch(`../api/families.php?search=${encodeURIComponent(searchTerm)}&limit=50`); // Fetch more if needed
            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`Failed to fetch families for selection. Status: ${response.status}. Response: ${errorText}`);
            }
            const result = await response.json();
            if (result.status === 'success' && result.data) {
                return result.data;
            } else {
                console.error('API Error for families selection:', result.message);
                return [];
            }
        } catch (error) {
            console.error('Error fetching families for selection:', error);
            showCustomModal(`Error loading families for selection: ${error.message}`, 'alert');
            return [];
        }
    }

    function renderFamiliesForSelection(families) {
        availableFamiliesList.innerHTML = '';
        if (families.length === 0) {
            availableFamiliesList.innerHTML = '<p class="text-center text-gray-500 py-4">No families found.</p>';
            return;
        }

        families.forEach(family => {
            const div = document.createElement('div');
            div.className = 'p-3 hover:bg-gray-100 cursor-pointer border-b border-gray-200 last:border-b-0';
            div.dataset.familyId = family.family_id;
            div.dataset.familyName = family.family_name;
            div.innerHTML = `<p class="font-semibold text-gray-800">${family.family_name}</p><p class="text-sm text-gray-500">ID: ${family.family_id}</p>`;
            availableFamiliesList.appendChild(div);
        });
    }

    availableFamiliesList.addEventListener('click', (event) => {
        const selectedDiv = event.target.closest('div[data-family-id]');
        if (selectedDiv) {
            const familyId = selectedDiv.dataset.familyId;
            const familyName = selectedDiv.dataset.familyName;

            householdFamilyIdInput.value = familyId;
            householdFamilyNameDisplay.textContent = familyName;
            clearFamilyForHouseholdBtn.classList.remove('hidden');
            closeSelectFamilyModal();
        }
    });

    // Pagination Event Listeners
    prevPageBtn.addEventListener('click', () => {
        if (currentPage > 1) {
            currentPage--;
            fetchAndRenderFamilies();
        }
    });

    nextPageBtn.addEventListener('click', () => {
        if (currentPage < totalPages) {
            currentPage++;
            fetchAndRenderFamilies();
        }
    });

    familySearch.addEventListener('input', (event) => {
        currentSearchTerm = event.target.value.trim().toLowerCase();
        currentPage = 1;
        fetchAndRenderFamilies();
    });

    // Debounce function for input search
    function debounce(func, delay) {
        let timeout;
        return function(...args) {
            const context = this;
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(context, args), delay);
        };
    }

    // Initial fetch when the page loads
    fetchAndRenderFamilies();
});

// Example function to render family details
function openViewFamilyModal(family) {
    const viewFamilyBasicInfo = document.getElementById('viewFamilyBasicInfo');
    const viewFamilyHouseholds = document.getElementById('viewFamilyHouseholds');
    const totalHouseholdsSpan = document.getElementById('familyTotalHouseholds');
    const totalIndividualsSpan = document.getElementById('familyTotalIndividuals');

    // Defensive: fallback if not present
    if (!viewFamilyBasicInfo || !viewFamilyHouseholds || !totalHouseholdsSpan || !totalIndividualsSpan) return;

    // Clear previous content
    viewFamilyBasicInfo.innerHTML = '';
    viewFamilyHouseholds.innerHTML = '';

    // --- Calculate totals ---
    // Households: count from array or string
    let totalHouseholds = 0;
    if (Array.isArray(family.households)) {
        totalHouseholds = family.households.length;
    } else if (typeof family.household_ids === 'string' && family.household_ids.trim() !== '') {
        totalHouseholds = family.household_ids.split(',').filter(Boolean).length;
    }

    // Individuals: count from array or string
    let totalIndividuals = 0;
    if (Array.isArray(family.individuals)) {
        totalIndividuals = family.individuals.length;
    } else if (typeof family.individual_names === 'string' && family.individual_names.trim() !== '') {
        totalIndividuals = family.individual_names.split(';').filter(Boolean).length;
    }

    totalHouseholdsSpan.textContent = totalHouseholds;
    totalIndividualsSpan.textContent = totalIndividuals;

    // --- Basic Info ---
    viewFamilyBasicInfo.innerHTML += `
        <div class="detail-item">
            <span class="detail-label">Family Name:</span>
            <span class="detail-value">${family.family_name || 'N/A'}</span>
        </div>
        <div class="detail-item">
            <span class="detail-label">Notes:</span>
            <span class="detail-value">${family.notes || 'N/A'}</span>
        </div>
    `;

    // --- Associated Households ---
    if (family.households && family.households.length > 0) {
        // Sort households by address for consistent display
        family.households.sort((a, b) => (a.address || '').localeCompare(b.address || ''));

        family.households.forEach(hh => {
            viewFamilyHouseholds.innerHTML += `
                <div class="detail-item">
                    <span class="detail-label">Address:</span>
                    <span class="detail-value">${hh.address || 'N/A'}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Head of Household:</span>
                    <span class="detail-value">${hh.head_name || 'N/A'}</span>
                </div>
            `;
        });
    } else {
        viewFamilyHouseholds.innerHTML = `<p class="text-gray-500">No households associated with this family.</p>`;
    }

    // Show the modal
    document.getElementById('familyDetailsModal').classList.remove('hidden');
}

// This function is redundant and can be removed, as openViewFamilyModal handles everything
// function openFamilyDetailsModal(family) {
//     document.getElementById('familyDetailsModal').classList.remove('hidden');
// }

document.getElementById('closeFamilyDetailsModalBtn').onclick = function() {
    document.getElementById('familyDetailsModal').classList.add('hidden');
};

// Place this after renderFamiliesAndHouseholds(families);
document.getElementById('hierarchyContainer').addEventListener('click', function(event) {
    const btn = event.target.closest('.view-family-btn');
    if (btn) {
        const familyId = btn.getAttribute('data-family-id');
        // Find the family object from your families array
        // Assuming 'families' array is available in this scope (from fetchAndRenderFamilies)
        // If not, you'd need to refetch the single family or pass the full family object
        // For now, let's assume 'families' is accessible and holds the full data
        const family = families.find(f => String(f.family_id) === String(familyId));
        if (family) {
            openViewFamilyModal(family);
        } else {
            // Fallback if family object isn't immediately available (e.g., due to pagination)
            // You might want to fetch the single family details here
            console.warn('Family not found in current data for view, attempting re-fetch if needed.');
            // Example: fetchFamilyDetailsById(familyId).then(openViewFamilyModal);
        }
    }
});
