document.addEventListener('DOMContentLoaded', () => {
    console.log('Dashboard loaded!');

    // --- DOM Elements for Summary Data ---
    const totalResidentsElem = document.getElementById('totalResidents');
    const totalHouseholdsElem = document.getElementById('totalHouseholds');
    const zonesCoveredElem = document.getElementById('zonesCovered');
    const totalSoloParentsElem = document.getElementById('totalSoloParents');
    const families4PsElem = document.getElementById('families4Ps');
    const individualsWithDisabilityElem = document.getElementById('individualsWithDisability');
    // New summary elements
    const householdsWithWaterElem = document.getElementById('householdsWithWater');
    const householdsWithElectricityElem = document.getElementById('householdsWithElectricity');
    const householdsWithInternetElem = document.getElementById('householdsWithInternet');
    // NEW: Scholar and Registered Voter elements
    const totalScholarsElem = document.getElementById('totalScholars');
    const totalRegisteredVotersElem = document.getElementById('totalRegisteredVoters');


    const zoneSelect = document.getElementById('zoneSelect'); // Get zone select element

    // --- Mobile Menu Elements ---
    const mobileMenuButton = document.getElementById('mobileMenuButton');
    const mainSidebar = document.getElementById('mainSidebar');
    const mobileMenuOverlay = document.getElementById('mobileMenuOverlay');

    // --- Mobile Menu Toggle Logic ---
    if (mobileMenuButton && mainSidebar && mobileMenuOverlay) {
        mobileMenuButton.addEventListener('click', () => {
            mainSidebar.classList.toggle('open');
            mobileMenuOverlay.classList.toggle('open');
            document.body.classList.toggle('overflow-hidden-mobile'); // Prevent scroll on body when menu is open
        });

        mobileMenuOverlay.addEventListener('click', () => {
            mainSidebar.classList.remove('open');
            mobileMenuOverlay.classList.remove('open');
            document.body.classList.remove('overflow-hidden-mobile');
        });

        // Close sidebar if a navigation link is clicked (optional, but good for UX)
        const navLinks = mainSidebar.querySelectorAll('nav a');
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                // Check if the screen is small enough to warrant closing the menu
                // Tailwind's 'lg' breakpoint is 1024px. Adjust if your media query is different.
                if (window.innerWidth < 1024) { 
                    mainSidebar.classList.remove('open');
                    mobileMenuOverlay.classList.remove('open');
                    document.body.classList.remove('overflow-hidden-mobile');
                }
            });
        });
    }


    /**
     * Renders a bar chart.
     * @param {string} containerId The ID of the HTML element to render the chart into.
     * @param {Array<Object>} data An array of objects with { label: string, value: number, color: string } for each bar.
     */
    function renderBarChart(containerId, data) {
        const container = document.getElementById(containerId);
        if (!container) {
            console.error(`Container with ID '${containerId}' not found for bar chart.`);
            return;
        }
        container.innerHTML = ''; // Clear previous chart

        if (data.length === 0) {
            container.innerHTML = '<p class="text-gray-500 text-center py-4">No data available for this chart.</p>';
            // Also clear labels if no data
            if (containerId === 'educationalAttainmentChart') {
                const labelsContainer = document.getElementById('educationalAttainmentLabels');
                if (labelsContainer) labelsContainer.innerHTML = '';
            }
            return;
        }

        // For bar charts like Age Groups and Educational Attainment, we want to scale bars relative to the max value
        const values = data.map(item => item.value);
        const maxValue = values.length > 0 ? Math.max(...values) : 0;
        const maxBarHeightPx = 100; // Max height for a bar in pixels within the container

        data.forEach(item => {
            const bar = document.createElement('div');
            bar.className = 'bar';
            // Calculate bar height relative to max value, ensuring at least 0 height
            const barHeight = maxValue > 0 ? (item.value / maxValue) * maxBarHeightPx : 0;
            bar.style.height = `${barHeight}px`;
            bar.style.backgroundColor = item.color;
            bar.title = `${item.label}: ${item.value.toLocaleString()}`; // Tooltip with formatted value

            const valueLabel = document.createElement('div');
            valueLabel.className = 'bar-value'; 
            valueLabel.textContent = item.value.toLocaleString(); // Format value
            bar.appendChild(valueLabel);

            container.appendChild(bar);
        });

        // Dynamically render labels for Educational Attainment chart
        if (containerId === 'educationalAttainmentChart') {
            const labelsContainer = document.getElementById('educationalAttainmentLabels');
            if (labelsContainer) {
                labelsContainer.innerHTML = ''; // Clear existing labels
                
                data.forEach(item => {
                    const span = document.createElement('span');
                    // Use flex-1 and min-w to allow labels to distribute space and wrap if needed
                    span.className = 'text-center flex-1 min-w-[50px]'; 
                    
                    // Shorten labels if necessary to prevent overlap
                    let displayLabel = item.label;
                    if (item.label === 'Elementary Level') displayLabel = 'Elem. Level';
                    else if (item.label === 'Elementary Graduate') displayLabel = 'Elem. Grad.';
                    else if (item.label === 'High School Level') displayLabel = 'H.S. Level';
                    else if (item.label === 'High School Graduate') displayLabel = 'H.S. Grad.';
                    else if (item.label === 'Junior High School') displayLabel = 'Jr. High';
                    else if (item.label === 'Junior High School Graduate') displayLabel = 'Jr. High Grad.';
                    else if (item.label === 'Senior High School') displayLabel = 'Sr. High';
                    else if (item.label === 'Senior High School Graduate') displayLabel = 'Sr. High Grad.';
                    else if (item.label === 'College Level') displayLabel = 'Coll. Level';
                    else if (item.label === 'College Graduate') displayLabel = 'Coll. Grad.';
                    else if (item.label === 'Post-Graduate') displayLabel = 'Post-Grad.';
                    else if (item.label === 'Vocational') displayLabel = 'Vocational'; 
                    
                    span.textContent = displayLabel;
                    labelsContainer.appendChild(span);
                });
            }
        }
    }

    /**
     * Renders a pie chart (conic-gradient based).
     * @param {string} containerId The ID of the HTML element for the pie chart.
     * @param {Object|Array<Object>} data For general pie charts: An array of objects { label: string, value: number, color: string }.
     * For gender split: An object { male: number, female: number, maleColor: string, femaleColor: string }.
     */
    function renderPieChart(containerId, data) {
        console.log(`[renderPieChart] Rendering ${containerId} with data:`, data); // DEBUG LOG
        const container = document.getElementById(containerId);
        if (!container) {
            console.error(`Container with ID '${containerId}' not found for pie chart.`);
            return;
        }
        
        // Clear previous content and ensure base structure is present
        container.innerHTML = ''; 
        const pieChartDiv = document.createElement('div');
        pieChartDiv.className = 'pie-chart'; // Apply base pie-chart styles
        const totalNumberDiv = document.createElement('div');
        totalNumberDiv.className = 'pie-chart-total-number'; // Apply total number styles
        pieChartDiv.appendChild(totalNumberDiv);
        container.appendChild(pieChartDiv);

        const legendContainer = document.createElement('div');
        legendContainer.className = 'pie-legend';
        container.appendChild(legendContainer);


        let chartData = [];
        let total = 0;
        let legendHTML = '';

        if (Array.isArray(data)) {
            // General pie chart (e.g., Civil Status)
            if (data.length === 0 || data.every(item => item.value === 0)) {
                pieChartDiv.style.background = '#e0e0e0'; // Grey if no data
                totalNumberDiv.textContent = '0';
                legendHTML = `<div class="pie-legend-item">No Data</div>`;
                legendContainer.innerHTML = legendHTML;
                return;
            }
            chartData = data;
            total = data.reduce((sum, item) => sum + item.value, 0);
            
            legendHTML = ''; // Reset for this type
            data.forEach(item => {
                const percentage = total > 0 ? ((item.value / total) * 100).toFixed(1) : 0;
                legendHTML += `
                    <div class="pie-legend-item">
                        <span class="pie-legend-color" style="background-color: ${item.color};"></span> ${item.label}: ${item.value.toLocaleString()} (${percentage}%)
                    </div>
                `;
            });

        } else if (data.male !== undefined && data.female !== undefined) {
            // Special case for Gender Split
            if (data.male === 0 && data.female === 0) {
                pieChartDiv.style.background = '#e0e0e0'; // Grey if no data
                totalNumberDiv.textContent = '0';
                legendHTML = `<div class="pie-legend-item">No Data</div>`;
                legendContainer.innerHTML = legendHTML;
                return;
            }
            total = data.male + data.female;
            chartData.push({ label: 'Male', value: data.male, color: data.maleColor });
            chartData.push({ label: 'Female', value: data.female, color: data.femaleColor });

            legendHTML = ''; // Reset for this type
            const malePercentage = total > 0 ? ((data.male / total) * 100).toFixed(1) : 0;
            const femalePercentage = total > 0 ? ((data.female / total) * 100).toFixed(1) : 0;
            legendHTML += `
                <div class="pie-legend-item"><span class="pie-legend-color" style="background-color: ${data.maleColor};"></span> Male: ${data.male.toLocaleString()} (${malePercentage}%)</div>
                <div class="pie-legend-item"><span class="pie-legend-color" style="background-color: ${data.femaleColor};"></span> Female: ${data.female.toLocaleString()} (${femalePercentage}%)</div>
            `;
        } else {
            console.error('Invalid data format for pie chart:', data);
            pieChartDiv.style.background = '#e0e0e0';
            totalNumberDiv.textContent = 'N/A';
            legendHTML = '<div class="pie-legend-item">Error: Invalid chart data.</div>';
            legendContainer.innerHTML = legendHTML;
            return;
        }

        let conicGradient = '';
        let currentDegree = 0; // Tracks the starting point for each slice in degrees

        chartData.forEach((item, index) => {
            if (item.value > 0) { // Only add slice if value is greater than 0
                const percent = (item.value / total) * 100;
                const sliceDegree = percent * 3.6; // Convert percentage to degrees (360 / 100 = 3.6)
                
                if (index === 0) {
                    conicGradient += `${item.color} ${currentDegree}deg ${currentDegree + sliceDegree}deg`;
                } else {
                    conicGradient += `, ${item.color} ${currentDegree}deg ${currentDegree + sliceDegree}deg`;
                }
                currentDegree += sliceDegree; // Update for the next slice
            }
        });
        conicGradient = `conic-gradient(${conicGradient})`;
        
        console.log(`[${containerId}] Final Conic Gradient:`, conicGradient); // DEBUG LOG
        pieChartDiv.style.background = conicGradient;
        totalNumberDiv.textContent = total.toLocaleString();

        legendContainer.innerHTML = legendHTML;
    }

    /**
     * Fetches the list of zones from the backend and populates the dropdown.
     */
    async function populateZoneDropdown() {
        if (!zoneSelect) return; // Exit if dropdown not found

        try {
            const response = await fetch('../api/zone.php?action=getAllZoneNames'); 
            if (!response.ok) {
                throw new Error(`Failed to fetch zone list. Status: ${response.status}`);
            }
            const result = await response.json();

            if (result.status === 'success' && result.data && Array.isArray(result.data)) {
                zoneSelect.innerHTML = '<option value="All Zones">All Zones</option>';
                result.data.forEach(zone => {
                    const option = document.createElement('option');
                    option.value = zone.zone_name; // Use zone_name as value
                    option.textContent = zone.zone_name;
                    zoneSelect.appendChild(option);
                });
            } else {
                console.error('API returned an error or no data for zones:', result.message);
            }
        } catch (error) {
            console.error('Error fetching zone list:', error);
            if (zoneSelect.options.length === 0 || zoneSelect.options[0].value !== "All Zones") {
                zoneSelect.innerHTML = '<option value="All Zones">All Zones</option>';
            }
        }
    }


    // --- Fetch Dashboard Data and Render ---
    async function fetchDashboardData(zoneName = 'All Zones') {
        try {
            const apiUrl = `../api/overview.php?zone=${encodeURIComponent(zoneName)}`;
            console.log('Fetching dashboard data from:', apiUrl);
            const response = await fetch(apiUrl); 
            
            console.log('API Response status:', response.status);
            if (!response.ok) {
                const errorText = await response.text();
                console.error('API Response not OK:', errorText);
                throw new Error(`Failed to fetch dashboard data. Status: ${response.status}. Response: ${errorText}`);
            }
            const result = await response.json();
            console.log('Parsed API Response:', result);

            if (result.status === 'success' && result.data) {
                const dashboardData = result.data;
                console.log('Dashboard Summary Data received:', dashboardData.summary);
                console.log('Dashboard Charts Data received:', dashboardData.charts);

                // Render Summary
                if (dashboardData.summary) {
                    totalResidentsElem.textContent = dashboardData.summary.totalResidents.toLocaleString();
                    totalHouseholdsElem.textContent = dashboardData.summary.totalHouseholds.toLocaleString();
                    zonesCoveredElem.textContent = dashboardData.summary.zonesCovered.toLocaleString();
                    totalSoloParentsElem.textContent = dashboardData.summary.totalSoloParents.toLocaleString();
                    families4PsElem.textContent = dashboardData.summary.families4Ps.toLocaleString();
                    individualsWithDisabilityElem.textContent = dashboardData.summary.individualsWithDisability.toLocaleString();
                    
                    // New summary statistics for households
                    const totalHouseholds = dashboardData.summary.totalHouseholds;
                    householdsWithWaterElem.textContent = `${dashboardData.summary.householdsWithWater.toLocaleString()}/${totalHouseholds.toLocaleString()}`;
                    householdsWithElectricityElem.textContent = `${dashboardData.summary.householdsWithElectricity.toLocaleString()}/${totalHouseholds.toLocaleString()}`;
                    householdsWithInternetElem.textContent = `${dashboardData.summary.householdsWithInternet.toLocaleString()}/${totalHouseholds.toLocaleString()}`;

                    // NEW: Display Scholar and Registered Voter counts
                    totalScholarsElem.textContent = dashboardData.summary.totalScholars.toLocaleString();
                    totalRegisteredVotersElem.textContent = dashboardData.summary.totalRegisteredVoters.toLocaleString();
                }

                // Render Charts
                if (dashboardData.charts) {
                    renderBarChart('ageGroupsChart', dashboardData.charts.ageGroups);
                    renderPieChart('genderSplitChart', dashboardData.charts.genderSplit);
                    renderPieChart('civilStatusChart', dashboardData.charts.civilStatus);
                    renderBarChart('educationalAttainmentChart', dashboardData.charts.educationalAttainment);
                    renderBarChart('waterSourceChart', dashboardData.charts.waterSource);
                }

            } else {
                console.error('API returned an error or no data:', result.message);
                // Set summary values to 0 if data is missing or error
                totalResidentsElem.textContent = '0';
                totalHouseholdsElem.textContent = '0';
                zonesCoveredElem.textContent = '0';
                totalSoloParentsElem.textContent = '0';
                families4PsElem.textContent = '0';
                individualsWithDisabilityElem.textContent = '0';
                // Reset new summary stats as well
                householdsWithWaterElem.textContent = '0/0';
                householdsWithElectricityElem.textContent = '0/0';
                householdsWithInternetElem.textContent = '0/0';
                // NEW: Reset Scholar and Registered Voter counts
                totalScholarsElem.textContent = '0';
                totalRegisteredVotersElem.textContent = '0';


                // Clear charts if data is missing or error
                renderBarChart('ageGroupsChart', []);
                renderPieChart('genderSplitChart', { male: 0, female: 0, maleColor: '#2563EB', femaleColor: '#F97316' });
                renderPieChart('civilStatusChart', []);
                renderBarChart('educationalAttainmentChart', []);
                renderBarChart('waterSourceChart', []);
            }
        }
         catch (error) {
            console.error('Error fetching dashboard data:', error);
            // Set summary values to 0 if error occurs
            totalResidentsElem.textContent = '0';
            totalHouseholdsElem.textContent = '0';
            zonesCoveredElem.textContent = '0';
            totalSoloParentsElem.textContent = '0';
            families4PsElem.textContent = '0';
            individualsWithDisabilityElem.textContent = '0';
            // Reset new summary stats as well
            householdsWithWaterElem.textContent = '0/0';
            householdsWithElectricityElem.textContent = '0/0';
            householdsWithInternetElem.textContent = '0/0';
            // NEW: Reset Scholar and Registered Voter counts
            totalScholarsElem.textContent = '0';
            totalRegisteredVotersElem.textContent = '0';


            // Clear charts if error occurs
            renderBarChart('ageGroupsChart', []);
            renderPieChart('genderSplitChart', { male: 0, female: 0, maleColor: '#2563EB', femaleColor: '#F97316' });
            renderPieChart('civilStatusChart', []);
            renderBarChart('educationalAttainmentChart', []);
            renderBarChart('waterSourceChart', []);
        }
    }

    // Event listener for zone selection change
    if (zoneSelect) {
        zoneSelect.addEventListener('change', (event) => {
            const selectedZone = event.target.value;
            fetchDashboardData(selectedZone); // Fetch data for the selected zone
        });
    }

    // Initial actions when the page loads
    populateZoneDropdown(); // Populate dropdown first
    // Then, fetch data for the initially selected zone (which will be "All Zones" by default)
    fetchDashboardData(zoneSelect ? zoneSelect.value : 'All Zones'); 

    // Example of a simple interactive element if you were to expand
    const searchInput = document.querySelector('input[type="text"]');
    if (searchInput) {
        searchInput.addEventListener('input', (event) => {
            // In a real app, you'd trigger a search here
        });
    }
});





function hideEditDeleteForUser() {
    if (typeof userRole !== 'undefined' && userRole === 'user') {
        document.querySelectorAll('.edit-btn, .delete-btn, .edit-family-btn, .delete-family-btn').forEach(function(btn) {
            btn.style.display = 'none';
        });
    }
}