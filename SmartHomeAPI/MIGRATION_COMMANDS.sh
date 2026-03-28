#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════════
# 🔄 SQLite → PostgreSQL Migration Guide
# ═══════════════════════════════════════════════════════════════════════════════
#
# This script contains all the commands needed to complete the migration.
# Run each step in order in your terminal.
#
# ═══════════════════════════════════════════════════════════════════════════════

echo "════════════════════════════════════════════════════════════════════════════"
echo "🔄 STEP-BY-STEP MIGRATION: SQLite → PostgreSQL"
echo "════════════════════════════════════════════════════════════════════════════"
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# STEP 1: Navigate to project directory
# ═══════════════════════════════════════════════════════════════════════════════
echo "📁 STEP 1: Navigate to project directory"
echo "─────────────────────────────────────────────────────────────────────────"
echo "Command:"
echo "  cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI"
echo ""
echo "Action:"
cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI
echo "✅ Done"
echo ""
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# STEP 2: Clean build artifacts (optional but recommended)
# ═══════════════════════════════════════════════════════════════════════════════
echo "🧹 STEP 2: Clean old build artifacts (recommended)"
echo "─────────────────────────────────────────────────────────────────────────"
echo "Commands:"
echo "  dotnet clean"
echo "  rm -rf bin obj"
echo ""
echo "Action:"
dotnet clean 2>/dev/null
rm -rf bin obj
echo "✅ Done"
echo ""
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# STEP 3: Restore packages
# ═══════════════════════════════════════════════════════════════════════════════
echo "📦 STEP 3: Restore NuGet packages"
echo "─────────────────────────────────────────────────────────────────────────"
echo "Command:"
echo "  dotnet restore"
echo ""
echo "Action:"
dotnet restore
echo ""
echo "✅ Done"
echo ""
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# STEP 4: Create new PostgreSQL migration
# ═══════════════════════════════════════════════════════════════════════════════
echo "🗂️  STEP 4: Create new migration for PostgreSQL"
echo "─────────────────────────────────────────────────────────────────────────"
echo "Command:"
echo "  dotnet ef migrations add InitialCreate"
echo ""
echo "Expected output:"
echo "  • Migration files created in Migrations/ folder"
echo "  • Files: {timestamp}_InitialCreate.cs, {timestamp}_InitialCreate.Designer.cs, AppDbContextModelSnapshot.cs"
echo ""
echo "Action:"
dotnet ef migrations add InitialCreate
if [ $? -eq 0 ]; then
    echo "✅ Migration created successfully"
else
    echo "❌ Migration creation failed - check above for errors"
fi
echo ""
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# STEP 5: Update database
# ═══════════════════════════════════════════════════════════════════════════════
echo "💾 STEP 5: Apply migration to PostgreSQL database"
echo "─────────────────────────────────────────────────────────────────────────"
echo "Command:"
echo "  dotnet ef database update"
echo ""
echo "Expected:"
echo "  • Connection to postgres@localhost:5432"
echo "  • Database 'smarthome' created (if not exists)"
echo "  • Tables: Sensors, SensorData, __EFMigrationsHistory"
echo ""
echo "Action:"
dotnet ef database update
if [ $? -eq 0 ]; then
    echo "✅ Database updated successfully"
else
    echo "❌ Database update failed - check connection string and PostgreSQL"
