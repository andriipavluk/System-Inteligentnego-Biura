# 🔍 app.js Function Reference

## Complete Function Documentation

---

## 1. checkAlarm(type, value)
**Purpose:** Determine if a sensor reading exceeds alarm threshold

**Parameters:**
- `type` (string): Sensor type (Temperature, Humidity, CO2, Smoke, Motion, Light)
- `value` (number): Sensor reading value

**Returns:** boolean (true = ALARM, false = OK)

**Example:**
```javascript
checkAlarm("Temperature", 31)  // Returns true (31 > 30)
checkAlarm("Humidity", 65)     // Returns false (65 ≤ 70)
```

**Thresholds:**
- Temperature > 30 = ALARM
- Humidity > 70 = ALARM
- CO2 > 1000 = ALARM
- Smoke > 0.05 = ALARM
- Motion > 0.05 = ALARM

---

## 2. formatValue(type, value)
**Purpose:** Format sensor value with appropriate unit

**Parameters:**
- `type` (string): Sensor type
- `value` (number): Sensor value

**Returns:** string (formatted value with unit)

**Example:**
```javascript
formatValue("Temperature", 22.5)  // Returns "22.50°C"
formatValue("Humidity", 55.3)     // Returns "55.30%"
formatValue("Light", 800)         // Returns "800.00lux"
formatValue("Smoke", 1)           // Returns "DETECTED"
```

---

## 3. getSensorTypeName(type)
**Purpose:** Get Polish name for sensor type

**Parameters:**
- `type` (string): English sensor type

**Returns:** string (Polish name)

**Example:**
```javascript
getSensorTypeName("Temperature")  // Returns "Temperatura"
getSensorTypeName("Humidity")     // Returns "Wilgotność"
getSensorTypeName("CO2")          // Returns "CO₂"
```

**Mapping:**
- Temperature → Temperatura
- Humidity → Wilgotność
- Light → Światło
- Motion → Ruch
- Smoke → Dym
- CO2 → CO₂

---

## 4. getUnit(type)
**Purpose:** Get unit symbol for sensor type

**Parameters:**
- `type` (string): Sensor type

**Returns:** string (unit symbol)

**Example:**
```javascript
getUnit("Temperature")  // Returns "°C"
getUnit("Humidity")     // Returns "%"
getUnit("CO2")          // Returns "ppm"
```

---

## 5. fetchSensors()
**Purpose:** Fetch all sensors from API and display them

**Parameters:** None

**Returns:** Promise (resolves to void)

**API Call:** `GET /api/sensors`

**Actions:**
- Fetches sensor list from backend
- Calls `displaySensors()` to render
- Shows error message if failed

**Example:**
```javascript
await fetchSensors();  // Loads and displays all sensors
```

---

## 6. fetchSensorData(sensorId)
**Purpose:** Fetch readings for a specific sensor

**Parameters:**
- `sensorId` (number): Sensor ID

**Returns:** Promise (resolves to array of readings)

**API Call:** `GET /api/sensor-data/{sensorId}`

**Example:**
```javascript
const readings = await fetchSensorData(1);
// Returns array: [{id, sensorId, type, value, createdAt}, ...]
```

---

## 7. displaySensors(sensors)
**Purpose:** Render sensor cards on dashboard

**Parameters:**
- `sensors` (array): Array of sensor objects

**Returns:** Promise (resolves to void)

**Actions:**
- Creates sensor card for each sensor
- Fetches latest reading for each
- Displays formatted value with status
- Adds "Pokaż wykres" button
- Attaches chart click listeners

**Sensor Card Shows:**
- Sensor name
- Latest value (formatted)
- Status: OK (green) or ALARM (red)
- Chart button

**Example:**
```javascript
const sensors = [{id: 1, name: "Room Temp", type: "Temperature", roomId: 1}];
await displaySensors(sensors);
```

---

## 8. renderChart(sensorId)
**Purpose:** Display Chart.js line chart for sensor

**Parameters:**
- `sensorId` (number): Sensor ID to chart

**Returns:** void

**Chart Type:** Line chart

**Chart Shows:**
- X-axis: Time (with Polish locale)
- Y-axis: Sensor values
- All historical readings for sensor
- Legend with sensor type name

**Example:**
```javascript
renderChart(1);  // Displays chart for sensor ID 1
```

**Chart Details:**
- Uses `sensorDataCache[sensorId]`
- Destroys old chart first
- Shows timestamps in Polish locale
- Includes proper axis labels
- Responsive layout

---

