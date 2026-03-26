const apiBase = 'http://localhost:5047/api';
let tempData = [];
let humidityData = [];
let charts = {};

const thresholds = {
    temperature: { max: 30 },
    humidity: { max: 70 },
    co2: { max: 1000 },
    smoke: { alarm: true }, // any detection
    light: {}, // no threshold
    motion: {} // no threshold
};

function getUnit(type) {
    const units = {
        temperature: '°C',
        humidity: '%',
        light: 'lux',
        co2: 'ppm',
        smoke: '',
        motion: ''
    };
    return units[type.toLowerCase()] || '';
}

function checkAlarm(type, value) {
    const threshold = thresholds[type.toLowerCase()];
    if (!threshold) return false;
    if (threshold.max && value > threshold.max) return true;
    if (threshold.alarm && value > 0) return true; // for smoke
    return false;
}

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
            const unit = getUnit(latest.type);
            const alarm = checkAlarm(latest.type, latest.value);
            sensorDiv.innerHTML += `<div class="sensor-value">${latest.value}${unit}</div><span class="status ${alarm ? 'status-alarm' : 'status-ok'}">${alarm ? 'ALARM' : 'OK'}</span>`;
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
    // Destroy existing charts
    if (charts.tempChart) charts.tempChart.destroy();
    if (charts.humidityChart) charts.humidityChart.destroy();

    // Temperature Chart
    const tempCtx = document.getElementById('tempChart').getContext('2d');
    charts.tempChart = new Chart(tempCtx, {
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
    charts.humidityChart = new Chart(humidityCtx, {
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

async function addSensor(event) {
    event.preventDefault();
    const name = document.getElementById('sensorName').value;
    const type = document.getElementById('sensorType').value;
    const roomId = parseInt(document.getElementById('roomId').value);
    
    try {
        const response = await fetch(`${apiBase}/sensors`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name, type, roomId })
        });
        if (!response.ok) throw new Error('Failed to add sensor');
        alert('Sensor added successfully!');
        document.getElementById('addSensorForm').reset();
        fetchSensors(); // Refresh
    } catch (error) {
        console.error('Error adding sensor:', error);
        alert('Error adding sensor: ' + error.message);
    }
}

async function sendReading(event) {
    event.preventDefault();
    const sensorId = parseInt(document.getElementById('readingSensorId').value);
    const type = document.getElementById('readingType').value;
    const value = parseFloat(document.getElementById('readingValue').value);
    
    try {
        const response = await fetch(`${apiBase}/sensor-data`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ sensorId, type, value })
        });
        if (!response.ok) throw new Error('Failed to send reading');
        alert('Reading sent successfully!');
        document.getElementById('sendReadingForm').reset();
        fetchSensors(); // Refresh
    } catch (error) {
        console.error('Error sending reading:', error);
        alert('Error sending reading: ' + error.message);
    }
}

// Event listeners
document.getElementById('addSensorForm').addEventListener('submit', addSensor);
document.getElementById('sendReadingForm').addEventListener('submit', sendReading);

// Load sensors on page load
window.onload = () => {
    fetchSensors();
    setInterval(fetchSensors, 30000); // Auto-refresh every 30 seconds
};
