# 🚀 Smart Home Dashboard - Quick Start Guide

## ✅ Project Status
All files are ready! The frontend is fully connected to the backend API.

---

## 📋 What's been completed

### Backend (C# .NET 10)
- ✅ API endpoints for sensors and sensor data
- ✅ CORS enabled for frontend requests
- ✅ SQLite database configured

### Frontend (HTML/CSS/JavaScript)
- ✅ **app.js** - Complete JavaScript implementation with:
  - Sensor dashboard with real-time data
  - Interactive charts (Chart.js) for each sensor
  - Add sensor form
  - Send reading form
  - Auto-refresh every 30 seconds
  - Polish language support
  - Alarm status indicators

- ✅ **index.html** - Complete with:
  - Responsive sensor card layout
  - Chart containers
  - Forms for adding sensors and readings
  - Chart.js script tag

- ✅ **style.css** - Professional styling (unchanged)

---

## 🏃 How to Run the Project

### Step 1: Start the Backend API

Open a terminal in the SmartHomeAPI folder and run:

```bash
cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI
dotnet run
```

Expected output:
```
info: Microsoft.Hosting.Lifetime[14]
      Now listening on: http://127.0.0.1:5047
info: Microsoft.Hosting.Lifetime[0]
      Application started. Press Ctrl+C to shut down.
```

**Leave this terminal running!**

---

### Step 2: Open the Frontend

Open your browser and navigate to:

```
file:///home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI/frontend/index.html
```

Or use Python's simple HTTP server:

```bash
cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI/frontend
python3 -m http.server 8000
```

Then open: `http://localhost:8000/index.html`

---

## 🧪 Testing with Sample Data

### Method 1: Using curl (in a new terminal)

**Add a Temperature Sensor:**
```bash
curl -X POST http://localhost:5047/api/sensors \
  -H "Content-Type: application/json" \
  -d '{"name":"Living Room Temp","type":"Temperature","roomId":1}'
```

**Add a Humidity Sensor:**
```bash
curl -X POST http://localhost:5047/api/sensors \
  -H "Content-Type: application/json" \
  -d '{"name":"Living Room Humidity","type":"Humidity","roomId":1}'
```

**Send Temperature Reading:**
```bash
curl -X POST http://localhost:5047/api/sensor-data \
  -H "Content-Type: application/json" \
  -d '{"sensorId":1,"type":"Temperature","value":22.5}'
```

**Send Humidity Reading:**
```bash
curl -X POST http://localhost:5047/api/sensor-data \
  -H "Content-Type: application/json" \
  -d '{"sensorId":2,"type":"Humidity","value":45}'
```

### Method 2: Using the Frontend Forms

1. Scroll down to **"Dodaj nowy czujnik"** section
2. Fill in:
   - **Nazwa czujnika:** Any name (e.g., "Kitchen Temperature")
   - **Typ czujnika:** Select from dropdown
   - **ID pokoju:** Any number (e.g., 1)
3. Click **"Dodaj czujnik"**

Then use **"Wyślij odczyt czujnika"** section to send readings:
   - **ID sensora:** The sensor ID you just created
   - **Typ:** Match the sensor type
   - **Wartość:** Any number (e.g., 25.5 for temperature)
4. Click **"Wyślij do czytania"**

---

## 📊 Features

### Dashboard
- **Real-time Sensor Cards** - Shows latest reading for each sensor
- **Status Indicators** - "OK" or "ALARM" based on thresholds
- **Chart Buttons** - Click to display interactive chart for any sensor

### Alarms (Auto-triggered)
- **Temperature** > 30°C = ALARM
- **Humidity** > 70% = ALARM
- **CO₂** > 1000 ppm = ALARM
- **Smoke/Motion** > 0 = ALARM

### Auto-refresh
- Dashboard updates automatically every 30 seconds
- No need to refresh the page manually

### Interactive Charts
- Click any sensor card's "Pokaż wykres" button
- Displays last readings with timestamps
- Line chart with zoom/pan capabilities

---

## 🐛 Troubleshooting

### "Błąd połączenia" (Connection Error)
- ✅ Check backend is running: `dotnet run`
- ✅ Check if you're opening HTML from `file://` or `http://localhost:8000`
- ✅ Check firewall isn't blocking port 5047
- ✅ Verify CORS is enabled in Program.cs (already done ✅)

### "Brak czujników" (No Sensors)
- ✅ Add a sensor using curl command or the form
- ✅ The dashboard shows "Brak czujników..." until you add one

### Charts not displaying
- ✅ Make sure you've sent at least one reading for the sensor
- ✅ Click the "Pokaż wykres" button on a sensor card

### Database issues
- ✅ Delete `smarthome.db` and run `dotnet run` to recreate
- ✅ Or use SQL script: `database/smarthome.sql`

---

## 📁 Project Structure

```
System-Inteligentnego-Biura/
├── SmartHomeAPI/
│   ├── Program.cs                 ← Backend with CORS ✅
│   ├── Data/AppDbContext.cs       ← Database context
│   ├── Models/
│   │   ├── Sensor.cs
│   │   └── SensorData.cs
│   └── frontend/
│       ├── index.html             ← Dashboard ✅
│       ├── style.css              ← Styling ✅
│       └── app.js                 ← Main logic ✅
└── database/
    └── smarthome.sql
```

---

## 🔌 API Endpoints

All requests go to: `http://localhost:5047/api`

### Sensors
```
GET  /sensors              → Get all sensors
POST /sensors              → Create new sensor
```

### Sensor Data
```
GET  /sensor-data/{id}     → Get readings for sensor
POST /sensor-data          → Save new reading
```

---

## 📝 Example API Requests

### Add Sensor
```javascript
fetch('http://localhost:5047/api/sensors', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    name: 'Kitchen Temp',
    type: 'Temperature',
    roomId: 2
  })
})
```

### Send Reading
```javascript
fetch('http://localhost:5047/api/sensor-data', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    sensorId: 1,
    type: 'Temperature',
    value: 24.5
  })
})
```

---

## 🎯 Next Steps

1. **Run the backend:** `dotnet run`
2. **Open the frontend:** `file:///...SmartHomeAPI/frontend/index.html`
3. **Add sample sensors** using the form or curl
4. **Send readings** to see them appear on the dashboard
5. **Click "Pokaż wykres"** to see the chart

---

## ✨ Features You Can Try

- 📊 Real-time dashboard updates
- 🔔 Automatic alarm detection
- 📈 Interactive sensor charts
- 🔄 Auto-refresh every 30 seconds
- 🌐 CORS-enabled API
- 🇵🇱 Polish language interface
- 📱 Responsive design

---

Enjoy your Smart Home Dashboard! 🏠✨

