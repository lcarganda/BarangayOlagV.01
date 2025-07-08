document.addEventListener('DOMContentLoaded', () => {
    console.log('Individuals page loaded!');

    const individualsTableBody = document.getElementById('individualsTableBody');
    const individualSearch = document.getElementById('individualSearch');
    const addNewIndividualBtn = document.getElementById('addNewIndividualBtn');
    const noResultsMessage = document.getElementById('noResults');

    // Pagination elements
    const prevPageBtn = document.getElementById('prevPageBtn');
    const nextPageBtn = document.getElementById('nextPageBtn');
    const paginationInfo = document.getElementById('paginationInfo');

    let currentPage = 1;
    let itemsPerPage = 10; // Default value
    let totalPages = 1;
    let currentSearchTerm = ''; // To persist search when changing pages

    // Modal elements for Add/Edit Individual Form
    const individualModal = document.getElementById('individualModal');
    const modalTitle = document.getElementById('modalTitle');
    const individualForm = document.getElementById('individualForm');
    const individualIdInput = document.getElementById('individualId');
    const cancelIndividualBtn = document.getElementById('cancelIndividualBtn');

    // Form fields
    const surnameInput = document.getElementById('surname');
    const firstNameInput = document.getElementById('firstName');
    const middleNameInput = document.getElementById('middleName');
    const genderSelect = document.getElementById('gender');
    const birthDateInput = document.getElementById('birthDate');
    const civilStatusSelect = document.getElementById('civilStatus');
    const bloodTypeSelect = document.getElementById('bloodType');
    const religionSelect = document.getElementById('religion');
    const contactNumberInput = document.getElementById('contactNumber');
    const emailInput = document.getElementById('email');
    const salaryIncomeInput = document.getElementById('salaryIncome');
    const isSoloParentCheckbox = document.getElementById('isSoloParent');
    const hasDisabilityCheckbox = document.getElementById('hasDisability');
    const isStudentCheckbox = document.getElementById('isStudent');
    const schoolAttendingInput = document.getElementById('schoolAttending');
    const isScholarCheckbox = document.getElementById('isScholar');
    const educationalAttainmentSelect = document.getElementById('educationalAttainment');
    const isAliveCheckbox = document.getElementById('isAlive');
    const isRegisteredVoterCheckbox = document.getElementById('isRegisteredVoter');
    const isOfwCheckbox = document.getElementById('isOfw');
    const isSssMemberCheckbox = document.getElementById('isSssMember');
    const isGsisMemberCheckbox = document.getElementById('isGsisMember');
    const isPhilhealthMemberCheckbox = document.getElementById('isPhilhealthMember');
    const workingForInput = document.getElementById('workingFor');
    const occupationInput = document.getElementById('occupation');
    const is4psBeneficiaryCheckbox = document.getElementById('is4psBeneficiary');

    const studentFieldsDiv = document.getElementById('studentFields');

    // View Individual Details Modal Elements
    const viewIndividualModal = document.getElementById('viewIndividualModal');
    const individualDetailsContent = document.getElementById('individualDetailsContent');
    const closeViewIndividualBtn = document.getElementById('closeViewIndividualBtn');


    // Custom Modal for confirmation and alerts (replaces window.confirm/alert)
    const customModal = document.createElement('div');
    customModal.id = 'customModal';
    customModal.className = 'fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50'; // Higher z-index
    customModal.innerHTML = `
        <div class="bg-white p-6 rounded-lg shadow-xl max-w-sm w-full mx-4 text-center">
            <p id="modalMessage" class="text-lg mb-4"></p>
            <div id="modalButtons" class="flex justify-center space-x-4">
                <button id="modalConfirmBtn" class="bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600 hidden">Confirm</button>
                <button id="modalCancelBtn" class="bg-gray-300 text-gray-800 px-4 py-2 rounded-md hover:bg-gray-400">Cancel</button>
                <button id="modalOkBtn" class="bg-secondary-green text-white px-4 py-2 rounded-md hover:bg-green-700 hidden">OK</button>
            </div>
        </div>
    `;
    document.body.appendChild(customModal);

    const modalMessage = document.getElementById('modalMessage');
    const modalConfirmBtn = document.getElementById('modalConfirmBtn');
    const modalCancelBtn = document.getElementById('modalCancelBtn');
    const modalOkBtn = document.getElementById('modalOkBtn');

    // Function to show custom modal
    function showCustomModal(message, type = 'alert', callback = null) {
        modalMessage.textContent = message;
        customModal.classList.remove('hidden');

        modalConfirmBtn.classList.add('hidden'); // Hide by default
        modalCancelBtn.classList.add('hidden'); // Hide by default
        modalOkBtn.classList.add('hidden');    // Hide by default

        if (type === 'confirm') {
            modalConfirmBtn.onclick = () => {
                customModal.classList.add('hidden');
                if (callback) callback(true);
            };
            modalCancelBtn.onclick = () => {
                customModal.classList.add('hidden');
                if (callback) callback(false);
            };
            modalConfirmBtn.classList.remove('hidden');
            modalCancelBtn.classList.remove('hidden');
        } else { // type === 'alert'
            modalOkBtn.onclick = () => {
                customModal.classList.add('hidden');
                if (callback) callback();
            };
            modalOkBtn.classList.remove('hidden');
        }
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

    // --- Filter Modal Elements ---
    const filterModal = document.getElementById('filterModal');
    const openFilterModalBtn = document.getElementById('openFilterModalBtn');
    const filterForm = document.getElementById('filterForm');
    const clearFiltersBtn = document.getElementById('clearFiltersBtn');
    const applyFiltersBtn = document.getElementById('applyFiltersBtn');

    // Diagnostic log for the filter button element
    console.log('openFilterModalBtn element:', openFilterModalBtn);

    // Filter form fields
    const filterAgeGroup = document.getElementById('filterAgeGroup');
    const filterGender = document.getElementById('filterGender');
    const filterIsAlive = document.getElementById('filterIsAlive');
    const filterIsStudent = document.getElementById('filterIsStudent');
    const filterIs4ps = document.getElementById('filterIs4ps');
    const filterIsRegisteredVoter = document.getElementById('filterIsRegisteredVoter');
    const filterIsOfw = document.getElementById('filterIsOfw');
    const filterIsSssMember = document.getElementById('filterIsSssMember');
    const filterIsGsisMember = document.getElementById('filterIsGsisMember');
    const filterIsPhilhealthMember = document.getElementById('filterPhilhealthMember'); // Corrected ID from filterPhilhealthMember
    const filterReligion = document.getElementById('filterReligion');
    const filterCivilStatus = document.getElementById('filterCivilStatus');
    const filterBloodType = document.getElementById('filterBloodType');
    const filterEducationalAttainment = document.getElementById('filterEducationalAttainment');
    // Removed filterWorkingFor and filterOccupation

    // Object to store current filter values
    let currentFilters = {
        age_group: 'all',
        gender: 'all',
        is_alive: 'all', // 'all', 'true', or 'false'
        is_student: 'all',
        is_4ps_beneficiary: 'all',
        is_registered_voter: 'all',
        is_ofw: 'all',
        is_sss_member: 'all',
        is_gsis_member: 'all',
        is_philhealth_member: 'all',
        religion_id: 'all',
        civil_status_id: 'all',
        blood_type_id: 'all',
        educational_attainment_id: 'all'
        // Removed working_for and occupation
    };


    // --- Lookup Data Hardcoded ---
    let lookupData = {
        civilStatus: [
            { id: 1, status_name: 'Single' },
            { id: 2, status_name: 'Married' },
            { id: 3, status_name: 'Widowed' },
            { id: 4, status_name: 'Separated' },
            { id: 5, status_name: 'Divorced' }
        ],
        bloodType: [
            { id: 1, blood_type_name: 'A+' },
            { id: 2, blood_type_name: 'A-' },
            { id: 3, blood_type_name: 'B+' },
            { id: 4, blood_type_name: 'B-' },
            { id: 5, blood_type_name: 'AB+' },
            { id: 6, blood_type_name: 'AB-' },
            { id: 7, blood_type_name: 'O+' },
            { id: 8, blood_type_name: 'O-' }
        ],
        religion: [
            { id: 1, religion_name: 'Roman Catholic' },
            { id: 2, religion_name: 'Islam' },
            { id: 3, religion_name: 'Protestant' },
            { id: 4, religion_name: 'Iglesia ni Cristo' },
            { id: 5, religion_name: 'Other Christian' },
            { id: 6, religion_name: 'Born Again Christian' },
            { id: 7, religion_name: 'Jehovah Witness' },
            { id: 8, religion_name: 'Seventh-Day Adventist' },
            { id: 9, religion_name: 'None' }
        ],
        educationalAttainment: [
            { id: 1, attainment_name: 'No Formal Education' },
            { id: 2, attainment_name: 'Elementary Level' },
            { id: 3, attainment_name: 'Elementary Graduate' },
            { id: 4, attainment_name: 'High School Level' },
            { id: 5, attainment_name: 'High School Graduate' },
            { id: 6, attainment_name: 'Vocational Course' },
            { id: 7, attainment_name: 'College Level' },
            { id: 8, attainment_name: 'College Graduate' },
            { id: 9, attainment_name: 'Post-Graduate' }
        ],
        gender: [
            { id: 'Male', name: 'Male' },
            { id: 'Female', name: 'Female' }
        ]
    };

    // Function to populate dropdowns (now uses hardcoded data)
    async function fetchLookupData() {
        console.log('Populating dropdowns from hardcoded data...');
        populateDropdown(genderSelect, lookupData.gender, 'name');
        populateDropdown(civilStatusSelect, lookupData.civilStatus, 'status_name');
        populateDropdown(bloodTypeSelect, lookupData.bloodType, 'blood_type_name');
        populateDropdown(religionSelect, lookupData.religion, 'religion_name');
        populateDropdown(educationalAttainmentSelect, lookupData.educationalAttainment, 'attainment_name');

        // Populate filter dropdowns
        populateDropdown(filterGender, lookupData.gender, 'name', true); // includeAll = true
        populateDropdown(filterReligion, lookupData.religion, 'religion_name', true);
        populateDropdown(filterCivilStatus, lookupData.civilStatus, 'status_name', true);
        populateDropdown(filterBloodType, lookupData.bloodType, 'blood_type_name', true);
        populateDropdown(filterEducationalAttainment, lookupData.educationalAttainment, 'attainment_name', true);

        console.log('Dropdowns populated from hardcoded data.');
        return true; // Always successful now
    }

    // Helper function to populate a select dropdown
    function populateDropdown(selectElement, data, nameField, includeAll = false) {
        selectElement.innerHTML = '';
        if (includeAll) {
            const allOption = document.createElement('option');
            allOption.value = 'all';
            allOption.textContent = 'All';
            selectElement.appendChild(allOption);
        } else {
            selectElement.innerHTML = '<option value="">Select an option</option>'; // Default empty option for form
        }
        
        data.forEach(item => {
            const option = document.createElement('option');
            option.value = String(item.id); // Ensure option value is always a string
            option.textContent = item[nameField];
            selectElement.appendChild(option);
        });
        console.log(`Dropdown ${selectElement.id} populated with ${data.length} options.`);
    }

    // Centralized function to set and debug select dropdowns (moved to higher scope)
    const setAndLogSelect = (selectElement, individualValue, debugName) => {
        // Ensure the value being set is always a string for comparison with option.value
        const valueToSet = String(individualValue || '');
        console.log(`- [${debugName}] Attempting to set value to: "${valueToSet}" (type: ${typeof valueToSet})`);
        
        // Get all available option values for comparison
        const availableOptions = Array.from(selectElement.options).map(option => option.value);
        console.log(`- [${debugName}] Available option values:`, availableOptions);

        // IMPORTANT: Add a small delay to allow DOM to fully render options
        setTimeout(() => {
            selectElement.value = valueToSet;
            
            // Verify if the value was successfully set and is visually reflected
            const actualValue = selectElement.value;
            const selectedOption = selectElement.querySelector(`option[value="${actualValue}"]`);
            const isActuallySelected = selectedOption ? selectedOption.selected : false;

            console.log(`- [${debugName}] (After setTimeout) Actual value after attempt: "${actualValue}"`);
            console.log(`- [${debugName}] (After setTimeout) Is option with value "${actualValue}" selected? ${isActuallySelected}`);


            if (actualValue !== valueToSet && valueToSet !== '') {
                console.warn(`- [${debugName}] WARNING: Desired value "${valueToSet}" was NOT set (or immediately reset). Actual value is "${actualValue}".`);
            } else if (valueToSet === '' && actualValue === '') {
                console.log(`- [${debugName}] Value is empty and correctly remains empty.`);
            } else if (valueToSet === actualValue) {
                console.log(`- [${debugName}] Value "${valueToSet}" successfully set.`);
            }

            if (!isActuallySelected && valueToSet !== '') {
                console.warn(`- [${debugName}] CRITICAL WARNING: Value "${valueToSet}" IS NOT VISUALLY SELECTED in the DOM, even if select.value matched. This indicates a rendering issue.`);
            }


        }, 100); // Increased to 100ms delay
    };

    /**
     * Calculates the accurate age based on a birth date string.
     * @param {string} birthDateString The birth date in 'YYYY-MM-DD' format.
     * @returns {number|string} The calculated age or 'N/A' if birthDateString is invalid.
     * NOTE: This function is no longer strictly needed for table display as age is calculated on backend.
     * It is kept for potential use in the view modal or if backend calculation is removed.
     */
    function calculateAge(birthDateString) {
        if (!birthDateString) return 'N/A';
        const today = new Date();
        const birthDate = new Date(birthDateString);

        let age = today.getFullYear() - birthDate.getFullYear();
        const monthDifference = today.getMonth() - birthDate.getMonth();

        if (monthDifference < 0 || (monthDifference === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }
        return age;
    }


    // Function to open the Add/Edit modal
    function openIndividualModal(individual = null) {
        individualForm.reset(); // Clear form
        individualIdInput.value = ''; // Clear hidden ID

        // Reset checkboxes to default (false) for new individual, or load existing
        isSoloParentCheckbox.checked = false;
        hasDisabilityCheckbox.checked = false;
        isStudentCheckbox.checked = false;
        isScholarCheckbox.checked = false;
        isAliveCheckbox.checked = true; // Default to true for new
        isRegisteredVoterCheckbox.checked = false;
        isOfwCheckbox.checked = false;
        isSssMemberCheckbox.checked = false;
        isGsisMemberCheckbox.checked = false;
        isPhilhealthMemberCheckbox.checked = false;
        is4psBeneficiaryCheckbox.checked = false;
        
        // Clear text fields that might be dependent on checkboxes
        schoolAttendingInput.value = '';
        salaryIncomeInput.value = '';
        contactNumberInput.value = '';
        emailInput.value = '';
        workingForInput.value = '';
        occupationInput.value = '';
        middleNameInput.value = '';


        // Populate fields if individual data is provided (for editing)
        if (individual) {
            console.group('Populating Edit Modal with data for individual ID:', individual.individual_id);
            console.log('Individual data received:', individual); // This shows the raw data from API
            modalTitle.textContent = 'Edit Individual';
            individualIdInput.value = individual.individual_id;
            surnameInput.value = individual.surname;
            firstNameInput.value = individual.first_name;
            middleNameInput.value = individual.middle_name;
            
            // Gender also uses setAndLogSelect for consistency and debugging
            setAndLogSelect(genderSelect, individual.gender, 'genderSelect');
            
            birthDateInput.value = individual.birth_date;
            
            setAndLogSelect(civilStatusSelect, individual.civil_status_id, 'civilStatusSelect');
            setAndLogSelect(bloodTypeSelect, individual.blood_type_id, 'bloodTypeSelect');
            setAndLogSelect(religionSelect, individual.religion_id, 'religionSelect');
            setAndLogSelect(educationalAttainmentSelect, individual.educational_attainment_id, 'educationalAttainmentSelect');

            contactNumberInput.value = individual.contact_number;
            emailInput.value = individual.email;
            // Ensure salary_income is treated as number, if null it should be empty string for input
            salaryIncomeInput.value = individual.salary_income !== null ? parseFloat(individual.salary_income) : ''; 
            isSoloParentCheckbox.checked = individual.is_solo_parent;
            hasDisabilityCheckbox.checked = individual.has_disability;
            isStudentCheckbox.checked = individual.is_student; // Set student checkbox first
            schoolAttendingInput.value = individual.school_attending;
            isScholarCheckbox.checked = individual.is_scholar;
            isAliveCheckbox.checked = individual.is_alive;
            isRegisteredVoterCheckbox.checked = individual.is_registered_voter;
            isOfwCheckbox.checked = individual.is_ofw;
            isSssMemberCheckbox.checked = individual.is_sss_member;
            isGsisMemberCheckbox.checked = individual.is_gsis_member;
            isPhilhealthMemberCheckbox.checked = individual.is_philhealth_member;
            workingForInput.value = individual.working_for;
            occupationInput.value = individual.occupation;
            is4psBeneficiaryCheckbox.checked = individual.is_4ps_beneficiary;

            console.groupEnd(); // End group for this individual
        } else {
            console.log('Opening Add New Individual Modal (new entry).');
            modalTitle.textContent = 'Add New Individual';
            // Defaults already set above
        }
        toggleStudentFields(); // Call this after setting isStudentCheckbox.checked
        individualModal.classList.remove('hidden');
    }

    // Function to close the Add/Edit modal
    function closeIndividualModal() {
        individualModal.classList.add('hidden');
    }

    // Toggle student fields visibility
    function toggleStudentFields() {
        if (isStudentCheckbox.checked) {
            studentFieldsDiv.classList.remove('hidden');
        } else {
            studentFieldsDiv.classList.add('hidden');
            schoolAttendingInput.value = ''; // Clear if hidden
            isScholarCheckbox.checked = false; // Uncheck if hidden
        }
    }

    isStudentCheckbox.addEventListener('change', toggleStudentFields);
    cancelIndividualBtn.addEventListener('click', closeIndividualModal);
    addNewIndividualBtn.addEventListener('click', () => openIndividualModal()); // Added explicit event listener for new button

    // Handle form submission for Add/Edit
    individualForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        // Basic form validation (client-side)
        if (!surnameInput.value || !firstNameInput.value || !genderSelect.value || !birthDateInput.value || !civilStatusSelect.value) {
            showCustomModal('Please fill in all required fields (marked with *).', 'alert');
            return;
        }

        const formData = {
            individual_id: individualIdInput.value || null,
            surname: surnameInput.value,
            first_name: firstNameInput.value,
            middle_name: middleNameInput.value || null, // Allow null
            gender: genderSelect.value,
            birth_date: birthDateInput.value,
            civil_status_id: civilStatusSelect.value ? parseInt(civilStatusSelect.value) : null,
            blood_type_id: bloodTypeSelect.value ? parseInt(bloodTypeSelect.value) : null,
            religion_id: religionSelect.value ? parseInt(religionSelect.value) : null,
            contact_number: contactNumberInput.value || null, // Allow null
            email: emailInput.value || null, // Allow null
            salary_income: salaryIncomeInput.value !== '' ? parseFloat(salaryIncomeInput.value) : null, // Correctly handle empty string to null
            is_solo_parent: isSoloParentCheckbox.checked,
            has_disability: hasDisabilityCheckbox.checked,
            is_student: isStudentCheckbox.checked,
            school_attending: isStudentCheckbox.checked ? (schoolAttendingInput.value || null) : null, // Null if not student or empty
            is_scholar: isStudentCheckbox.checked ? isScholarCheckbox.checked : false, // False if not student
            educational_attainment_id: educationalAttainmentSelect.value ? parseInt(educationalAttainmentSelect.value) : null,
            is_alive: isAliveCheckbox.checked,
            is_registered_voter: isRegisteredVoterCheckbox.checked,
            is_ofw: isOfwCheckbox.checked,
            is_sss_member: isSssMemberCheckbox.checked,
            is_gsis_member: isGsisMemberCheckbox.checked,
            is_philhealth_member: isPhilhealthMemberCheckbox.checked,
            working_for: workingForInput.value || null, // Allow null
            occupation: occupationInput.value || null, // Allow null
            is_4ps_beneficiary: is4psBeneficiaryCheckbox.checked
        };

        console.log('Sending formData for save:', formData); // Log for debugging

        try {
            const response = await fetch('../api/individuals.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            // Read response as text first for better error debugging if JSON parsing fails
            const responseText = await response.text();
            console.log('API Raw Response (Save Individual):', responseText);

            let result;
            try {
                result = JSON.parse(responseText);
            } catch (jsonError) {
                console.error('JSON parsing error (Save Individual):', jsonError);
                throw new Error(`Invalid JSON response from server: ${responseText}`);
            }

            if (response.ok && result.status === 'success') {
                showCustomModal(`Individual ${formData.individual_id ? 'updated' : 'added'} successfully!`, 'alert', () => {
                    closeIndividualModal();
                    currentPage = 1; // Go back to first page after add/edit
                    currentSearchTerm = ''; // Clear search term after successful add/edit
                    individualSearch.value = ''; // Clear search input
                    fetchAndRenderIndividuals(); // Re-fetch and re-render the table
                });
            } else {
                throw new Error(result.message || `Failed to save individual. Server response: ${responseText}`);
            }
        } catch (error) {
            console.error('Error saving individual:', error);
            showCustomModal(`Error saving individual: ${error.message}`, 'alert');
        }
    });

    // --- View Individual Details Modal Logic ---

    // Function to open the View Details modal
    function openViewIndividualModal(individual) {
        individualDetailsContent.innerHTML = ''; // Clear previous content
        console.log('Populating View Modal with data:', individual);

        const formatBoolean = (value) => value ? 'Yes' : 'No';
        const formatGender = (gender) => {
            // Use hardcoded gender lookup for display
            const genderOption = lookupData.gender.find(g => String(g.id) === String(gender));
            return genderOption ? genderOption.name : 'N/A';
        };
        const formatCivilStatus = (id) => {
            const statusOption = lookupData.civilStatus.find(s => String(s.id) === String(id));
            return statusOption ? statusOption.status_name : 'N/A';
        };
        const formatBloodType = (id) => {
            const typeOption = lookupData.bloodType.find(b => String(b.id) === String(id));
            return typeOption ? typeOption.blood_type_name : 'N/A';
        };
        const formatReligion = (id) => {
            const religionOption = lookupData.religion.find(r => String(r.id) === String(id));
            return religionOption ? religionOption.religion_name : 'N/A';
        };
        const formatEducationalAttainment = (id) => {
            const attainmentOption = lookupData.educationalAttainment.find(e => String(e.id) === String(id));
            return attainmentOption ? attainmentOption.attainment_name : 'N/A';
        };

        const formatCurrency = (amount) => amount ? `₱${parseFloat(amount).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}` : 'N/A';
        const formatString = (value) => value || 'N/A';

        // Helper to create a detail group (label and value)
        const createDetailGroup = (label, value) => `
            <div class="details-group">
                <span class="details-label">${label}:</span>
                <span class="details-value">${value}</span>
            </div>
        `;

        // Basic Info
        individualDetailsContent.innerHTML += `<div class="details-section-heading">Basic Information</div>`;
        individualDetailsContent.innerHTML += createDetailGroup('Full Name', `${formatString(individual.first_name)} ${formatString(individual.middle_name)} ${formatString(individual.surname)}`);
        individualDetailsContent.innerHTML += createDetailGroup('Gender', formatGender(individual.gender));
        individualDetailsContent.innerHTML += createDetailGroup('Age', formatString(individual.age)); // Use individual.age directly
        individualDetailsContent.innerHTML += createDetailGroup('Birth Date', formatString(individual.birth_date));
        individualDetailsContent.innerHTML += createDetailGroup('Civil Status', formatCivilStatus(individual.civil_status_id)); // Use new formatter
        individualDetailsContent.innerHTML += createDetailGroup('Blood Type', formatBloodType(individual.blood_type_id)); // Use new formatter
        individualDetailsContent.innerHTML += createDetailGroup('Religion', formatReligion(individual.religion_id)); // Use new formatter
        individualDetailsContent.innerHTML += createDetailGroup('Contact No.', formatString(individual.contact_number));
        individualDetailsContent.innerHTML += createDetailGroup('Email', formatString(individual.email));
        individualDetailsContent.innerHTML += createDetailGroup('Household Address', formatString(individual.household_address)); // Use individual.household_address directly

        // Status
        individualDetailsContent.innerHTML += `<div class="details-section-heading">Status Information</div>`;
        individualDetailsContent.innerHTML += createDetailGroup('Salary Income', formatCurrency(individual.salary_income));
        individualDetailsContent.innerHTML += createDetailGroup('Solo Parent', formatBoolean(individual.is_solo_parent));
        individualDetailsContent.innerHTML += createDetailGroup('With Disability', formatBoolean(individual.has_disability));
        individualDetailsContent.innerHTML += createDetailGroup('Is Student', formatBoolean(individual.is_student));
        if (individual.is_student) {
            individualDetailsContent.innerHTML += createDetailGroup('School', formatString(individual.school_attending));
            individualDetailsContent.innerHTML += createDetailGroup('Is Scholar', formatBoolean(individual.is_scholar));
        }
        individualDetailsContent.innerHTML += createDetailGroup('Educ. Attainment', formatEducationalAttainment(individual.educational_attainment_id)); // Use new formatter
        individualDetailsContent.innerHTML += createDetailGroup('Is Alive', formatBoolean(individual.is_alive));

        // Additional Info
        individualDetailsContent.innerHTML += `<div class="details-section-heading">Additional Information</div>`;
        individualDetailsContent.innerHTML += createDetailGroup('Registered Voter', formatBoolean(individual.is_registered_voter));
        individualDetailsContent.innerHTML += createDetailGroup('OFW', formatBoolean(individual.is_ofw));
        individualDetailsContent.innerHTML += createDetailGroup('SSS Member', formatBoolean(individual.is_sss_member));
        individualDetailsContent.innerHTML += createDetailGroup('GSIS Member', formatBoolean(individual.is_gsis_member));
        individualDetailsContent.innerHTML += createDetailGroup('PhilHealth Member', formatBoolean(individual.is_philhealth_member));
        individualDetailsContent.innerHTML += createDetailGroup('Working For', formatString(individual.working_for));
        individualDetailsContent.innerHTML += createDetailGroup('Occupation', formatString(individual.occupation));
        individualDetailsContent.innerHTML += createDetailGroup('4Ps Beneficiary', formatBoolean(individual.is_4ps_beneficiary));

        viewIndividualModal.classList.remove('hidden');
    }

    // Function to close the View Details modal
    function closeViewIndividualModal() {
        viewIndividualModal.classList.add('hidden');
    }
    closeViewIndividualBtn.addEventListener('click', closeViewIndividualModal);


    // --- Data Fetching and Rendering ---

    async function fetchAndRenderIndividuals() {
        // Ensure lookup data is loaded before proceeding with individuals data
        // fetchLookupData is now synchronous and uses hardcoded data
        const lookupLoaded = await fetchLookupData(); 
        if (!lookupLoaded) {
            console.error("Lookup data failed to load, cannot fetch individuals.");
            return; // This line is mostly for consistency, as fetchLookupData will always return true now.
        }

        try {
            // Use currentFilters directly
            const filters = { ...currentFilters };

            // Log the filters object being sent
            console.log('DEBUG: Filters object being sent to API:', filters);

            // Include pagination, search, and filter parameters in the API call
            const queryParams = new URLSearchParams({
                page: currentPage,
                limit: itemsPerPage,
                search: currentSearchTerm,
                filters: JSON.stringify(filters) // Send filters as a JSON string
            }).toString();

            console.log('Fetching individuals with query:', queryParams);
            const response = await fetch(`../api/individuals.php?${queryParams}`);
            if (!response.ok) {
                // Read response text for better error message if not JSON
                const errorText = await response.text();
                throw new Error(`HTTP error! status: ${response.status}. Response: ${errorText}`);
            }
            const result = await response.json();
            console.log('API Response (Table Data):', result);

            if (result.status === 'success') {
                const individuals = result.data;
                const totalRecords = result.totalRecords; // Corrected from total_records
                totalPages = Math.ceil(totalRecords / itemsPerPage);

                renderIndividualsTable(individuals);
                updatePaginationControls();
            } else {
                showCustomModal(`Error fetching individuals: ${result.message}`, 'alert');
                individualsTableBody.innerHTML = '';
                noResultsMessage.classList.remove('hidden');
                updatePaginationControls(true); // Disable pagination on error
            }
        } catch (error) {
            console.error('Error fetching individuals for table:', error);
            showCustomModal(`Could not load individuals data. Please try again. Error: ${error.message}`, 'alert');
            individualsTableBody.innerHTML = '';
            noResultsMessage.classList.remove('hidden');
            updatePaginationControls(true); // Disable pagination on error
        }
    }

    function renderIndividualsTable(data) {
        individualsTableBody.innerHTML = '';
        if (data.length === 0) { // If no data, regardless of search term
            noResultsMessage.textContent = currentSearchTerm || Object.values(currentFilters).some(f => f !== 'all' && f !== '') ? `No individuals found matching your criteria.` : `No individuals to display.`;
            noResultsMessage.classList.remove('hidden');
            return;
        } else {
            noResultsMessage.classList.add('hidden');
        }

        data.forEach(individual => {
            const row = document.createElement('tr');
            // For display in the table, we might still want to show the lookup name, not just ID.
            // We can add simple helper functions or find the names from the hardcoded lookupData.
            const displayGender = lookupData.gender.find(g => String(g.id) === String(individual.gender))?.name || individual.gender;
            const displayCivilStatus = lookupData.civilStatus.find(s => String(s.id) === String(individual.civil_status_id))?.status_name || 'N/A';

            row.innerHTML = `
                <td data-label="Name" class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${individual.first_name} ${individual.middle_name ? individual.middle_name + ' ' : ''}${individual.surname}</td>
                <td data-label="Age" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${individual.age}</td>
                <td data-label="Gender" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${displayGender}</td>
                <td data-label="Civil Status" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${displayCivilStatus}</td>
                <td data-label="Household Address" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${individual.household_address}</td>
                <td data-label="Actions" class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <button class="view-btn bg-green-100 text-green-800 py-1 px-2 rounded-md hover:bg-green-200 transition-colors duration-200 mr-2" data-id="${individual.individual_id}">
                        <i class="fas fa-eye"></i> View
                    </button>
                    <button class="edit-btn bg-blue-200 text-blue-800 py-1 px-2 rounded-md hover:bg-blue-300 transition-colors duration-200 mr-2" data-id="${individual.individual_id}">
                        <i class="fas fa-edit"></i> Edit
                    </button>
                    <button class="delete-btn bg-red-200 text-red-800 py-1 px-2 rounded-md hover:bg-red-300 transition-colors duration-200" data-id="${individual.individual_id}" data-name="${individual.first_name} ${individual.surname}">
                        <i class="fas fa-trash-alt"></i> Delete
                    </button>
                </td>
            `;
            individualsTableBody.appendChild(row);
        });

        hideEditDeleteForUser();
    }

    // --- Pagination Logic ---
    function updatePaginationControls(disableAll = false) {
        paginationInfo.textContent = `Page ${currentPage} of ${totalPages}`;

        prevPageBtn.disabled = currentPage <= 1 || disableAll;
        nextPageBtn.disabled = currentPage >= totalPages || disableAll;

        if (disableAll) {
            prevPageBtn.classList.add('opacity-50', 'cursor-not-allowed');
            nextPageBtn.classList.add('opacity-50', 'cursor-not-allowed'); // Apply to both
        } else {
            prevPageBtn.classList.remove('opacity-50', 'cursor-not-allowed');
            nextPageBtn.classList.remove('opacity-50', 'cursor-not-allowed');
        }
    }

    prevPageBtn.addEventListener('click', () => {
        if (currentPage > 1) {
            currentPage--;
            fetchAndRenderIndividuals();
        }
    });

    nextPageBtn.addEventListener('click', () => {
        if (currentPage < totalPages) {
            currentPage++;
            fetchAndRenderIndividuals();
        }
    });


    // --- Initial Load ---
    // Start initial load process, which now awaits fetchLookupData
    fetchAndRenderIndividuals();


    // --- Event Listeners ---

    // Handle search input (now triggers server-side search and resets pagination)
    individualSearch.addEventListener('input', (event) => {
        currentSearchTerm = event.target.value.toLowerCase();
        currentPage = 1; // Reset to first page on new search
        fetchAndRenderIndividuals(); // Fetch new data based on search term
    });


    // Handle Edit/Delete/View buttons using event delegation
    individualsTableBody.addEventListener('click', async (event) => {
        if (event.target.classList.contains('edit-btn')) {
            const individualId = event.target.dataset.id;
            console.log(`Edit button clicked for Individual ID: ${individualId}`);
            try {
                // Fetch specific individual data with all lookup names for display
                const response = await fetch(`../api/individuals.php?id=${individualId}`);
                if (!response.ok) {
                    const errorText = await response.text();
                    throw new Error(`Failed to fetch individual details for editing. Status: ${response.status}. Response: ${errorText}`);
                }
                const result = await response.json();
                console.log('API Response (Single Individual for Edit):', result);

                if (result.status === 'success' && result.data) {
                    openIndividualModal(result.data); // Pass the single individual object
                } else {
                    showCustomModal(result.message || 'Individual not found for editing.', 'alert');
                }
            } catch (error) {
                console.error('Error fetching individual for edit:', error);
                showCustomModal(`Error loading individual for edit: ${error.message}`, 'alert');
            }
        } else if (event.target.classList.contains('delete-btn')) {
            const individualId = event.target.dataset.id;
            const individualName = event.target.dataset.name;

            showCustomModal(`Are you sure you want to delete ${individualName}?`, 'confirm', async (confirmed) => {
                if (confirmed) {
                    try {
                        const response = await fetch('../api/individuals.php', {
                            method: 'DELETE',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({ individual_id: individualId })
                        });

                        const responseText = await response.text();
                        console.log('API Raw Response (Delete Individual):', responseText);
                        let result;
                        try {
                            result = JSON.parse(responseText);
                        } catch (jsonError) {
                            console.error('JSON parsing error (Delete Individual):', jsonError);
                            throw new Error(`Invalid JSON response from server during delete: ${responseText}`);
                        }

                        if (response.ok && result.status === 'success') {
                            showCustomModal(`${individualName} deleted successfully!`, 'alert', () => {
                                currentPage = 1; // Go back to first page after add/edit
                                fetchAndRenderIndividuals();
                            });
                        } else {
                            throw new Error(result.message || 'Failed to delete individual.');
                        }
                    } catch (error) {
                        console.error('Error deleting individual:', error);
                        showCustomModal(`Error deleting ${individualName}: ${error.message}`, 'alert');
                    }
                }
            });
        } else if (event.target.classList.contains('view-btn')) { // View button handler
            const individualId = event.target.dataset.id;
            console.log(`View button clicked for Individual ID: ${individualId}`);
            try {
                // Fetch specific individual data with all lookup names for display
                const response = await fetch(`../api/individuals.php?id=${individualId}`);
                if (!response.ok) {
                    const errorText = await response.text();
                    throw new Error(`Failed to fetch individual details for viewing. Status: ${response.status}. Response: ${errorText}`);
                }
                const result = await response.json();
                console.log('API Response (Single Individual for View):', result);

                if (result.status === 'success' && result.data) {
                    openViewIndividualModal(result.data); // Open the view modal
                } else {
                    showCustomModal(result.message || 'Individual details not found.', 'alert');
                }
            } catch (error) {
                console.error('Error fetching individual for view:', error);
                showCustomModal(`Error loading individual details: ${error.message}`, 'alert');
            }
        }
    });

    // --- Filter Modal Logic ---
    console.log('openFilterModalBtn element:', openFilterModalBtn); // Diagnostic log for the filter button element
    if (openFilterModalBtn) {
        openFilterModalBtn.addEventListener('click', () => {
            console.log('Filters button clicked!'); // Diagnostic log inside the event listener
            // Set filter modal fields to currentFilters values before opening
            filterAgeGroup.value = currentFilters.age_group;
            filterGender.value = currentFilters.gender === 'all' ? 'all' : String(currentFilters.gender);
            filterReligion.value = currentFilters.religion_id === 'all' ? 'all' : String(currentFilters.religion_id);
            filterCivilStatus.value = currentFilters.civil_status_id === 'all' ? 'all' : String(currentFilters.civil_status_id);
            filterBloodType.value = currentFilters.blood_type_id === 'all' ? 'all' : String(currentFilters.blood_type_id);
            filterEducationalAttainment.value = currentFilters.educational_attainment_id === 'all' ? 'all' : String(currentFilters.educational_attainment_id);
            // Removed filterWorkingFor and filterOccupation

            // Boolean filters: Set checked state based on currentFilters
            filterIsAlive.checked = (currentFilters.is_alive === 'true');
            filterIsStudent.checked = (currentFilters.is_student === 'true');
            filterIs4ps.checked = (currentFilters.is_4ps_beneficiary === 'true');
            filterIsRegisteredVoter.checked = (currentFilters.is_registered_voter === 'true');
            filterIsOfw.checked = (currentFilters.is_ofw === 'true');
            filterIsSssMember.checked = (currentFilters.is_sss_member === 'true');
            filterIsGsisMember.checked = (currentFilters.is_gsis_member === 'true');
            filterIsPhilhealthMember.checked = (currentFilters.is_philhealth_member === 'true');

            filterItemsPerPage.value = String(itemsPerPage); // Set to current value

            filterModal.classList.remove('hidden');
        });
    } else {
        console.error("Filter button with ID 'openFilterModalBtn' not found.");
    }


    filterForm.addEventListener('submit', (event) => {
        event.preventDefault();
        console.log('Filter form submitted!'); // Diagnostic log
        // Update currentFilters with values from the form
        currentFilters.age_group = filterAgeGroup.value;
        currentFilters.gender = filterGender.value;
        
        // Boolean filters: Determine 'true' or 'false' based on checkbox checked state
        currentFilters.is_alive = filterIsAlive.checked ? 'true' : 'all';
        currentFilters.is_student = filterIsStudent.checked ? 'true' : 'all';
        currentFilters.is_4ps_beneficiary = filterIs4ps.checked ? 'true' : 'all';
        currentFilters.is_registered_voter = filterIsRegisteredVoter.checked ? 'true' : 'all';
        currentFilters.is_ofw = filterIsOfw.checked ? 'true' : 'all';
        currentFilters.is_sss_member = filterIsSssMember.checked ? 'true' : 'all';
        currentFilters.is_gsis_member = filterIsGsisMember.checked ? 'true' : 'all';
        currentFilters.is_philhealth_member = filterPhilhealthMember.checked ? 'true' : 'all';
        
        // Dropdown filters: Set to 'all' if not selected or set to "All"
        currentFilters.gender = filterGender.value === 'all' || filterGender.value === '' ? 'all' : filterGender.value;
        currentFilters.religion_id = filterReligion.value === 'all' || filterReligion.value === '' ? 'all' : parseInt(filterReligion.value);
        currentFilters.civil_status_id = filterCivilStatus.value === 'all' || filterCivilStatus.value === '' ? 'all' : parseInt(filterCivilStatus.value);
        currentFilters.blood_type_id = filterBloodType.value === 'all' || filterBloodType.value === '' ? 'all' : parseInt(filterBloodType.value);
        currentFilters.educational_attainment_id = filterEducationalAttainment.value === 'all' || filterEducationalAttainment.value === '' ? 'all' : parseInt(filterEducationalAttainment.value);
        
        // Update itemsPerPage from the filter form
        itemsPerPage = parseInt(filterItemsPerPage.value, 10);

        console.log('Applying filters:', currentFilters); // Diagnostic log

        filterModal.classList.add('hidden'); // Close modal
        currentPage = 1; // Reset to first page when filters are applied
        fetchAndRenderIndividuals(); // Re-fetch data with new filters
    });

    clearFiltersBtn.addEventListener('click', () => {
        console.log('Clear Filters button clicked!'); // Diagnostic log
        // Reset all filter fields to 'all' or empty string
        filterAgeGroup.value = 'all';
        filterGender.value = 'all';
        
        // Boolean filters: Uncheck them
        filterIsAlive.checked = false;
        filterIsStudent.checked = false;
        filterIs4ps.checked = false;
        filterIsRegisteredVoter.checked = false;
        filterIsOfw.checked = false;
        filterIsSssMember.checked = false;
        filterIsGsisMember.checked = false;
        filterIsPhilhealthMember.checked = false;

        filterReligion.value = 'all';
        filterCivilStatus.value = 'all';
        filterBloodType.value = 'all';
        filterEducationalAttainment.value = 'all';
        // Removed filterWorkingFor and filterOccupation

        // Also reset the currentFilters object
        currentFilters = {
            age_group: 'all',
            gender: 'all',
            is_alive: 'all', // Reset to 'all' in the internal state
            is_student: 'all',
            is_4ps_beneficiary: 'all',
            is_registered_voter: 'all',
            is_ofw: 'all',
            is_sss_member: 'all',
            is_gsis_member: 'all',
            is_philhealth_member: 'all',
            religion_id: 'all',
            civil_status_id: 'all',
            blood_type_id: 'all',
            educational_attainment_id: 'all'
            // Removed working_for and occupation
        };

        // Reset itemsPerPage to default
        filterItemsPerPage.value = "10";
        itemsPerPage = 10;

        filterModal.classList.add('hidden'); // Close modal
        currentPage = 1; // Reset to first page
        fetchAndRenderIndividuals(); // Re-fetch data without filters
    });

    // Close filter modal when clicking outside
    filterModal.addEventListener('click', (event) => {
        if (event.target === filterModal) {
            filterModal.classList.add('hidden');
        }
    });


    // --- Mobile Menu Toggle ---
    const mobileMenuButton = document.getElementById('mobileMenuButton');
    const mainSidebar = document.getElementById('mainSidebar');
    const mobileMenuOverlay = document.getElementById('mobileMenuOverlay');

    if (mobileMenuButton && mainSidebar && mobileMenuOverlay) {
        mobileMenuButton.addEventListener('click', () => {
            mainSidebar.classList.toggle('open');
            mobileMenuOverlay.classList.toggle('open');
            document.body.classList.toggle('overflow-hidden-mobile');
        });

        mobileMenuOverlay.addEventListener('click', () => {
            mainSidebar.classList.remove('open');
            mobileMenuOverlay.classList.remove('open');
            document.body.classList.remove('overflow-hidden-mobile');
        });

        // Optional: Close sidebar if a navigation link is clicked (good UX)
        const navLinks = mainSidebar.querySelectorAll('nav a');
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                if (window.innerWidth < 1024) {
                    mainSidebar.classList.remove('open');
                    mobileMenuOverlay.classList.remove('open');
                    document.body.classList.remove('overflow-hidden-mobile');
                }
            });
        });
    }


    // Place this function at the top level, outside of any other function
    function hideEditDeleteForUser() {
        if (typeof userRole !== 'undefined' && userRole === 'user') {
            document.querySelectorAll('.edit-btn, .delete-btn, .edit-family-btn, .delete-family-btn').forEach(function(btn) {
                btn.style.display = 'none';
            });
        }
    }
});

