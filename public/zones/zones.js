document.addEventListener('DOMContentLoaded', () => {
    console.log('Zones page loaded!');

    // DOM Elements
    const zonesTableBody = document.getElementById('zonesTableBody');
    const zoneSearch = document.getElementById('zoneSearch');
    const addNewZoneBtn = document.getElementById('addNewZoneBtn');
    const noZoneResults = document.getElementById('noZoneResults');

    // Pagination elements
    const prevPageBtn = document.getElementById('prevPageBtn');
    const nextPageBtn = document.getElementById('nextPageBtn');
    const paginationInfo = document.getElementById('paginationInfo');

    let currentPage = 1;
    const itemsPerPage = 10;
    let totalPages = 1;
    let currentSearchTerm = '';

    // Modal elements for Add/Edit Zone Form
    const zoneModal = document.getElementById('zoneModal');
    const zoneModalTitle = document.getElementById('zoneModalTitle');
    const zoneForm = document.getElementById('zoneForm');
    const zoneIdInput = document.getElementById('zoneId');
    const zoneNameInput = document.getElementById('zoneName');
    const zoneDescriptionInput = document.getElementById('zoneDescription');
    const cancelZoneFormBtn = document.getElementById('cancelZoneFormBtn');

    // New elements for Barangay Official Search/Select
    const barangayOfficialSearchInput = document.getElementById('barangayOfficialSearch');
    const barangayOfficialIdInput = document.getElementById('barangayOfficialId');
    const barangayOfficialSuggestions = document.getElementById('barangayOfficialSuggestions');

    // View Zone Details Modal elements
    const viewZoneModal = document.getElementById('viewZoneModal');
    const viewZoneName = document.getElementById('viewZoneName');
    const viewAssignedOfficial = document.getElementById('viewAssignedOfficial');
    const viewZoneDescription = document.getElementById('viewZoneDescription');
    const viewHouseholdsCount = document.getElementById('viewHouseholdsCount');
    // NEW: Population Statistics DOM elements
    const viewTotalPopulation = document.getElementById('viewTotalPopulation');
    const viewMostCommonSurname = document.getElementById('viewMostCommonSurname');
    const viewMaleCount = document.getElementById('viewMaleCount');
    const viewFemaleCount = document.getElementById('viewFemaleCount');
    const viewMinorsCount = document.getElementById('viewMinorsCount');
    const viewSeniorsCount = document.getElementById('viewSeniorsCount');

    const closeViewZoneModalBtn = document.getElementById('closeViewZoneModalBtn');

    // Custom Modal elements (for alerts/confirmations)
    const customModal = document.getElementById('customModal');
    const customModalTitle = document.getElementById('customModalTitle');
    const customModalMessage = document.getElementById('customModalMessage');
    const customModalConfirmBtn = document.getElementById('customModalConfirm');
    const customModalCancelBtn = document.getElementById('customModalCancel');

    // --- Mobile Menu Elements and Logic (Copied from Overview) ---
    const mobileMenuButton = document.getElementById('mobileMenuButton');
    const mainSidebar = document.getElementById('mainSidebar');
    const mobileMenuOverlay = document.getElementById('mobileMenuOverlay');

    if (mobileMenuButton && mainSidebar && mobileMenuOverlay) {
        mobileMenuButton.addEventListener('click', () => {
            mainSidebar.classList.add('open');
            mobileMenuOverlay.classList.add('open');
            document.body.classList.add('overflow-hidden-mobile');
            mobileMenuButton.classList.add('invisible'); // Hide hamburger
        });

        mobileMenuOverlay.addEventListener('click', () => {
            mainSidebar.classList.remove('open');
            mobileMenuOverlay.classList.remove('open');
            document.body.classList.remove('overflow-hidden-mobile');
            mobileMenuButton.classList.remove('invisible'); // Show hamburger
        });

        // Close sidebar if a navigation link is clicked (good UX)
        const navLinks = mainSidebar.querySelectorAll('nav a');
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                if (window.innerWidth < 1024) {
                    mainSidebar.classList.remove('open');
                    mobileMenuOverlay.classList.remove('open');
                    document.body.classList.remove('overflow-hidden-mobile');
                    mobileMenuButton.classList.remove('invisible'); // Show hamburger
                }
            });
        });
    } else {
        console.error('One or more mobile menu elements not found:', { mobileMenuButton, mainSidebar, mobileMenuOverlay });
    }

    // --- Helper Functions for Modals ---

    /**
     * Shows the custom modal for alerts or confirmations.
     * @param {string} message The message to display.
     * @param {string} type 'alert' for a single OK button, 'confirm' for Confirm/Cancel.
     * @param {function} onConfirm Callback function for 'confirm' type.
     */
    function showCustomModal(message, type, onConfirm = null) {
        customModalMessage.textContent = message;
        customModalConfirmBtn.onclick = null; // Clear previous handlers
        customModalCancelBtn.onclick = null; // Clear previous handlers

        if (type === 'alert') {
            customModalTitle.textContent = 'Notification';
            customModalConfirmBtn.textContent = 'OK';
            customModalConfirmBtn.classList.remove('hidden');
            customModalCancelBtn.classList.add('hidden');
            customModalConfirmBtn.onclick = () => customModal.classList.add('hidden');
        } else if (type === 'confirm') {
            customModalTitle.textContent = 'Confirm Action';
            customModalConfirmBtn.textContent = 'Confirm';
            customModalConfirmBtn.classList.remove('hidden');
            customModalCancelBtn.classList.remove('hidden');
            customModalConfirmBtn.onclick = () => {
                customModal.classList.add('hidden');
                if (onConfirm) onConfirm();
            };
            customModalCancelBtn.onclick = () => customModal.classList.add('hidden');
        }
        customModal.classList.remove('hidden');
        customModal.focus(); // Focus the modal to capture keyboard events if needed
    }

    // --- Debounce Function ---
    // This function is crucial for preventing excessive calls to fetchBarangayOfficials
    // when the user types quickly in the search input.
    const debounce = (func, delay) => {
        let timeout;
        return function(...args) {
            const context = this;
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(context, args), delay);
        };
    };

    // --- Data Fetching Functions ---

    /**
     * Fetches the list of barangay officials (individuals) from the backend based on search term.
     * @param {string} searchTerm Optional search term to filter individuals.
     */
    async function fetchBarangayOfficials(searchTerm = '') {
        try {
            // Only fetch if searchTerm is not empty to avoid fetching all on initial load or empty input
            if (searchTerm.length < 2 && searchTerm !== '') { // Require at least 2 characters for search
                barangayOfficialSuggestions.innerHTML = '';
                barangayOfficialSuggestions.classList.add('hidden');
                return;
            }
            
            // Corrected API path
            const response = await fetch(`../api/zone.php?action=getOfficials&search=${encodeURIComponent(searchTerm)}`);
            const result = await response.json();
            
            if (result.status === 'success') {
                renderOfficialSuggestions(result.data);
            } else {
                console.error('Error fetching officials:', result.message);
                barangayOfficialSuggestions.innerHTML = `<div class="p-2 text-red-500">Error: ${result.message}</div>`;
                barangayOfficialSuggestions.classList.remove('hidden');
            }
        } catch (error) {
            console.error('Error fetching officials:', error);
            barangayOfficialSuggestions.innerHTML = `<div class="p-2 text-red-500">Error loading officials.</div>`;
            barangayOfficialSuggestions.classList.remove('hidden');
        }
    }

    /**
     * Renders the fetched official suggestions into the suggestions div.
     * @param {Array<Object>} officials An array of official objects with individual_id and full_name.
     */
    function renderOfficialSuggestions(officials) {
        barangayOfficialSuggestions.innerHTML = ''; // Clear previous suggestions

        if (officials.length === 0) {
            barangayOfficialSuggestions.innerHTML = '<div class="p-2 text-gray-500">No matching officials found.</div>';
            barangayOfficialSuggestions.classList.remove('hidden');
            return;
        }

        officials.forEach(official => {
            const suggestionItem = document.createElement('div');
            suggestionItem.classList.add('p-2', 'cursor-pointer', 'hover:bg-gray-200', 'rounded-md');
            suggestionItem.textContent = official.full_name;
            suggestionItem.dataset.id = official.individual_id;
            suggestionItem.dataset.name = official.full_name;
            barangayOfficialSuggestions.appendChild(suggestionItem);
        });
        barangayOfficialSuggestions.classList.remove('hidden');
    }

    /**
     * Handles the selection of an official from the suggestions list.
     * @param {Event} event The click event.
     */
    function selectOfficial(event) {
        const selectedItem = event.target.closest('div[data-id]');
        if (selectedItem) {
            barangayOfficialSearchInput.value = selectedItem.dataset.name;
            barangayOfficialIdInput.value = selectedItem.dataset.id;
            barangayOfficialSuggestions.classList.add('hidden');
        }
    }

    /**
     * Fetches and renders zones into the table.
     */
    async function fetchAndRenderZones() {
        zonesTableBody.innerHTML = ''; // Clear existing rows
        noZoneResults.classList.add('hidden'); // Hide no results message initially

        try {
            // Corrected API path
            const response = await fetch(`../api/zone.php?page=${currentPage}&limit=${itemsPerPage}&search=${encodeURIComponent(currentSearchTerm)}`);
            const result = await response.json();

            if (result.status === 'success') {
                const zones = result.data;
                totalPages = Math.ceil(result.total / itemsPerPage);

                if (zones.length === 0) {
                    noZoneResults.classList.remove('hidden');
                } else {
                    zones.forEach(zone => {
                        const row = zonesTableBody.insertRow();
                        row.innerHTML = `
                            <td class="px-6 py-4 whitespace-nowrap">${zone.zone_name}</td>
                            <td class="px-6 py-4 whitespace-nowrap">${zone.description || 'N/A'}</td>
                            <td class="px-6 py-4 whitespace-nowrap">${zone.households_count}</td>
                            <td class="px-6 py-4 whitespace-nowrap">${zone.assigned_official_name || 'Unassigned'}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-right action-buttons">
                                <button type="button" data-zone-id="${zone.zone_id}" class="view-details-btn bg-green-100 text-green-800 py-1 px-2 rounded-md hover:bg-green-200 transition-colors duration-200">
                                    <i class="fas fa-eye"></i> View
                                </button>
                                <button type="button" data-zone-id="${zone.zone_id}" class="edit-btn bg-blue-200 text-blue-800 py-1 px-2 rounded-md hover:bg-blue-300 transition-colors duration-200">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <button type="button" data-zone-id="${zone.zone_id}" class="delete-btn bg-red-200 text-red-800 py-1 px-2 rounded-md hover:bg-red-300 transition-colors duration-200">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </button>
                            </td>
                        `;
                    });
                }
                updatePaginationInfo(result.total);

                // --- ADD THIS LINE ---
                hideEditDeleteForUser();
            } else {
                console.error('Error fetching zones:', result.message);
                noZoneResults.textContent = 'Error loading zones: ' + result.message;
                noZoneResults.classList.remove('hidden');
            }
            
        } catch (error) {
            console.error('Error fetching zones:', error);
            noZoneResults.textContent = 'An error occurred while fetching zones. Please try again.';
            noZoneResults.classList.remove('hidden');
        }
    }

    /**
     * Updates the pagination information text and button states.
     * @param {number} totalItems Total number of items.
     */
    function updatePaginationInfo(totalItems) {
        const start = (currentPage - 1) * itemsPerPage + 1;
        const end = Math.min(currentPage * itemsPerPage, totalItems);
        paginationInfo.textContent = `${start}-${end} of ${totalItems}`;

        prevPageBtn.disabled = currentPage === 1;
        nextPageBtn.disabled = currentPage === totalPages;

        // Add Tailwind classes for disabled state
        if (currentPage === 1) {
            prevPageBtn.classList.add('opacity-50', 'cursor-not-allowed');
        } else {
            prevPageBtn.classList.remove('opacity-50', 'cursor-not-allowed');
        }
        if (currentPage === totalPages) {
            nextPageBtn.classList.add('opacity-50', 'cursor-not-allowed');
        } else {
            nextPageBtn.classList.remove('opacity-50', 'cursor-not-allowed');
        }
    }

    /**
     * Handles adding a new zone or updating an existing one.
     * @param {Event} event The form submission event.
     */
    async function handleZoneFormSubmit(event) {
        event.preventDefault();

        const zoneId = zoneIdInput.value;
        const zoneName = zoneNameInput.value.trim();
        const zoneDescription = zoneDescriptionInput.value.trim();
        // Get the individual_id from the hidden input
        const barangayOfficialAssignedId = barangayOfficialIdInput.value === '' ? null : parseInt(barangayOfficialIdInput.value);

        if (!zoneName) {
            showCustomModal('Zone name is required.', 'alert');
            return;
        }

        const method = zoneId ? 'PUT' : 'POST';
        // Corrected API path
        const url = '../api/zone.php';
        const data = {
            zone_name: zoneName,
            description: zoneDescription,
            barangay_official_assigned_individual_id: barangayOfficialAssignedId
        };
        if (zoneId) {
            data.zone_id = zoneId;
        }

        try {
            const response = await fetch(url, {
                method: 'POST', // Always POST for PHP, actual method handled by PHP
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ method: method, ...data }) // Send method in body for PHP
            });
            const result = await response.json();

            if (result.status === 'success') {
                showCustomModal(result.message, 'alert');
                zoneModal.classList.add('hidden');
                zoneForm.reset();
                // Clear the search input and hidden ID after successful submission
                barangayOfficialSearchInput.value = '';
                barangayOfficialIdInput.value = '';
                barangayOfficialSuggestions.classList.add('hidden');
                currentPage = 1; // Reset to first page on successful add/edit
                fetchAndRenderZones(); // Re-fetch and render zones
            } else {
                showCustomModal('Operation failed: ' + result.message, 'alert');
            }
        } catch (error) {
            console.error('Error saving zone:', error);
            showCustomModal('An error occurred while saving the zone: ' + error.message, 'alert');
        }
    }

    /**
     * Fetches a single zone's data for editing.
     * @param {string} zoneId The ID of the zone to edit.
     */
    async function editZone(zoneId) {
        try {
            // Corrected API path
            const response = await fetch(`../api/zone.php?id=${zoneId}`);
            const result = await response.json();

            if (result.status === 'success' && result.data) {
                const zone = result.data;
                zoneModalTitle.textContent = 'Edit Zone';
                zoneIdInput.value = zone.zone_id;
                zoneNameInput.value = zone.zone_name;
                zoneDescriptionInput.value = zone.description || '';
                
                // Set the search input and hidden ID for the assigned official
                if (zone.barangay_official_assigned_individual_id && zone.assigned_official_name) {
                    barangayOfficialSearchInput.value = zone.assigned_official_name;
                    barangayOfficialIdInput.value = zone.barangay_official_assigned_individual_id;
                } else {
                    barangayOfficialSearchInput.value = '';
                    barangayOfficialIdInput.value = '';
                }
                barangayOfficialSuggestions.innerHTML = ''; // Clear suggestions
                barangayOfficialSuggestions.classList.add('hidden'); // Hide suggestions

                zoneModal.classList.remove('hidden');
            } else {
                showCustomModal(result.message || 'Zone details not found.', 'alert');
            }
        } catch (error) {
            console.error('Error fetching zone for edit:', error);
            showCustomModal(`Error loading zone details: ${error.message}`, 'alert');
        }
    }

    /**
     * Displays a single zone's data in the view modal, including new statistics.
     * @param {string} zoneId The ID of the zone to view.
     */
    async function viewZoneDetails(zoneId) {
        try {
            // Corrected API path
            const response = await fetch(`../api/zone.php?id=${zoneId}`);
            const result = await response.json();

            if (result.status === 'success' && result.data) {
                const zone = result.data;
                viewZoneName.textContent = zone.zone_name;
                viewAssignedOfficial.textContent = zone.assigned_official_name || 'Unassigned';
                viewZoneDescription.textContent = zone.description || 'No description provided.';
                viewHouseholdsCount.textContent = zone.households_count;

                // Populate new population statistics
                if (zone.statistics) {
                    viewTotalPopulation.textContent = zone.statistics.total_population;
                    // Display surname count if available
                    viewMostCommonSurname.textContent = zone.statistics.most_common_surname + 
                        (zone.statistics.most_common_surname_count > 0 ? ` (${zone.statistics.most_common_surname_count} individuals)` : '');
                    viewMaleCount.textContent = zone.statistics.male_count;
                    viewFemaleCount.textContent = zone.statistics.female_count;
                    viewMinorsCount.textContent = zone.statistics.minors_count;
                    viewSeniorsCount.textContent = zone.statistics.seniors_count;
                } else {
                    // Fallback if statistics are not available
                    viewTotalPopulation.textContent = 'N/A';
                    viewMostCommonSurname.textContent = 'N/A';
                    viewMaleCount.textContent = 'N/A';
                    viewFemaleCount.textContent = 'N/A';
                    viewMinorsCount.textContent = 'N/A';
                    viewSeniorsCount.textContent = 'N/A';
                }

                viewZoneModal.classList.remove('hidden');
            } else {
                showCustomModal(result.message || 'Zone details not found.', 'alert');
            }
        } catch (error) {
            console.error('Error fetching zone for view:', error);
            showCustomModal(`Error loading zone details: ${error.message}`, 'alert');
        }
    }

    /**
     * Deletes a zone after confirmation.
     * @param {string} zoneId The ID of the zone to delete.
     */
    function deleteZone(zoneId) {
        showCustomModal('Are you sure you want to delete this zone? This action cannot be undone.', 'confirm', async () => {
            try {
                // Corrected API path
                const response = await fetch('../api/zone.php', {
                    method: 'POST', // Always POST for PHP, actual method handled by PHP
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ method: 'DELETE', zone_id: zoneId }) // Send method in body for PHP
                });
                const result = await response.json();

                if (result.status === 'success') {
                    showCustomModal(result.message, 'alert');
                    currentPage = 1; // Reset to first page on successful deletion
                    fetchAndRenderZones(); // Re-fetch and render zones
                } else {
                    showCustomModal('Deletion failed: ' + result.message, 'alert');
                }
            } catch (error) {
                console.error('Error deleting zone:', error);
                showCustomModal('An error occurred during deletion: ' + error.message, 'alert');
            }
        });
    }

    // --- Event Listeners ---

    // Add New Zone button click
    if (addNewZoneBtn) {
        addNewZoneBtn.addEventListener('click', () => {
            zoneModalTitle.textContent = 'Add New Zone';
            zoneIdInput.value = ''; // Clear ID for new entry
            zoneForm.reset(); // Clear form fields
            
            // Clear the search input and hidden ID for the assigned official
            barangayOfficialSearchInput.value = '';
            barangayOfficialIdInput.value = '';
            barangayOfficialSuggestions.innerHTML = ''; // Clear suggestions
            barangayOfficialSuggestions.classList.add('hidden'); // Hide suggestions

            zoneModal.classList.remove('hidden');
        });
    }

    // Cancel button in Add/Edit modal
    if (cancelZoneFormBtn) {
        cancelZoneFormBtn.addEventListener('click', () => {
            zoneModal.classList.add('hidden');
            zoneForm.reset();
            // Clear the search input and hidden ID when closing modal
            barangayOfficialSearchInput.value = '';
            barangayOfficialIdInput.value = '';
            barangayOfficialSuggestions.innerHTML = ''; // Clear suggestions
            barangayOfficialSuggestions.classList.add('hidden'); // Hide suggestions
        });
    }

    // Close button in View Details modal
    if (closeViewZoneModalBtn) {
        closeViewZoneModalBtn.addEventListener('click', () => {
            viewZoneModal.classList.add('hidden');
        });
    }

    // Form submission for Add/Edit Zone
    if (zoneForm) {
        zoneForm.addEventListener('submit', handleZoneFormSubmit);
    }

    // Delegated event listener for Edit, Delete, and View buttons on the table body
    if (zonesTableBody) {
        zonesTableBody.addEventListener('click', (event) => {
            if (event.target.closest('.edit-btn')) {
                const zoneId = event.target.closest('.edit-btn').dataset.zoneId;
                editZone(zoneId);
            } else if (event.target.closest('.delete-btn')) {
                const zoneId = event.target.closest('.delete-btn').dataset.zoneId;
                deleteZone(zoneId);
            } else if (event.target.closest('.view-details-btn')) {
                const zoneId = event.target.closest('.view-details-btn').dataset.zoneId;
                viewZoneDetails(zoneId);
            }
        });
    }

    // Pagination event listeners
    if (prevPageBtn) prevPageBtn.addEventListener('click', () => {
        if (currentPage > 1) {
            currentPage--;
            fetchAndRenderZones();
        }
    });

    if (nextPageBtn) nextPageBtn.addEventListener('click', () => {
        if (currentPage < totalPages) {
            currentPage++;
            fetchAndRenderZones();
        }
    });

    // Search input for main zones table with debounce
    let zoneSearchTimeout;
    if (zoneSearch) {
        zoneSearch.addEventListener('input', () => {
            clearTimeout(zoneSearchTimeout);
            zoneSearchTimeout = setTimeout(() => {
                currentSearchTerm = zoneSearch.value.trim();
                currentPage = 1; // Reset to first page on new search
                fetchAndRenderZones();
            }, 300); // 300ms debounce
        });
    }

    // Event listeners for Barangay Official Search/Select
    if (barangayOfficialSearchInput) {
        barangayOfficialSearchInput.addEventListener('input', debounce(() => {
            fetchBarangayOfficials(barangayOfficialSearchInput.value.trim());
        }, 300)); // Debounce for official search

        // Hide suggestions when input loses focus, but with a slight delay
        // to allow click event on suggestions to fire first
        barangayOfficialSearchInput.addEventListener('blur', () => {
            setTimeout(() => {
                barangayOfficialSuggestions.classList.add('hidden');
            }, 150); 
        });

        // Show suggestions again if input is focused and has text
        barangayOfficialSearchInput.addEventListener('focus', () => {
            if (barangayOfficialSearchInput.value.trim().length > 0) {
                // Re-fetch or just show existing if already populated and not empty
                fetchBarangayOfficials(barangayOfficialSearchInput.value.trim());
            }
        });

        // Clear hidden ID if search input is cleared
        barangayOfficialSearchInput.addEventListener('keyup', (event) => {
            if (barangayOfficialSearchInput.value.trim() === '') {
                barangayOfficialIdInput.value = ''; // Clear selected ID
                barangayOfficialSuggestions.innerHTML = ''; // Clear suggestions
                barangayOfficialSuggestions.classList.add('hidden'); // Hide suggestions
            }
        });
    }

    // Delegated event listener for clicking on official suggestions
    if (barangayOfficialSuggestions) {
        barangayOfficialSuggestions.addEventListener('mousedown', (event) => {
            // Use mousedown instead of click to prevent blur event on input from hiding suggestions too soon
            event.preventDefault(); // Prevent input blur from happening before click
            selectOfficial(event);
        });
    }

    // Add this function near the top, outside of any other function
    function hideEditDeleteForUser() {
        if (typeof userRole !== 'undefined' && userRole === 'user') {
            // Hide add button
            const addBtn = document.getElementById('addNewZoneBtn');
            if (addBtn) addBtn.style.display = 'none';
            // Hide all edit and delete buttons
            document.querySelectorAll('.edit-btn, .delete-btn').forEach(btn => {
                btn.style.display = 'none';
            });
        }
    }

    // Initial fetch when the page loads
    fetchAndRenderZones();
});




