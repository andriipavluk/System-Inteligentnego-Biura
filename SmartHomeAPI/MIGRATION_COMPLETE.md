# ✅ SQLite → PostgreSQL Migration - COMPLETE

## Summary of Changes

All files have been updated to switch from SQLite to PostgreSQL.

---

## 📝 Files Modified (4)

### 1. ✅ appsettings.json
**Changed:** Connection string from SQLite to PostgreSQL
```json
"DefaultConnection": "Host=localhost;Port=5432;Database=smarthome;Username=postgres;Password=mojeHaslo123"
```

### 2. ✅ appsettings.Development.json
**Changed:** Added PostgreSQL connection string
```json
"DefaultConnection": "Host=localhost;Port=5432;Database=smarthome;Username=postgres;Password=mojeHaslo123"
```

### 3. ✅ Program.cs
**Changed:** Line 8 - from `UseSqlite()` to `UseNpgsql()`
```csharp
// OLD: options.UseSqlite(...)
// NEW: options.UseNpgsql(...)
```

### 4. ✅ SmartHomeAPI.csproj
**Removed:** `Microsoft.EntityFrameworkCore.Sqlite` package
**Kept:** `Npgsql.EntityFrameworkCore.PostgreSQL` package

---

## 🗂️ Files Deleted

### ✅ Migrations/ folder
**Deleted:** Old SQLite migration files
- `20260325211341_InitialCreate.cs`
- `20260325211341_InitialCreate.Designer.cs`
- `AppDbContextModelSnapshot.cs`

Reason: These were generated for SQLite and won't work with PostgreSQL. New ones will be created.

---

## 🚀 Commands to Run (In Order)

### Option A: Run Commands One-by-One
```bash
# Step 1: Navigate to project
cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI

# Step 2: Clean old build artifacts
dotnet clean
rm -rf bin obj

# Step 3: Restore packages
dotnet restore

# Step 4: Create new migration for PostgreSQL
dotnet ef migrations add InitialCreate

# Step 5: Apply migration to database
dotnet ef database update

# Step 6: Run the API
dotnet run
```

### Option B: Copy-Paste All at Once
```bash
cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI && \
dotnet clean && \
rm -rf bin obj && \
dotnet restore && \
dotnet ef migrations add InitialCreate && \
dotnet ef database update && \
dotnet run
```

---

## ✅ Prerequisites

Before running the commands, verify:

- ✅ PostgreSQL is running on `localhost:5432`
- ✅ User `postgres` exists with password `mojeHaslo123`
- ✅ Database `smarthome` will be created automatically
- ✅ .NET 10 SDK is installed
- ✅ Entity Framework CLI is available (`dotnet ef`)

---

## 📊 What Each Command Does

| Command | Purpose |
|---------|---------|
| `dotnet clean` | Remove old build artifacts |
| `rm -rf bin obj` | Clean build directories |
| `dotnet restore` | Download packages (including Npgsql) |
| `dotnet ef migrations add InitialCreate` | Create PostgreSQL-specific migration |
| `dotnet ef database update` | Apply migration to PostgreSQL database |
| `dotnet run` | Start the API server |

---

## 🧪 Testing After Migration

Once the API is running, test in another terminal:

```bash
# 1. Get all sensors (should be empty initially)
curl http://localhost:5047/api/sensors

# 2. Add a test sensor
curl -X POST http://localhost:5047/api/sensors \
  -H "Content-Type: application/json" \
  -d '{"name":"Test Sensor","type":"Temperature","roomId":1}'

# 3. Send a reading
curl -X POST http://localhost:5047/api/sensor-data \
  -H "Content-Type: application/json" \
  -d '{"sensorId":1,"type":"Temperature","value":25.5}'

# 4. Get sensor data
curl http://localhost:5047/api/sensor-data/1
```

✅ If all commands work, migration is successful!

---

## 🐛 Troubleshooting

### Error: "Unable to connect to host..."
- PostgreSQL not running
- Run: `psql --version` to verify installation
- Start PostgreSQL service

### Error: "role \"postgres\" does not exist"
- Create user: `createuser -s postgres`
- Set password: `psql -U postgres -c "ALTER USER postgres PASSWORD 'mojeHaslo123';"`

### Error: "database \"smarthome\" does not exist"
- This is OK - it will be created by `dotnet ef database update`

### Error: "Microsoft.EntityFrameworkCore.Sqlite still referenced"
- Run: `dotnet clean && dotnet restore`

---

## 📈 PostgreSQL Connection Details

```
Host:     localhost
Port:     5432
Database: smarthome
Username: postgres
Password: mojeHaslo123
```

---

## ✨ Migration Complete!

All files have been updated. The project is ready to:

1. Use PostgreSQL instead of SQLite ✅
2. Create new migrations for PostgreSQL ✅
3. Store data in PostgreSQL database ✅

Just run the commands above and your dashboard will be using PostgreSQL! 🚀