document.getElementById('openFilterModalBtn').addEventListener('click', () => {
    // Set filter modal fields to currentFilters values before opening
    filterAgeGroup.value = currentFilters.age_group;
    filterGender.value = currentFilters.gender === 'all' ? 'all' : String(currentFilters.gender);
    filterReligion.value = currentFilters.religion_id === 'all' ? 'all' : String(currentFilters.religion_id);
    filterCivilStatus.value = currentFilters.civil_status_id === 'all' ? 'all' : String(currentFilters.civil_status_id);
    filterBloodType.value = currentFilters.blood_type_id === 'all' ? 'all' : String(currentFilters.blood_type_id);
    filterEducationalAttainment.value = currentFilters.educational_attainment_id === 'all' ? 'all' : String(currentFilters.educational_attainment_id);

    // Boolean filters: Set checked state based on currentFilters
    filterIsAlive.checked = (currentFilters.is_alive === 'true');
    filterIsStudent.checked = (currentFilters.is_student === 'true');
    filterIs4ps.checked = (currentFilters.is_4ps_beneficiary === 'true');
    filterIsRegisteredVoter.checked = (currentFilters.is_registered_voter === 'true');
    filterIsOfw.checked = (currentFilters.is_ofw === 'true');
    filterIsSssMember.checked = (currentFilters.is_sss_member === 'true');
    filterIsGsisMember.checked = (currentFilters.is_gsis_member === 'true');
    filterIsPhilhealthMember.checked = (currentFilters.is_philhealth_member === 'true');

    filterItemsPerPage.value = String(itemsPerPage); // Set to current value

    filterModal.classList.remove('hidden');
});