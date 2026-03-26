# System Inteligentnego Biura - Smart Home API

This project is a smart home system with a C# backend API and a simple frontend dashboard.

## Structure

- `SmartHomeAPI/`: Backend API built with ASP.NET Core and Entity Framework Core, using PostgreSQL.
- `frontend/`: Simple HTML/CSS/JS frontend that connects to the API.
- `database/`: SQL schema for the database.

## Setup

1. Set up PostgreSQL database and run the SQL script in `database/smarthome.sql`.
2. Update `appsettings.json` with your database connection string.
3. Run the API: `dotnet run` in SmartHomeAPI folder.
4. Open `frontend/index.html` in a browser to view the dashboard.

## API Endpoints

- GET /api/sensors: Get all sensors
- POST /api/sensors: Create a new sensor
- GET /api/sensor-data/{sensor_id}: Get data for a sensor
- POST /api/sensor-data: Create new sensor data
