# ⚡ Szybka konfiguracja - Smart Home API

## 🔥 Najszybciej (copy & paste)

### Krok 1: Przygotuj bazę PostgreSQL

```bash
psql -U postgres -c "CREATE DATABASE smarthome;"
```

### Krok 2: Terminal 1 - Backend

```bash
cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI
dotnet ef database update    # Inicjalizacja bazy
dotnet run                   # Uruchomienie backendu
```

**Backend gotowy:** http://localhost:5047/swagger

### Krok 3: Terminal 2 - Frontend

```bash
cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI/frontend
python -m http.server 8000  # Uruchomienie frontendu
```

**Frontend gotowy:** http://localhost:8000/index.html

---

## ✅ Testowanie API (Terminal 3)

### Dodaj czujnik

```bash
curl -X POST http://localhost:5047/api/sensors \
  -H "Content-Type: application/json" \
  -d '{"name":"Test Temp","type":"Temperature","roomId":1}'
```

### Wyślij odczyt

```bash
curl -X POST http://localhost:5047/api/sensor-data \
  -H "Content-Type: application/json" \
  -d '{"sensorId":1,"type":"Temperature","value":25.5}'
```

### Pobierz czujniki

```bash
curl http://localhost:5047/api/sensors
```

### Pobierz historię

```bash
curl http://localhost:5047/api/sensor-data/1
```

---

## 🐛 Problemy?

| Problem | Rozwiązanie |
|---------|---|
| Port 5047 zajęty | `lsof -i :5047` → `kill -9 <PID>` |
| Baza nie istnieje | `dotnet ef database update` |
| Frontend nie ładuje się | Sprawdź czy Python server działa |
| API nie odpowiada | Sprawdź http://localhost:5047/swagger |

---

## 📚 Pełna dokumentacja

Czytaj `README.md` dla kompletnej dokumentacji

