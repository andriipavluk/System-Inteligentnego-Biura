const apiBase = 'http://localhost:5047/api';
let tempData = [];
let humidityData = [];
async function fetchSensors() {
    try {
        const response = await fetch(`${apiBase}/sensors`);
        if (!response.ok) throw new Error('Failed to fetch sensors');
        const sensors = await response.json();
        await displaySensors(sensors);
        createCharts();
    } catch (error) {
        console.error('Error fetching sensors:', error);
        document.getElementById('sensors').innerHTML = '<p>Error loading sensors.</p>';
    }
}
async function fetchSensorData(sensorId) {
    try {
        const response = await fetch(`${apiBase}/sensor-data/${sensorId}`);
        if (!response.ok) throw new Error('Failed to fetch sensor data');
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error fetching sensor data:', error);
        return [];
    }
}
async function displaySensors(sensors) {
    const container = document.getElementById('sensors');
    container.innerHTML = '';
    container.className = 'dashboard';
    tempData = [];
    humidityData = [];
    for (const sensor of sensors) {
        const sensorDiv = document.createElement('div');
        sensorDiv.className = 'sensor-card';
        sensorDiv.innerHTML = `<div class="sensor-title">${sensor.name}</div>`;
        container.appendChild(sensorDiv);
        const data = await fetchSensorData(sensor.id);
        if (data.length > 0) {
            const latest = data[0]; // Latest first
            sensorDiv.innerHTML += `<div class="sensor-value">${latest.value}</div><span class="status status-ok">OK</span>`;
            // Collect data for charts
            if (sensor.type.toLowerCase().includes('temperature')) {
                tempData.push(...data.map(d => ({ time: new Date(d.createdAt), value: d.value })));
            } else if (sensor.type.toLowerCase().includes('humidity')) {
                humidityData.push(...data.map(d => ({ time: new Date(d.createdAt), value: d.value })));
            }
        } else {
            sensorDiv.innerHTML += '<div class="sensor-value">N/A</div><span class="status status-alarm">NO DATA</span>';
        }
    }
}
function createCharts() {
    // Temperature Chart
    const tempCtx = document.getElementById('tempChart').getContext('2d');
    new Chart(tempCtx, {
        type: 'line',
        data: {
            labels: tempData.map(d => d.time.toLocaleTimeString()),
            datasets: [{
                label: 'Temperature (°C)',
                data: tempData.map(d => d.value),
                borderColor: 'rgba(255, 99, 132, 1)',
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
            }]
        },
        options: {
            responsive: true,
            scales: {
                x: { display: true, title: { display: true, text: 'Time' } },
                y: { display: true, title: { display: true, text: 'Value' } }
            }
        }
    });
    // Humidity Chart
    const humidityCtx = document.getElementById('humidityChart').getContext('2d');
    new Chart(humidityCtx, {
        type: 'line',
        data: {
            labels: humidityData.map(d => d.time.toLocaleTimeString()),
            datasets: [{
                label: 'Humidity (%)',
                data: humidityData.map(d => d.value),
                borderColor: 'rgba(54, 162, 235, 1)',
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
            }]
        },
        options: {
            responsive: true,
            scales: {
                x: { display: true, title: { display: true, text: 'Time' } },
                y: { display: true, title: { display: true, text: 'Value' } }
            }
        }
    });
}
// Load sensors on page load
window.onload = fetchSensors;