fi
echo ""
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# STEP 6: Run the API
# ═══════════════════════════════════════════════════════════════════════════════
echo "🚀 STEP 6: Start the API"
echo "─────────────────────────────────────────────────────────────────────────"
echo "Command:"
echo "  dotnet run"
echo ""
echo "Expected output:"
echo "  • 'Now listening on: http://127.0.0.1:5047'"
echo "  • Swagger UI at: http://localhost:5047/swagger"
echo ""
echo "⚠️  Keep this running in the terminal!"
echo ""
echo "To stop: Press Ctrl+C"
echo ""
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# COMPLETE COMMAND BLOCK (Copy and Paste All)
# ═══════════════════════════════════════════════════════════════════════════════
echo "════════════════════════════════════════════════════════════════════════════"
echo "📋 COMPLETE COMMAND BLOCK (Copy & Paste All at Once)"
echo "════════════════════════════════════════════════════════════════════════════"
echo ""
echo "cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI && \\"
echo "dotnet clean && \\"
echo "rm -rf bin obj && \\"
echo "dotnet restore && \\"
echo "dotnet ef migrations add InitialCreate && \\"
echo "dotnet ef database update && \\"
echo "dotnet run"
echo ""
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# VERIFICATION CHECKLIST
# ═══════════════════════════════════════════════════════════════════════════════
echo "════════════════════════════════════════════════════════════════════════════"
echo "✅ VERIFICATION CHECKLIST"
echo "════════════════════════════════════════════════════════════════════════════"
echo ""
echo "Before running the commands, verify:"
echo ""
echo "Configuration Files:"
echo "  ✓ appsettings.json has PostgreSQL connection string"
echo "  ✓ appsettings.Development.json has PostgreSQL connection string"
echo ""
echo "Code:"
echo "  ✓ Program.cs uses UseNpgsql() (not UseSqlite)"
echo ""
echo "Packages:"
echo "  ✓ SmartHomeAPI.csproj has Npgsql.EntityFrameworkCore.PostgreSQL"
echo "  ✓ SmartHomeAPI.csproj does NOT have Microsoft.EntityFrameworkCore.Sqlite"
echo ""
echo "Database:"
echo "  ✓ PostgreSQL running on localhost:5432"
echo "  ✓ Username: postgres"
echo "  ✓ Password: mojeHaslo123"
echo "  ✓ Database 'smarthome' (will be created if needed)"
echo ""
echo "Old Files:"
echo "  ✓ Migrations/ folder deleted or renamed"
echo "  ✓ Old smarthome.db SQLite file can be deleted or kept"
echo ""
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# TROUBLESHOOTING
# ═══════════════════════════════════════════════════════════════════════════════
echo "════════════════════════════════════════════════════════════════════════════"
echo "🐛 TROUBLESHOOTING"
echo "════════════════════════════════════════════════════════════════════════════"
echo ""
echo "❌ Error: 'Unable to connect to host...'
   → PostgreSQL not running
   → Check: psql --version
   → Start PostgreSQL service"
echo ""
echo "❌ Error: 'role \"postgres\" does not exist'
   → PostgreSQL user doesn't exist
   → Create: createuser -s postgres"
echo ""
echo "❌ Error: 'database \"smarthome\" does not exist'
   → This is OK - it will be created by 'dotnet ef database update'"
echo ""
echo "❌ Error: 'Microsoft.EntityFrameworkCore.Sqlite still referenced'
   → Rebuild: dotnet clean && dotnet restore"
echo ""
echo "❌ Error: 'No migrations found'
   → Run: dotnet ef migrations add InitialCreate"
echo ""
echo "✅ Success: 'Now listening on: http://127.0.0.1:5047'
   → API is running with PostgreSQL!"
echo ""
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# TEST API AFTER MIGRATION
# ═══════════════════════════════════════════════════════════════════════════════
echo "════════════════════════════════════════════════════════════════════════════"
echo "🧪 TEST API (Run in another terminal after 'dotnet run')"
echo "════════════════════════════════════════════════════════════════════════════"
echo ""
echo "1️⃣  Get all sensors (should be empty):"
echo "   curl http://localhost:5047/api/sensors"
echo ""
echo "2️⃣  Add a sensor:"
echo "   curl -X POST http://localhost:5047/api/sensors \\"
echo "     -H \"Content-Type: application/json\" \\"
echo "     -d '{\"name\":\"Test Sensor\",\"type\":\"Temperature\",\"roomId\":1}'"
echo ""
echo "3️⃣  Get sensors again (should show 1 sensor):"
echo "   curl http://localhost:5047/api/sensors"
echo ""
echo "4️⃣  Send a reading:"
echo "   curl -X POST http://localhost:5047/api/sensor-data \\"
echo "     -H \"Content-Type: application/json\" \\"
echo "     -d '{\"sensorId\":1,\"type\":\"Temperature\",\"value\":25.5}'"
echo ""
echo "✅ If all commands work, migration is successful!"
echo ""
echo ""

