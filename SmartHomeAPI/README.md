# 🏢 System Inteligentnego Biura - Smart Home API

Kompletny system monitorowania sensorów IoT dla inteligentnego biura z backendem **C# .NET 10** i frontendem **HTML/CSS/JavaScript**.

---

## 📋 Spis treści

1. [Wymagania systemowe](#wymagania-systemowe)
2. [Szybki start](#szybki-start)
3. [Instalacja i konfiguracja](#instalacja-i-konfiguracja)
4. [Struktura projektu](#struktura-projektu)
5. [Dokumentacja API](#dokumentacja-api)
6. [Używanie frontendu](#używanie-frontendu)
7. [Progi alarmów](#progi-alarmów)
8. [Rozwiązywanie problemów](#rozwiązywanie-problemów)

---

## 🔧 Wymagania systemowe

- **.NET 10 SDK** - pobranie: https://dotnet.microsoft.com/download
- **PostgreSQL 12+** - pobranie: https://www.postgresql.org/download/
- **Przeglądarka internetowa** (Chrome, Firefox, Safari, Edge)
- **Linux/macOS/Windows** - project jest multi-platform

### Zainstalowane pakiety NuGet:
- `Npgsql.EntityFrameworkCore.PostgreSQL` - sterownik PostgreSQL
- `Microsoft.EntityFrameworkCore.Design` - narzędzia do migracji
- `Swashbuckle.AspNetCore` - dokumentacja Swagger/OpenAPI

---

## 🚀 Szybki start

### Terminal 1 - Uruchomienie backendu API

```bash
cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI
dotnet run
```

Backend będzie dostępny na: `http://localhost:5047`

### Terminal 2 - Uruchomienie frontendu

```bash
cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI/frontend

# Opcja 1: Jeśli masz Python 3
python -m http.server 8000

# Opcja 2: Jeśli masz Ruby
ruby -run -ehttpd . -p8000

# Opcja 3: Jeśli masz Node.js
npx http-server -p 8000
```

Frontend będzie dostępny na: `http://localhost:8000/index.html`

### ✅ Gotowe!

- **API dokumentacja**: http://localhost:5047/swagger
- **Dashboard**: http://localhost:8000/index.html

---

## 📦 Instalacja i konfiguracja

### 1. Przygotowanie bazy danych PostgreSQL

```bash
# Zaloguj się do PostgreSQL
psql -U postgres

# W konsoli PostgreSQL:
CREATE DATABASE smarthome;
\c smarthome
```

### 2. Konfiguracja connection string (jeśli inne hasło)

Edytuj plik `appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Host=localhost;Port=5432;Database=smarthome;Username=postgres;Password=TWOJE_HASLO"
  }
}
```

### 3. Inicjalizacja bazy danych

```bash
# Przejdź do katalogu projektu
cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI

# Uruchom migracje Entity Framework
dotnet ef database update
```

### 4. Uruchomienie aplikacji

```bash
dotnet run
```

---

## 📁 Struktura projektu

```
SmartHomeAPI/
│
├── Backend API (C# .NET 10)
│   ├── Program.cs              ← Główny punkt wejścia aplikacji
│   ├── SmartHomeAPI.csproj     ← Definicja projektu
│   ├── appsettings.json        ← Konfiguracja (connection string)
│   ├── appsettings.Development.json
│   │
│   ├── Data/
│   │   └── AppDbContext.cs     ← Entity Framework DbContext
│   │
│   ├── Models/
│   │   ├── Sensor.cs           ← Model czujnika
│   │   └── SensorData.cs       ← Model odczytu danych
│   │
│   └── Migrations/             ← Migracje bazy danych (automatycznie)
│
└── Frontend (HTML/CSS/JavaScript)
    ├── index.html              ← Interfejs użytkownika
    ├── style.css               ← Stylizacja
    ├── app.js                  ← Logika JavaScript
    └── lib/
        └── chart.js            ← Biblioteka do wykresów (CDN)
```

---

## 🔌 Dokumentacja API

Wszystkie endpointy zwracają JSON. Dokumentacja interaktywna dostępna na:
**http://localhost:5047/swagger**

### 📥 POST `/api/sensors` - Dodaj nowy czujnik

**Nagłówek:**
```
Content-Type: application/json
```

**Ciało żądania:**
```json
{
  "name": "Temperatura sala 1",
  "type": "Temperature",
  "roomId": 1
}
```

**Odpowiedź (201 Created):**
```json
{
  "id": 1,
  "name": "Temperatura sala 1",
  "type": "Temperature",
  "roomId": 1
}
```

**Możliwe typy czujników:**
- `Temperature` - Temperatura (°C)
- `Humidity` - Wilgotność (%)
- `Light` - Światło (lux)
- `Motion` - Ruch (0/1)
- `Smoke` - Dym (0/1)
- `CO2` - Dwutlenek węgla (ppm)

**Przykład curl:**
```bash
curl -X POST http://localhost:5047/api/sensors \
  -H "Content-Type: application/json" \
  -d '{"name":"Temperatura sala 1","type":"Temperature","roomId":1}'
```

---

### 📤 GET `/api/sensors` - Pobierz listę wszystkich czujników

**Odpowiedź (200 OK):**
```json
[
  {
    "id": 1,
    "name": "Temperatura sala 1",
    "type": "Temperature",
    "roomId": 1
  },
  {
    "id": 2,
    "name": "Wilgotność sala 1",
    "type": "Humidity",
    "roomId": 1
  }
]
```

**Przykład curl:**
```bash
curl http://localhost:5047/api/sensors
```

---

### 📥 POST `/api/sensor-data` - Wyślij odczyt czujnika

**Nagłówek:**
```
Content-Type: application/json
```

**Ciało żądania:**
```json
{
  "sensorId": 1,
  "type": "Temperature",
  "value": 22.5
}
```

**Odpowiedź (201 Created):**
```json
{
  "id": 1,
  "sensorId": 1,
  "type": "Temperature",
  "value": 22.5,
  "createdAt": "2026-03-28T10:30:45.123Z"
}
```

**Przykład curl:**
```bash
curl -X POST http://localhost:5047/api/sensor-data \
  -H "Content-Type: application/json" \
  -d '{"sensorId":1,"type":"Temperature","value":22.5}'
```

---

### 📊 GET `/api/sensor-data/{sensorId}` - Pobierz historię odczytów

**Parametry:**
- `sensorId` (int) - ID czujnika

**Odpowiedź (200 OK):**
```json
[
  {
    "id": 10,
    "sensorId": 1,
    "type": "Temperature",
    "value": 23.0,
    "createdAt": "2026-03-28T10:35:00.000Z"
  },
  {
    "id": 9,
    "sensorId": 1,
    "type": "Temperature",
    "value": 22.8,
    "createdAt": "2026-03-28T10:30:00.000Z"
  }
]
```

**Przykład curl:**
```bash
curl http://localhost:5047/api/sensor-data/1
```

---

## 💻 Używanie frontendu

### Główny ekran - Dashboard

1. **Karty czujników** - wyświetlają:
   - Nazwę czujnika
   - Ostatnią zmierzoną wartość
   - Status (OK lub ALARM)

2. **Wykresy** - historyczne dane dla wybranych czujników

3. **Formularze** - dodawanie nowych czujników i odczytów

### Dodawanie nowego czujnika

1. Przejdź do sekcji "Dodaj nowy czujnik"
2. Wpisz **Nazwa czujnika** (np. "Temperatura sala 1")
3. Wybierz **Typ czujnika** z listy rozwijanej
4. Wpisz **ID pokoju** (liczba całkowita)
5. Kliknij przycisk **"Dodaj czujnik"**

### Wysyłanie odczytu

1. Przejdź do sekcji "Wyślij odczyt czujnika"
2. Wpisz **ID sensora** (zgodne z ID z dashboardu)
3. Wybierz **Typ** pomiaru
4. Wpisz **Wartość** (liczba z kropką dziesiętną)
5. Kliknij **"Wyślij do czytania"**

### Automatyczne odświeżanie

Dashboard **automatycznie odświeża dane co 30 sekund**. Możesz to zmienić edytując `app.js`:

```javascript
setInterval(loadAll, 30000); // Zmień 30000 na liczbę milisekund
```

---

## 🚨 Progi alarmów

System automatycznie oznacza status jako **ALARM** gdy wartość przekroczy próg:

| Typ czujnika | Próg alarmowy |
|---|---|
| **Temperatura** | > 30°C |
| **Wilgotność** | > 70% |
| **CO₂** | > 1000 ppm |
| **Dym** | > 0 (każdy odczyt) |
| **Światło** | Brak (informacyjne) |
| **Ruch** | Brak (informacyjne) |

Status **OK** (zielony) = wartość poniżej progu
Status **ALARM** (czerwony) = wartość powyżej progu

---

## 🔍 Rozwiązywanie problemów

### Problem: "Failed to bind to address http://127.0.0.1:5047"

**Przyczyna:** Port 5047 jest już zajęty

**Rozwiązanie:**
```bash
# Przejrzyj procesy używające port 5047
lsof -i :5047

# Zabij proces
kill -9 <PID>

# Lub użyj innego portu w launchSettings.json
```

### Problem: "Connection refused" - brak połączenia z frontendem do API

**Przyczyna:** CORS nie jest skonfigurowany lub frontend i backend uruchamiają się na innych portach

**Rozwiązanie:** Backend automatycznie pozwala na żądania CORS z dowolnego źródła. Sprawdź konsolę przeglądarki (F12 → Console) czy są błędy CORS.

### Problem: "Database does not exist"

**Przyczyna:** Nie uruchomiłeś migracji

**Rozwiązanie:**
```bash
dotnet ef database update
```

### Problem: "Error retrieving sensors" w aplikacji

**Przyczyna:** Backend nie jest uruchomiony lub baza danych nie jest dostępna

**Rozwiązanie:**
1. Sprawdź czy backend działa: `http://localhost:5047/swagger`
2. Sprawdź czy PostgreSQL jest uruchomiony
3. Sprawdź connection string w `appsettings.json`

### Problem: Frontend nie ładuje się

**Przyczyna:** Frontend server nie jest uruchomiony

**Rozwiązanie:**
```bash
cd frontend
python -m http.server 8000
```

---

## 📊 Przykładowy workflow

### 1. Dodaj czujnik temperatury

```bash
curl -X POST http://localhost:5047/api/sensors \
  -H "Content-Type: application/json" \
  -d '{"name":"Temperatura Biuro","type":"Temperature","roomId":1}'
```

Odpowiedź: `{"id":1, "name":"Temperatura Biuro", ...}`

### 2. Wyślij kilka odczytów

```bash
curl -X POST http://localhost:5047/api/sensor-data \
  -H "Content-Type: application/json" \
  -d '{"sensorId":1,"type":"Temperature","value":22.5}'

curl -X POST http://localhost:5047/api/sensor-data \
  -H "Content-Type: application/json" \
  -d '{"sensorId":1,"type":"Temperature","value":23.1}'

curl -X POST http://localhost:5047/api/sensor-data \
  -H "Content-Type: application/json" \
  -d '{"sensorId":1,"type":"Temperature","value":31.5}'  # ALARM!
```

### 3. Otwórz dashboard

Otwórz http://localhost:8000/index.html w przeglądarce

### 4. Dodaj więcej czujników

Użyj formularza lub API aby dodać:
- Wilgotność
- CO₂
- Detektor dymu

---

## 🔧 Zaawansowana konfiguracja

### Zmiana portu API

Edytuj `Properties/launchSettings.json`:

```json
{
  "profiles": {
    "http": {
      "commandName": "Project",
      "launchBrowser": false,
      "applicationUrl": "http://localhost:5047"  // Zmień tutaj
    }
  }
}
```

### Zmiana portu frontendu

```bash
# Python
python -m http.server 9000  # Zmień 9000 na inny port

# Node.js
npx http-server -p 9000
```

**Pamiętaj aby zmienić `apiBase` w `app.js`:**
```javascript
const apiBase = 'http://localhost:5047/api';  // Jeśli zmieniłeś port API
```

---

## 📝 Licencja

Projekt Open Source. Możesz swobodnie używać, modyfikować i rozpowszechniać.

---

## 🆘 Wsparcie

W przypadku pytań lub problemów:
1. Sprawdź sekcję [Rozwiązywanie problemów](#rozwiązywanie-problemów)
2. Sprawdź konsolę przeglądarki (F12 → Console)
3. Sprawdź logi backendu
4. Sprawdź dokumentację Swagger: http://localhost:5047/swagger

---

**Ostatnia aktualizacja:** 28 marca 2026
**Wersja:** 1.0
**Framework:** .NET 10 + Vanilla JavaScript

