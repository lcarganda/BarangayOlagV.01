document.addEventListener('DOMContentLoaded', () => {
    console.log('Households page loaded!');

    // --- DOM Elements ---
    const householdsTableBody = document.getElementById('householdsTableBody');
    const paginationContainer = document.querySelector('section.flex-1 > div.flex.justify-between.items-center.mt-6');
    const householdSearch = document.getElementById('householdSearch');
    const prevPageBtn = document.getElementById('prevPageBtn');
    const nextPageBtn = document.getElementById('nextPageBtn');
    const paginationInfo = document.getElementById('paginationInfo');
    const noResultsMessage = document.getElementById('noResults');
    const addNewHouseholdBtn = document.getElementById('addNewHouseholdBtn');

    // --- Household Modal Elements (Add/Edit) ---
    const householdModal = document.getElementById('householdModal');
    const householdModalTitle = document.getElementById('householdModalTitle');
    const householdForm = document.getElementById('householdForm');
    const householdIdInput = document.getElementById('householdId');
    const cancelHouseholdBtn = document.getElementById('cancelHouseholdBtn');
    const closeHouseholdModalBtn = document.getElementById('closeHouseholdModalBtn');

    // Form fields
    const addressInput = document.getElementById('address'); // Changed to single address input
    const zoneSelect = document.getElementById('zone');
    const headOfHouseholdSelect = document.getElementById('headOfHousehold');
    const monthlyHouseholdIncomeInput = document.getElementById('monthlyHouseholdIncome');
    const incomeSourceSelect = document.getElementById('incomeSource');
    const householdTypeSelect = document.getElementById('householdType');
    const houseMaterialSelect = document.getElementById('householdMaterial');
    const hasWaterCheckbox = document.getElementById('hasWater');
    const hasToiletCheckbox = document.getElementById('hasToilet');
    const hasElectricityCheckbox = document.getElementById('hasElectricity');
    const hasInternetCheckbox = document.getElementById('hasInternet');

    // Household Members elements
    const householdMembersContainer = document.getElementById('householdMembersContainer');
    const addMemberBtn = document.getElementById('addMemberBtn');

    // --- View Household Details Modal Elements ---
    const viewHouseholdModal = document.getElementById('viewHouseholdModal');
    const closeViewHouseholdBtn = document.getElementById('closeViewHouseholdBtn');
    const closeViewHouseholdHeaderBtn = document.getElementById('closeViewHouseholdHeaderBtn');

    function closeViewHouseholdModal() {
        viewHouseholdModal.classList.add('hidden');
    }

    // Attach the event listener safely
    if (closeViewHouseholdBtn) {
        closeViewHouseholdBtn.addEventListener('click', closeViewHouseholdModal);
    }
    if (closeViewHouseholdHeaderBtn) {
        closeViewHouseholdHeaderBtn.addEventListener('click', closeViewHouseholdModal);
    }

    // --- Custom Modal for Confirmation/Alerts ---
    const customModal = document.getElementById('customModal');
    const customModalTitle = document.getElementById('customModalTitle');
    const customModalMessage = document.getElementById('customModalMessage');
    const customModalConfirm = document.getElementById('customModalConfirm');
    const customModalCancel = document.getElementById('customModalCancel');

    // --- Pagination Variables ---
    let currentPage = 1;
    let recordsPerPage = 10; // Default value
    let totalPages = 1;
    let currentSearchTerm = '';

    // --- Filter Modal Elements ---
    const filterModal = document.getElementById('filterModal');
    const openFilterModalBtn = document.getElementById('openFilterModalBtn');
    const closeFilterModalBtn = document.getElementById('closeFilterModalBtn'); // Added close button for filter modal
    const filterForm = document.getElementById('filterForm');
    const clearFiltersBtn = document.getElementById('clearFiltersBtn');
    const applyFiltersBtn = document.getElementById('applyFiltersBtn');

    // Filter form fields
    const filterMinMonthlyIncome = document.getElementById('filterMinMonthlyIncome');
    const filterMaxMonthlyIncome = document.getElementById('filterMaxMonthlyIncome');
    const filterZone = document.getElementById('filterZone');
    const filterHouseholdType = document.getElementById('filterHouseholdType');
    const filterHouseMaterial = document.getElementById('filterHouseMaterial');
    const filterHasWater = document.getElementById('filterHasWater');
    const filterHasElectricity = document.getElementById('filterHasElectricity');
    const filterHasToilet = document.getElementById('filterHasToilet');
    const filterHasInternet = document.getElementById('filterHasInternet');
    const filterRecordsPerPage = document.getElementById('filterRecordsPerPage'); // New field for records per page
    const filterSortBy = document.getElementById('filterSortBy');
    const filterSortOrder = document.getElementById('filterSortOrder');

    // Object to store current filter values
    let currentFilters = {
        min_monthly_income: '',
        max_monthly_income: '',
        zone_id: 'all',
        type_of_household_id: 'all',
        type_of_house_material_id: 'all',
        has_water: 'all',
        has_electricity: 'all',
        has_toilet: 'all',
        has_internet: 'all',
        sort_by: 'head_last_name',
        sort_order: 'asc'
    };

    // --- Mobile Menu Elements and Logic ---
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


    /**
     * Shows a custom modal dialog.
     * @param {string} message The message to display.
     * @param {string} type 'alert' for a simple alert, 'confirm' for a confirmation.
     * @param {function} onConfirm Callback function for 'confirm' type when confirmed.
     */
    function showCustomModal(message, type, onConfirm = null) {
        customModalTitle.textContent = type === 'confirm' ? 'Confirm Action' : 'Notification';
        customModalMessage.innerHTML = message; // Use innerHTML to allow for richer content
        customModalCancel.classList.add('hidden'); // Hide cancel by default
        customModalConfirm.textContent = 'Okay'; // Default to Okay

        if (type === 'confirm') {
            customModalConfirm.textContent = 'Confirm';
            customModalCancel.classList.remove('hidden');
            customModalConfirm.onclick = () => {
                customModal.classList.add('hidden');
                if (onConfirm) onConfirm();
            };
            customModalCancel.onclick = () => {
                customModal.classList.add('hidden');
            };
        } else { // 'alert'
            customModalConfirm.onclick = () => {
                customModal.classList.add('hidden');
            };
        }
        customModal.classList.remove('hidden');
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

    // --- Lookup Data ---
    let lookupData = {
        zones: [],
        individuals: [], // For household head dropdown (unassigned individuals)
        allIndividuals: [], // For household members dropdowns (all individuals not heads)
        incomeSource: [
            { id: 1, name: 'Salary/Wages' },
            { id: 2, name: 'Business Income' },
            { id: 3, name: 'Remittance' },
            { id: 4, name: 'Pension' },
            { id: 5, name: 'Farming/Fishing' },
            { id: 6, name: 'Other' }
        ],
        householdType: [
            { id: 1, name: 'Nuclear Family' },
            { id: 2, name: 'Extended Family' },
            { id: 3, name: 'Single Parent' },
            { id: 4, name: 'Couple Only' },
            { id: 5, name: 'Single Person' },
            { id: 6, name: 'Other' }
        ],
        houseMaterial: [
            { id: 1, name: 'Concrete' },
            { id: 2, name: 'Wood' },
            { id: 3, name: 'Mixed' },
            { id: 4, name: 'Light Materials' },
            { id: 5, name: 'Salvaged' }
        ],
        memberRelationships: [
            { name: 'Spouse' },
            { name: 'Son' },
            { name: 'Daughter' },
            { name: 'Father' },
            { name: 'Mother' },
            { name: 'Brother' },
            { name: 'Sister' },
            { name: 'Grandchild' },
            { name: 'Other Relative' },
            { name: 'Non-Relative' }
        ]
    };

    // Helper to populate a select dropdown
    function populateDropdown(selectElement, data, idField, nameField, includeAllOption = false, includeEmptyOption = false) {
        if (!selectElement) {
            console.warn('populateDropdown: selectElement is null, skipping.');
            return;
        }
        selectElement.innerHTML = '';
        if (includeAllOption) {
            const allOption = document.createElement('option');
            allOption.value = 'all';
            allOption.textContent = 'All';
            selectElement.appendChild(allOption);
        }
        if (includeEmptyOption) {
            const emptyOption = document.createElement('option');
            emptyOption.value = '';
            emptyOption.textContent = 'Select an option';
            selectElement.appendChild(emptyOption);
        }
        data.forEach(item => {
            const option = document.createElement('option');
            option.value = String(item[idField]);
            option.textContent = item[nameField];
            selectElement.appendChild(option);
        });
    }

    // Fetch dynamic lookup data (Zones, Individuals for Head, Individuals for Members)
    async function fetchDynamicLookupData() {
        try {
            // Fetch Zones
            const zonesResponse = await fetch('../api/zone.php?action=getAllZoneNames');
            if (zonesResponse.ok) {
                const zonesResult = await zonesResponse.json();
                if (zonesResult.status === 'success' && zonesResult.data) {
                    lookupData.zones = zonesResult.data;
                    populateDropdown(zoneSelect, lookupData.zones, 'zone_id', 'zone_name', false, true); // For form, no 'All'
                    populateDropdown(filterZone, lookupData.zones, 'zone_id', 'zone_name', true); // For filter, with 'All'
                } else {
                    console.error('Failed to fetch zones for dropdown:', zonesResult.message);
                }
            } else {
                console.error('Error fetching zones for dropdown:', zonesResponse.statusText);
            }

            // Fetch Individuals not yet assigned as household head (for headOfHouseholdSelect)
            const unassignedIndividualsResponse = await fetch('../api/household.php?action=getUnassignedIndividuals');
            if (unassignedIndividualsResponse.ok) {
                const unassignedIndividualsResult = await unassignedIndividualsResponse.json();
                if (unassignedIndividualsResult.status === 'success' && unassignedIndividualsResult.data) {
                    lookupData.individuals = unassignedIndividualsResult.data;
                    // Populate head of household dropdown with unassigned individuals initially
                    populateDropdown(headOfHouseholdSelect, lookupData.individuals, 'individual_id', 'full_name', false, true);
                } else {
                    console.error('Failed to fetch unassigned individuals for head dropdown:', unassignedIndividualsResult.message);
                }
            } else {
                console.error('Error fetching unassigned individuals for head dropdown:', unassignedIndividualsResponse.statusText);
            }

            // Fetch ALL individuals not currently a household head (for household members dropdowns)
            const allIndividualsForMembersResponse = await fetch('../api/household.php?action=getIndividualsForMembers');
            if (allIndividualsForMembersResponse.ok) {
                const allIndividualsForMembersResult = await allIndividualsForMembersResponse.json();
                if (allIndividualsForMembersResult.status === 'success' && allIndividualsForMembersResult.data) {
                    lookupData.allIndividuals = allIndividualsForMembersResult.data;
                    // Update allIndividuals for autocomplete
                    allIndividuals = lookupData.allIndividuals.map(ind => ({
                        id: ind.individual_id,
                        name: ind.full_name
                    }));
                } else {
                    console.error('Failed to fetch individuals for members dropdown:', allIndividualsForMembersResult.message);
                }
            } else {
                console.error('Error fetching individuals for members dropdown:', allIndividualsForMembersResponse.statusText);
            }

        } catch (error) {
            console.error('Error fetching dynamic lookup data:', error);
            showCustomModal('Failed to load some dropdown options. Please try again.', 'alert');
        }
    }

    // Populate static dropdowns
    function populateStaticLookups() {
        populateDropdown(incomeSourceSelect, lookupData.incomeSource, 'id', 'name', false, true); // For form
        populateDropdown(householdTypeSelect, lookupData.householdType, 'id', 'name', false, true); // For form
        populateDropdown(houseMaterialSelect, lookupData.houseMaterial, 'id', 'name', false, true); // For form

        // For filters, with 'All' option
        populateDropdown(filterHouseholdType, lookupData.householdType, 'id', 'name', true);
        populateDropdown(filterHouseMaterial, lookupData.houseMaterial, 'id', 'name', true);
    }

    // Helper to set select dropdown value
    function setSelectValue(selectElement, value) {
        const stringValue = String(value || '');
        selectElement.value = stringValue;
        if (selectElement.value !== stringValue && stringValue !== '') {
            console.warn(`Could not set select ${selectElement.id} to value "${stringValue}". Option might not exist or not yet rendered.`);
        }
    }

    // --- Household Member Management in Modal ---
    function addMemberRow(member = null) {
        const memberRow = document.createElement('div');
        memberRow.classList.add('flex', 'flex-col', 'md:flex-row', 'gap-2', 'items-center', 'member-row', 'p-3', 'bg-gray-50', 'rounded-md', 'shadow-sm', 'border', 'border-gray-200');

        // Individual Select
        const individualSelect = document.createElement('select');
        individualSelect.classList.add('mt-1', 'block', 'w-full', 'md:w-1/2', 'px-3', 'py-2', 'border', 'border-gray-300', 'rounded-md', 'shadow-sm', 'focus:outline-none', 'focus:ring-secondary-green', 'focus:border-secondary-green', 'sm:text-sm');
        individualSelect.name = 'member_individual_id';
        individualSelect.required = true;

        // Ensure all individuals are available for member selection, including the current head if they are being edited
        const allPossibleMembers = [...lookupData.allIndividuals];
        // If editing, and the household head is not in the allIndividuals list (because they are a head), add them to the list for this dropdown
        if (member && member.individual_id && !allPossibleMembers.some(ind => ind.individual_id === member.individual_id)) {
            // This case should ideally not happen if getIndividualsForMembers is comprehensive,
            // but as a fallback, ensure the current member's individual is in the list
            allPossibleMembers.push({ individual_id: member.individual_id, full_name: member.full_name });
            allPossibleMembers.sort((a, b) => a.full_name.localeCompare(b.full_name));
        }

        populateDropdown(individualSelect, allPossibleMembers, 'individual_id', 'full_name');
        if (member) {
            setSelectValue(individualSelect, member.individual_id);
        }

        // Relationship Input
        const relationshipInput = document.createElement('input');
        relationshipInput.type = 'text';
        relationshipInput.classList.add('mt-1', 'block', 'w-full', 'md:w-1/3', 'px-3', 'py-2', 'border', 'border-gray-300', 'rounded-md', 'shadow-sm', 'focus:outline-none', 'focus:ring-secondary-green', 'focus:border-secondary-green', 'sm:text-sm');
        relationshipInput.name = 'member_relationship_to_head';
        relationshipInput.placeholder = 'Relationship to Head';
        relationshipInput.required = true;
        if (member) {
            relationshipInput.value = member.relationship_to_head;
        }

        // Remove Button
        const removeButton = document.createElement('button');
        removeButton.type = 'button';
        removeButton.classList.add('mt-1', 'md:mt-0', 'bg-red-500', 'text-white', 'py-2', 'px-4', 'rounded-xl', 'shadow-md', 'hover:bg-red-600', 'transition-colors', 'duration-200', 'text-sm', 'font-semibold', 'flex', 'items-center', 'justify-center');
        removeButton.innerHTML = '<i class="fas fa-minus-circle mr-1"></i> Remove';
        removeButton.addEventListener('click', () => {
            memberRow.remove();
        });

        memberRow.appendChild(individualSelect);
        memberRow.appendChild(relationshipInput);
        memberRow.appendChild(removeButton);
        householdMembersContainer.appendChild(memberRow);
    }

    addMemberBtn.addEventListener('click', () => addMemberRow());

    // --- Modal Functions ---
    function openHouseholdModal(household = null) {
        householdForm.reset();
        householdIdInput.value = '';
        householdMembersContainer.innerHTML = ''; // Clear existing members

        // Reset checkboxes
        hasWaterCheckbox.checked = false;
        hasToiletCheckbox.checked = false;
        hasElectricityCheckbox.checked = false;
        hasInternetCheckbox.checked = false;

        fetchDynamicLookupData().then(() => {
            if (household) {
                householdModalTitle.textContent = 'Edit Household';
                householdIdInput.value = household.household_id;
                addressInput.value = household.address; // Use 'address' directly
                setSelectValue(zoneSelect, household.zone_id);

                // For editing, populate headOfHouseholdSelect with ALL individuals, then set current head
                // This ensures the current head, even if now assigned, appears in the dropdown.
                fetch('../api/households.php?action=getAllIndividuals')
                    .then(res => res.json())
                    .then(result => {
                        if (result.status === 'success' && result.data) {
                            populateDropdown(headOfHouseholdSelect, result.data, 'individual_id', 'full_name', false, true);
                            setSelectValue(headOfHouseholdSelect, household.household_head_individual_id);
                        } else {
                            console.error('Failed to fetch all individuals for head of household dropdown:', result.message);
                        }
                    })
                    .catch(error => console.error('Error fetching all individuals:', error));

                monthlyHouseholdIncomeInput.value = household.monthly_household_income;
                setSelectValue(incomeSourceSelect, household.household_source_of_income_id); // Changed to household_source_of_income_id
                setSelectValue(householdTypeSelect, household.type_of_household_id);
                setSelectValue(houseMaterialSelect, household.type_of_house_material_id);
                hasWaterCheckbox.checked = household.has_water;
                hasToiletCheckbox.checked = household.has_toilet;
                hasElectricityCheckbox.checked = household.has_electricity;
                hasInternetCheckbox.checked = household.has_internet;

                // Populate household members
                if (household.members && household.members.length > 0) {
                    household.members.forEach(member => addMemberRow(member));
                }
            } else {
                householdModalTitle.textContent = 'Add New Household';
            }
        });
        householdModal.classList.remove('hidden');
    }

    function closeHouseholdModal() {
        householdModal.classList.add('hidden');
    }

    if (closeHouseholdModalBtn) {
        closeHouseholdModalBtn.addEventListener('click', () => {
            householdModal.classList.add('hidden');
        });
    }

    // --- CRUD Operations & Fetching ---
    async function fetchAndRenderHouseholds() {
        if (!householdsTableBody) {
            console.error("householdsTableBody is null. Aborting fetch.");
            return;
        }

        // Adjusted colspan to 8 (Members, Address, Head, Income, Electricity, Toilet, Internet, Actions)
        householdsTableBody.innerHTML = '<tr><td colspan="8" class="text-center py-4">Loading households...</td></tr>';
        noResultsMessage.classList.add('hidden');
        if (paginationContainer) paginationContainer.style.display = 'none';

        try {
            // Collect filter values
            const filters = {
                min_monthly_income: filterMinMonthlyIncome.value,
                max_monthly_income: filterMaxMonthlyIncome.value,
                zone_id: filterZone.value,
                type_of_household_id: filterHouseholdType.value,
                type_of_house_material_id: filterHouseMaterial.value,
                has_water: filterHasWater.value,
                has_electricity: filterHasElectricity.value,
                has_toilet: filterHasToilet.value,
                has_internet: filterHasInternet.value
            };

            const offset = (currentPage - 1) * recordsPerPage;
            const queryParams = new URLSearchParams({
                offset: offset,
                limit: recordsPerPage,
                search_query: currentSearchTerm,
                filters: JSON.stringify(filters),
                sort_by: currentFilters.sort_by,
                sort_order: currentFilters.sort_order
            }).toString();

            const apiUrl = `../api/household.php?${queryParams}`;

            const response = await fetch(apiUrl);
            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`Failed to fetch households data. Status: ${response.status}. Response: ${errorText}`);
            }
            const result = await response.json();
            console.log('API Response (Households):', result);

            if (result.status === 'success' && result.data) {
                householdsTableBody.innerHTML = '';
                const households = result.data.households;
                const totalRecords = result.data.totalRecords;
                totalPages = Math.ceil(totalRecords / recordsPerPage);

                if (households.length === 0) {
                    noResultsMessage.textContent = currentSearchTerm || Object.values(currentFilters).some(f => f !== 'all' && f !== '') ? `No households found matching your criteria.` : `No households to display.`;
                    noResultsMessage.classList.remove('hidden');
                    paginationInfo.textContent = `Page 0 of 0`;
                    prevPageBtn.disabled = true;
                    nextPageBtn.disabled = true;
                } else {
                    noResultsMessage.classList.add('hidden');
                    households.forEach(household => {
                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td data-label="Members" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${household.total_member_count || 0}</td>
                            <td data-label="Address" class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${household.full_address || 'N/A'}</td>
                            <td data-label="Head of Household" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${household.head_of_household_name || 'N/A'}</td>
                            <td data-label="Monthly Income" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">₱${parseFloat(household.monthly_household_income).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                            <td data-label="Has Electricity?" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${household.has_electricity ? 'Yes' : 'No'}</td>
                            <td data-label="Has Toilet?" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${household.has_toilet ? 'Yes' : 'No'}</td>
                            <td data-label="Has Internet?" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${household.has_internet ? 'Yes' : 'No'}</td>
                            <td data-label="Actions" class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button class="view-btn bg-green-100 text-green-800 py-1 px-2 rounded-md hover:bg-green-200 transition-colors duration-200 mr-2" data-id="${household.household_id}">
                                    <i class="fas fa-eye"></i> View
                                </button>
                                <button class="edit-btn bg-blue-200 text-blue-800 py-1 px-2 rounded-md hover:bg-blue-300 transition-colors duration-200 mr-2" data-id="${household.household_id}">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <button class="delete-btn bg-red-200 text-red-800 py-1 px-2 rounded-md hover:bg-red-300 transition-colors duration-200" data-id="${household.household_id}" data-address="${household.full_address}">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </button>
                            </td>
                        `;
                        householdsTableBody.appendChild(row);
                    });
                    // --- ADD THIS LINE HERE ---
                    hideEditDeleteForUser();

                    updatePaginationControls();
                }
            } else {
                // Adjusted colspan to 8
                householdsTableBody.innerHTML = `<tr><td colspan="8" class="text-center py-4 text-red-500">Error: ${result.message || 'Unknown error'}</td></tr>`;
                noResultsMessage.classList.add('hidden');
                paginationInfo.textContent = `Page 0 of 0`;
                prevPageBtn.disabled = true;
                nextPageBtn.disabled = true;
            }
        } catch (error) {
            console.error('Error fetching households data:', error);
            // Adjusted colspan to 8
            householdsTableBody.innerHTML = `<tr><td colspan="8" class="text-center py-4 text-red-500">Failed to load data. Please try again.</td></tr>`;
            noResultsMessage.classList.add('hidden');
            paginationInfo.textContent = `Page 0 of 0`;
            prevPageBtn.disabled = true;
            nextPageBtn.disabled = true;
        } finally {
            if (paginationContainer) paginationContainer.style.display = 'flex';
        }
    }

    // Handle form submission for Add/Edit Household
    householdForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        // Basic validation
        if (!addressInput.value || !zoneSelect.value || !headOfHouseholdSelect.value || !monthlyHouseholdIncomeInput.value || !incomeSourceSelect.value || !householdTypeSelect.value || !houseMaterialSelect.value) {
            showCustomModal('Please fill in all required fields.', 'alert');
            return;
        }

        // Collect household members data
        const members = [];
        const memberRows = householdMembersContainer.querySelectorAll('.member-row');
        let hasInvalidMembers = false;
        memberRows.forEach(row => {
            const individualSelect = row.querySelector('select[name="member_individual_id"]');
            const relationshipInput = row.querySelector('input[name="member_relationship_to_head"]');

            if (individualSelect.value && relationshipInput.value) {
                members.push({
                    individual_id: parseInt(individualSelect.value),
                    relationship_to_head: relationshipInput.value
                });
            } else {
                hasInvalidMembers = true;
            }
        });

        if (hasInvalidMembers) {
            showCustomModal('Please ensure all household members have a selected individual and a relationship.', 'alert');
            return;
        }

        const formData = {
            household_id: householdIdInput.value || null,
            address: addressInput.value, // Use 'address'
            zone_id: parseInt(zoneSelect.value),
            household_head_individual_id: parseInt(headOfHouseholdSelect.value),
            monthly_household_income: parseFloat(monthlyHouseholdIncomeInput.value),
            household_source_of_income_id: parseInt(incomeSourceSelect.value), // Changed to household_source_of_income_id
            type_of_household_id: parseInt(householdTypeSelect.value),
            type_of_house_material_id: parseInt(houseMaterialSelect.value),
            has_water: hasWaterCheckbox.checked,
            has_toilet: hasToiletCheckbox.checked,
            has_electricity: hasElectricityCheckbox.checked,
            has_internet: hasInternetCheckbox.checked,
            members: members // Include members array
        };

        console.log('Sending formData for save:', formData);

        try {
            const response = await fetch('../api/household.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            });

            const result = await response.json();
            if (response.ok && result.status === 'success') {
                showCustomModal(`Household ${formData.household_id ? 'updated' : 'added'} successfully!`, 'alert', () => {
                    closeHouseholdModal();
                    currentPage = 1;
                    currentSearchTerm = '';
                    householdSearch.value = '';
                    fetchAndRenderHouseholds();
                });
            } else {
                throw new Error(result.message || `Failed to save household. Status: ${response.status}`);
            }
        } catch (error) {
            console.error('Error saving household:', error);
            showCustomModal(`Error saving household: ${error.message}`, 'alert');
        }
    });

    /**
     * Deletes a household.
     * @param {string} householdId The ID of the household to delete.
     * @param {string} householdAddress The address for confirmation message.
     */
    async function deleteHousehold(householdId, householdAddress) {
        showCustomModal(`Are you sure you want to delete household at ${householdAddress}? This will also remove all associated household members.`, 'confirm', async () => {
            try {
                const response = await fetch('../api/household.php', {
                    method: 'DELETE',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ household_id: householdId })
                });

                const result = await response.json();
                if (response.ok && result.status === 'success') {
                    showCustomModal(result.message, 'alert', () => {
                        currentPage = 1;
                        fetchAndRenderHouseholds();
                    });
                } else {
                    throw new Error(result.message || `Failed to delete household. Status: ${response.status}`);
                }
            } catch (error) {
                console.error('Error deleting household:', error);
                showCustomModal(`Error deleting household: ${error.message}`, 'alert');
            }
        });
    }

    // --- View Household Details Modal Logic ---
    function openViewHouseholdModal(household) {
        // Clear previous content
        viewBasicInfo.innerHTML = '';
        viewFinancialInfo.innerHTML = '';
        viewUtilitiesInfo.innerHTML = '';
        viewHouseholdMembers.innerHTML = '';

        const formatBoolean = (value) => value ? 'Yes' : 'No';
        const formatCurrency = (amount) => amount ? `₱${parseFloat(amount).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}` : 'N/A';
        const formatString = (value) => value || 'N/A';

        // Helper to get lookup name
        const getLookupName = (lookupArray, id, idField, nameField) => {
            const item = lookupArray.find(item => String(item[idField]) === String(id));
            return item ? item[nameField] : 'N/A';
        };

        const createDetailGroup = (label, value) => `
            <div class="details-group flex flex-col mb-2">
                <span class="details-label text-sm text-text-medium font-semibold mb-1">${label}:</span>
                <span class="details-value text-base text-text-dark font-medium break-words">${value}</span>
            </div>
        `;

        // Basic Info (single column, label above value)
        viewBasicInfo.innerHTML = '';
        viewBasicInfo.innerHTML += createDetailGroup('Address', formatString(household.full_address));
        viewBasicInfo.innerHTML += createDetailGroup('Head of Household', formatString(household.head_of_household_name));
        viewBasicInfo.innerHTML += createDetailGroup('Zone', formatString(household.zone_name));

        // Financial & Type Info
        viewFinancialInfo.innerHTML += createDetailGroup('Monthly Income', formatCurrency(household.monthly_household_income));
        viewFinancialInfo.innerHTML += createDetailGroup('Income Source', getLookupName(lookupData.incomeSource, household.household_source_of_income_id, 'id', 'name')); // Changed to household_source_of_income_id
        viewFinancialInfo.innerHTML += createDetailGroup('Household Type', getLookupName(lookupData.householdType, household.type_of_household_id, 'id', 'name'));
        viewFinancialInfo.innerHTML += createDetailGroup('House Material', getLookupName(lookupData.houseMaterial, household.type_of_house_material_id, 'id', 'name'));

        // Utilities & Amenities
        viewUtilitiesInfo.innerHTML += createDetailGroup('Has Water', formatBoolean(household.has_water));
        viewUtilitiesInfo.innerHTML += createDetailGroup('Has Electricity', formatBoolean(household.has_electricity));
        viewUtilitiesInfo.innerHTML += createDetailGroup('Has Toilet', formatBoolean(household.has_toilet));
        viewUtilitiesInfo.innerHTML += createDetailGroup('Has Internet', formatBoolean(household.has_internet));

        // Household Members Display
        if (household.members && household.members.length > 0) {
            const membersList = document.createElement('ul');
            membersList.classList.add('list-disc', 'pl-5', 'space-y-1', 'text-gray-700');
            household.members.forEach(member => {
                const listItem = document.createElement('li');
                listItem.textContent = `${member.full_name} (${member.relationship_to_head})`;
                membersList.appendChild(listItem);
            });
            viewHouseholdMembers.appendChild(membersList);
        } else {
            viewHouseholdMembers.innerHTML = '<p class="text-gray-500">No members listed for this household (excluding head).</p>';
        }

        viewHouseholdModal.classList.remove('hidden');

        // Always re-attach the event listener after modal is shown
        const closeViewHouseholdBtn = document.getElementById('closeViewHouseholdBtn');
        if (closeViewHouseholdBtn) {
            // Remove any previous click handler to avoid stacking
            closeViewHouseholdBtn.onclick = null;
            closeViewHouseholdBtn.onclick = function() {
                viewHouseholdModal.classList.add('hidden');
            };
        }
    }

    function closeViewHouseholdModal() {
        viewHouseholdModal.classList.add('hidden');
    }
    closeViewHouseholdBtn.addEventListener('click', closeViewHouseholdModal);

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
    addNewHouseholdBtn.addEventListener('click', () => openHouseholdModal());
    cancelHouseholdBtn.addEventListener('click', closeHouseholdModal);

    // Event delegation for table action buttons
    householdsTableBody.addEventListener('click', async (event) => {
        const target = event.target.closest('button');
        if (!target) return;

        const householdId = target.dataset.id;

        if (target.classList.contains('edit-btn')) {
            console.log(`Edit button clicked for Household ID: ${householdId}`);
            try {
                const response = await fetch(`../api/household.php?id=${householdId}`);
                if (!response.ok) {
                    const errorText = await response.text();
                    throw new Error(`Failed to fetch household details for editing. Status: ${response.status}. Response: ${errorText}`);
                }
                const result = await response.json();
                if (result.status === 'success' && result.data) {
                    openHouseholdModal(result.data);
                } else {
                    showCustomModal(result.message || 'Household details not found.', 'alert');
                }
            } catch (error) {
                console.error('Error fetching household for edit:', error);
                showCustomModal(`Error loading household for edit: ${error.message}`, 'alert');
            }
        } else if (target.classList.contains('delete-btn')) {
            const householdAddress = target.dataset.address;
            deleteHousehold(householdId, householdAddress);
        } else if (target.classList.contains('view-btn')) {
            console.log(`View button clicked for Household ID: ${householdId}`);
            try {
                const response = await fetch(`../api/household.php?id=${householdId}`);
                if (!response.ok) {
                    const errorText = await response.text();
                    throw new Error(`Failed to fetch household details for viewing. Status: ${response.status}. Response: ${errorText}`);
                }
                const result = await response.json();
                if (result.status === 'success' && result.data) {
                    openViewHouseholdModal(result.data);
                } else {
                    showCustomModal(result.message || 'Household details not found.', 'alert');
                }
            } catch (error) {
                console.error('Error fetching household for view:', error);
                showCustomModal(`Error loading household details: ${error.message}`, 'alert');
            }
        }
    });

    // Pagination Event Listeners
    if (prevPageBtn) {
        prevPageBtn.addEventListener('click', () => {
            if (currentPage > 1) {
                currentPage--;
                fetchAndRenderHouseholds();
            }
        });
    }

    if (nextPageBtn) {
        nextPageBtn.addEventListener('click', () => {
            if (currentPage < totalPages) {
                currentPage++;
                fetchAndRenderHouseholds();
            }
        });
    }

    // Search Input with Debounce
    const debounce = (func, delay) => {
        let timeout;
        return function(...args) {
            const context = this;
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(context, args), delay);
        };
    };

    if (householdSearch) {
        householdSearch.addEventListener('input', debounce(() => {
            currentSearchTerm = householdSearch.value;
            currentPage = 1;
            fetchAndRenderHouseholds();
        }, 300));
    }

    // --- Filter Modal Logic ---
    console.log('openFilterModalBtn element:', openFilterModalBtn); // Diagnostic log for the filter button element
    if (openFilterModalBtn) {
        openFilterModalBtn.addEventListener('click', () => {
            console.log('Filters button clicked!'); // Diagnostic log inside the event listener
            // Set filter modal fields to currentFilters values before opening
            filterMinMonthlyIncome.value = currentFilters.min_monthly_income;
            filterMaxMonthlyIncome.value = currentFilters.max_monthly_income;
            filterZone.value = currentFilters.zone_id;
            filterHouseholdType.value = currentFilters.type_of_household_id;
            filterHouseMaterial.value = currentFilters.type_of_house_material_id;
            filterHasWater.value = currentFilters.has_water;
            filterHasElectricity.value = currentFilters.has_electricity;
            filterHasToilet.value = currentFilters.has_toilet;
            filterHasInternet.value = currentFilters.has_internet;

            filterRecordsPerPage.value = recordsPerPage; // Set the dropdown to the current value
            filterSortBy.value = currentFilters.sort_by || 'head_last_name';
            filterSortOrder.value = currentFilters.sort_order || 'asc';

            filterModal.classList.remove('hidden');
        });
    } else {
        console.error("Filter button with ID 'openFilterModalBtn' not found.");
    }

    // Close filter modal button
    if (closeFilterModalBtn) {
        closeFilterModalBtn.addEventListener('click', () => {
            filterModal.classList.add('hidden');
        });
    }


    filterForm.addEventListener('submit', (event) => {
        event.preventDefault();
        // Update currentFilters with values from the form
        currentFilters.min_monthly_income = filterMinMonthlyIncome.value;
        currentFilters.max_monthly_income = filterMaxMonthlyIncome.value;
        currentFilters.zone_id = filterZone.value;
        currentFilters.type_of_household_id = filterHouseholdType.value;
        currentFilters.type_of_house_material_id = filterHouseMaterial.value;
        currentFilters.has_water = filterHasWater.value;
        currentFilters.has_electricity = filterHasElectricity.value;
        currentFilters.has_toilet = filterHasToilet.value;
        currentFilters.has_internet = filterHasInternet.value;

        currentFilters.sort_by = filterSortBy.value;
        currentFilters.sort_order = filterSortOrder.value;

        recordsPerPage = parseInt(filterRecordsPerPage.value, 10) || 10; // Update recordsPerPage

        filterModal.classList.add('hidden'); // Close modal
        currentPage = 1; // Reset to first page when filters are applied
        fetchAndRenderHouseholds(); // Re-fetch data with new filters and recordsPerPage
    });

    clearFiltersBtn.addEventListener('click', () => {
        // Reset all filter fields to 'all' or empty string
        filterMinMonthlyIncome.value = '';
        filterMaxMonthlyIncome.value = '';
        filterZone.value = 'all';
        filterHouseholdType.value = 'all';
        filterHouseMaterial.value = 'all';
        filterHasWater.value = 'all';
        filterHasElectricity.value = 'all';
        filterHasToilet.value = 'all';
        filterHasInternet.value = 'all';

        filterRecordsPerPage.value = '10'; // Reset to default
        recordsPerPage = 10;

        // Also reset the currentFilters object
        currentFilters = {
            min_monthly_income: '',
            max_monthly_income: '',
            zone_id: 'all',
            type_of_household_id: 'all',
            type_of_house_material_id: 'all',
            has_water: 'all',
            has_electricity: 'all',
            has_toilet: 'all',
            has_internet: 'all',
            sort_by: 'head_last_name',
            sort_order: 'asc'
        };

        filterSortBy.value = 'head_last_name';
        filterSortOrder.value = 'asc';
        currentFilters.sort_by = 'head_last_name';
        currentFilters.sort_order = 'asc';

        filterModal.classList.add('hidden'); // Close modal
        currentPage = 1; // Reset to first page
        fetchAndRenderHouseholds(); // Re-fetch data without filters
    });

    // Close filter modal when clicking outside
    filterModal.addEventListener('click', (event) => {
        if (event.target === filterModal) {
            filterModal.classList.add('hidden');
        }
    });


    // Initial load of static lookups and household data
    populateStaticLookups();
    fetchDynamicLookupData().then(() => {
        setupHeadOfHouseholdAutocomplete();
        fetchAndRenderHouseholds();
    });

    // Assume you have an array of individuals like:
    let allIndividuals = [
        // { id: 101, name: 'Grace R. Aquino' }, ...
    ];

    // DOM elements
    const headOfHouseholdSearch = document.getElementById('headOfHouseholdSearch');
    const headOfHouseholdInput = document.getElementById('headOfHousehold');
    const suggestionsList = document.getElementById('headOfHouseholdSuggestions');

    function setupHeadOfHouseholdAutocomplete() {
        headOfHouseholdSearch.addEventListener('input', function() {
            const query = this.value.trim().toLowerCase();
            suggestionsList.innerHTML = '';
            if (!query) {
                suggestionsList.classList.add('hidden');
                headOfHouseholdInput.value = '';
                return;
            }
            const matches = allIndividuals.filter(ind =>
                ind.name.toLowerCase().includes(query)
            ).slice(0, 20);

            if (matches.length === 0) {
                suggestionsList.classList.add('hidden');
                return;
            }

            matches.forEach(ind => {
                const li = document.createElement('li');
                li.textContent = ind.name;
                li.className = 'px-4 py-2 cursor-pointer hover:bg-secondary-green hover:text-white';
                li.addEventListener('click', () => {
                    headOfHouseholdSearch.value = ind.name;
                    headOfHouseholdInput.value = ind.id;
                    suggestionsList.classList.add('hidden');
                });
                suggestionsList.appendChild(li);
            });
            suggestionsList.classList.remove('hidden');
        });

        // Hide suggestions when clicking outside
        document.addEventListener('click', function(e) {
            if (!headOfHouseholdSearch.contains(e.target) && !suggestionsList.contains(e.target)) {
                suggestionsList.classList.add('hidden');
            }
        });
    }

    // Also populate allIndividuals for the autocomplete
    allIndividuals = lookupData.allIndividuals.map(ind => ({
        id: ind.individual_id,
        name: ind.full_name
    }));

    setupHeadOfHouseholdAutocomplete();
});




function hideEditDeleteForUser() {
    if (typeof userRole !== 'undefined' && userRole === 'user') {
        document.querySelectorAll('.edit-btn, .delete-btn, .edit-family-btn, .delete-family-btn').forEach(function(btn) {
            btn.style.display = 'none';
        });
    }
}