## 9. addSensor(event)
**Purpose:** Handle "Add Sensor" form submission

**Parameters:**
- `event` (Event): Form submit event

**Returns:** Promise (resolves to void)

**Form Fields Used:**
- `#sensorName` - Sensor name
- `#sensorType` - Type dropdown
- `#roomId` - Room ID

**API Call:** `POST /api/sensors`

**Request Body:**
```json
{
  "name": "string",
  "type": "string",
  "roomId": "number"
}
```

**Actions:**
- Validates form fields
- Sends POST to backend
- Shows success/error alert
- Resets form on success
- Refreshes dashboard

**Example:**
```javascript
// User fills form and submits
// Function automatically called by form submit event
```

---

## 10. sendReading(event)
**Purpose:** Handle "Send Reading" form submission

**Parameters:**
- `event` (Event): Form submit event

**Returns:** Promise (resolves to void)

**Form Fields Used:**
- `#readingSensorId` - Sensor ID
- `#readingType` - Reading type
- `#readingValue` - Reading value

**API Call:** `POST /api/sensor-data`

**Request Body:**
```json
{
  "sensorId": "number",
  "type": "string",
  "value": "number"
}
```

**Actions:**
- Validates form fields
- Sends POST to backend
- Shows success/error alert
- Resets form on success
- Refreshes dashboard

**Example:**
```javascript
// User fills form and submits
// Function automatically called by form submit event
```

---

## Global Variables

```javascript
const API_URL = 'http://localhost:5047/api'
let sensorDataCache = {}      // Stores sensor readings
let charts = {}               // Stores Chart.js instances
```

---

## Event Listeners

**Automatically Set Up:**

1. **Form Submit - Add Sensor**
```javascript
document.getElementById('addSensorForm').addEventListener('submit', addSensor);
```

2. **Form Submit - Send Reading**
```javascript
document.getElementById('sendReadingForm').addEventListener('submit', sendReading);
```

3. **Chart Buttons (Dynamic)**
```javascript
document.querySelectorAll('.chart-button').forEach(button => {
  button.addEventListener('click', (e) => {
    const sensorId = parseInt(e.target.dataset.sensorId);
    renderChart(sensorId);
  });
});
```

---

## Initialization (DOMContentLoaded)

**On Page Load:**
1. ✅ Attach form listeners
2. ✅ Call `fetchSensors()` to load dashboard
3. ✅ Set up auto-refresh: `setInterval(fetchSensors, 30000)`

**Result:**
- Dashboard displays all sensors
- Forms are ready
- Auto-refresh starts (30 seconds)

---

## Data Flow

```
Page Load
   ↓
DOMContentLoaded event
   ↓
fetchSensors()
   ├─ GET /api/sensors
   ├─ For each sensor:
   │  └─ fetchSensorData(id)
   │     └─ GET /api/sensor-data/{id}
   ├─ displaySensors(sensors)
   │  ├─ Create HTML cards
   │  ├─ Add chart buttons
   │  └─ Attach listeners
   └─ Auto-refresh every 30s
```

---

## Error Handling

**Network Errors:**
- Caught in try/catch blocks
- User-friendly error messages
- Polish language alerts

**Form Validation:**
- HTML5 required fields
- Numeric type checking
- Range validation (if applicable)

**Empty States:**
- "Brak czujników" (No sensors)
- "BRAK DANYCH" (No data)
- Disabled chart button if no data

---

## Performance Optimizations

✓ Sensor data caching (avoid duplicate API calls)
✓ Chart instance reuse (destroy before creating new)
✓ Event delegation for dynamic buttons
✓ Efficient DOM manipulation
✓ Auto-refresh interval (not too frequent)

---

## Browser Compatibility

✓ Modern browsers (ES6 support)
✓ Fetch API (all modern browsers)
✓ Chart.js (all modern browsers)
✓ Template literals (ES6)
✓ Arrow functions (ES6)

---

## Testing Functions Individually

```javascript
// Test checkAlarm
checkAlarm("Temperature", 35)     // true
checkAlarm("Humidity", 50)        // false

// Test formatting
formatValue("Temperature", 22.5)  // "22.50°C"
formatValue("Humidity", 55)       // "55.00%"

// Test name translation
getSensorTypeName("Temperature")  // "Temperatura"

// Fetch and display
await fetchSensors()              // Loads all sensors

// Render chart (if sensor data exists)
renderChart(1)                    // Shows chart for sensor 1
```

---

**All 10 core functions fully integrated and working! ✅**

