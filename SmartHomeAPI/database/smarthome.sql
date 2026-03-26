-- Create database if not exists
-- CREATE DATABASE smarthome;

-- Use the database
-- \c smarthome;

-- Create Sensors table
CREATE TABLE IF NOT EXISTS "Sensors" (
    "Id" SERIAL PRIMARY KEY,
    "Name" VARCHAR(255) NOT NULL,
    "Type" VARCHAR(255) NOT NULL,
    "RoomId" INT NOT NULL
);

-- Create SensorData table
CREATE TABLE IF NOT EXISTS "SensorData" (
    "Id" SERIAL PRIMARY KEY,
    "SensorId" INT NOT NULL,
    "Type" VARCHAR(255) NOT NULL,
    "Value" DOUBLE PRECISION NOT NULL,
    "CreatedAt" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("SensorId") REFERENCES "Sensors"("Id") ON DELETE CASCADE
);

-- Optional: Insert some sample data
INSERT INTO "Sensors" ("Name", "Type", "RoomId") VALUES
('Temperature Sensor 1', 'Temperature', 1),
('Humidity Sensor 1', 'Humidity', 1);

INSERT INTO "SensorData" ("SensorId", "Type", "Value") VALUES
(1, 'Temperature', 22.5),
(2, 'Humidity', 60.0);
