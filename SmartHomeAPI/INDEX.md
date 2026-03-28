# 📖 Indeks Dokumentacji - Smart Home API

## 🎯 Gdzie zacząć?

### 👶 Jestem nowy - pierwszy raz z projektem
**Przeczytaj:** [SETUP.md](./SETUP.md) (⏱️ 5 minut)
- Szybki start w 3 krokach
- Copy & paste komendy
- Błyskawiczne testowanie API

### 📚 Chcę wiedzieć wszystko
**Przeczytaj:** [README.md](./README.md) (⏱️ 20 minut)
- Pełna dokumentacja (490 linii)
- Wszytkie endpointy API
- Instrukcje frontendu
- Rozwiązywanie problemów

### 🔄 Chcę zobaczyć co się zmieniło
**Przeczytaj:** [BEFORE_AFTER.md](./BEFORE_AFTER.md) (⏱️ 10 minut)
- Porównanie przed/po
- Optymalizacje kodu
- Statystyka zmian

---

## 📁 Struktura projektu

```
SmartHomeAPI/
│
├── 📘 README.md            ← Kompletna dokumentacja (START TUTAJ)
├── 📗 SETUP.md             ← Szybki start
├── 📙 BEFORE_AFTER.md      ← Historia zmian
│
├── Program.cs              ← Backend (C# .NET 10)
├── SmartHomeAPI.csproj     ← Konfiguracja projektu
├── appsettings.json        ← Connection string PostgreSQL
│
├── Data/
│   └── AppDbContext.cs     ← Entity Framework DbContext
│
├── Models/
│   ├── Sensor.cs           ← Model czujnika
│   └── SensorData.cs       ← Model danych
│
├── Migrations/             ← EF Core migrations
│
├── Properties/
│   └── launchSettings.json ← Konfiguracja portu
│
└── frontend/
    ├── index.html          ← Dashboard UI
    ├── style.css           ← Stylizacja
    └── app.js              ← Logika JavaScript
```

---

## 🚀 Kroki startowe

### 1️⃣ Zainstaluj wymagane narzędzia
- **Python** lub **Node.js** (do frontendu)
- **.NET 10 SDK** (backend)
- **PostgreSQL** (baza danych)

### 2️⃣ Uruchom backend
```bash
cd /home/pavluk/RiderProjects/System-Inteligentnego-Biura/SmartHomeAPI
dotnet ef database update   # Inicjalizacja BD
dotnet run                  # Uruchomienie
```
→ Backend: http://localhost:5047

### 3️⃣ Uruchom frontend
```bash
cd frontend
python -m http.server 8000
```
→ Dashboard: http://localhost:8000/index.html

### 4️⃣ Test API
```bash
curl http://localhost:5047/api/sensors
```

---

## 📊 API Reference

### Szybki przegląd endpointów

| Metoda | Endpoint | Opis |
|--------|----------|------|
| `POST` | `/api/sensors` | Dodaj nowy czujnik |
| `GET` | `/api/sensors` | Pobierz wszystkie czujniki |
| `POST` | `/api/sensor-data` | Wyślij odczyt |
| `GET` | `/api/sensor-data/{id}` | Pobierz historię odczytów |

**Pełna dokumentacja:** [README.md - Dokumentacja API](./README.md#-dokumentacja-api)

---

## 🎯 Podstawowe funkcje

### ✅ Co system potrafi?

1. **Monitorowanie czujników**
   - Temperatura
   - Wilgotność
   - Oświetlenie
   - Ruch
   - Dym
   - CO₂

2. **Automatyczne alarmy**
   - Temperatura > 30°C
   - Wilgotność > 70%
   - CO₂ > 1000 ppm
   - Detekcja dymu

3. **Dashboard**
   - Karty czujników
   - Wykresy historyczne
   - Auto-refresh (30s)

4. **API RESTful**
   - Swagger dokumentacja
   - JSON requests/responses
   - CORS enabled

---

## 🔧 Rozwiązywanie problemów

### Problem: Port 5047 zajęty
```bash
lsof -i :5047      # Sprawdź
kill -9 <PID>      # Zabij proces
```

### Problem: Baza nie inicjalizuje
```bash
dotnet ef database update
```

### Problem: Frontend nie łączy się z API
- Sprawdź konsolę (F12)
- Sprawdź czy backend działa
- Sprawdź CORS (backend)

**Więcej:** [README.md - Rozwiązywanie problemów](./README.md#-rozwiązywanie-problemów)

---

## 💡 Przykłady

### Dodaj czujnik (curl)
```bash
curl -X POST http://localhost:5047/api/sensors \
  -H "Content-Type: application/json" \
  -d '{"name":"Sala 1 Temp","type":"Temperature","roomId":1}'
```

### Wyślij odczyt
```bash
curl -X POST http://localhost:5047/api/sensor-data \
  -H "Content-Type: application/json" \
  -d '{"sensorId":1,"type":"Temperature","value":22.5}'
```

### Pobierz dane
```bash
curl http://localhost:5047/api/sensor-data/1
```

---

## 📈 Architektura

```
┌─────────────────────────────────────────┐
│          Frontend (HTML/CSS/JS)         │
│    http://localhost:8000/index.html    │
└────────────────┬────────────────────────┘
                 │
              Fetch API
                 │
                 ▼
┌─────────────────────────────────────────┐
│      Backend (C# .NET 10 Minimal API)   │
│    http://localhost:5047/api/*         │
│                                         │
│  ✓ POST /sensors                        │
│  ✓ GET /sensors                         │
│  ✓ POST /sensor-data                    │
│  ✓ GET /sensor-data/{id}               │
└────────────────┬────────────────────────┘
                 │
              EF Core
                 │
                 ▼
┌─────────────────────────────────────────┐
│          PostgreSQL Database            │
│    localhost:5432/smarthome            │
│                                         │
│  ✓ Sensors (tabela)                    │
│  ✓ SensorData (tabela)                 │
└─────────────────────────────────────────┘
```

---

## 🔐 Bezpieczeństwo

- ✅ PostgreSQL (production-ready)
- ✅ CORS skonfigurowany
- ✅ Walidacja danych
- ✅ Obsługa błędów
- ✅ Connection string zabezpieczony

---

## 📚 Pełna dokumentacja

### Główne tematy w README.md:

1. [Wymagania systemowe](./README.md#-wymagania-systemowe)
2. [Szybki start](./README.md#-szybki-start)
3. [Instalacja i konfiguracja](./README.md#-instalacja-i-konfiguracja)
4. [Struktura projektu](./README.md#-struktura-projektu)
5. [Dokumentacja API](./README.md#-dokumentacja-api)
6. [Używanie frontendu](./README.md#-używanie-frontendu)
7. [Progi alarmów](./README.md#-progi-alarmów)
8. [Rozwiązywanie problemów](./README.md#-rozwiązywanie-problemów)

---

## 📝 Notatki

- Projekt używa **PostgreSQL** (nie SQLite)
- Frontend to **czysty HTML/CSS/JavaScript** (bez frameworków)
- Backend to **ASP.NET Core Minimal API**
- Baza ma **2 tabele**: Sensors, SensorData
- API zwraca **JSON**
- Frontend auto-refresh co **30 sekund**

---

## ✨ Optymalizacje

W ostatniej wersji:
- ✅ Usunięto SQLite
- ✅ Uproszczono Program.cs (-57% kodu)
- ✅ Dodano dokumentację (570 linii)
- ✅ Oczyszczono projekt
- ✅ Production-ready

Więcej w [BEFORE_AFTER.md](./BEFORE_AFTER.md)

---

## 🤝 Wsparcie

1. **Zacznij od:** [SETUP.md](./SETUP.md)
2. **Pełna info:** [README.md](./README.md)
3. **Historia zmian:** [BEFORE_AFTER.md](./BEFORE_AFTER.md)
4. **API Docs:** http://localhost:5047/swagger

---

## 📋 Checklist przed producją

- [ ] PostgreSQL jest uruchomiony
- [ ] Connection string jest poprawny
- [ ] Migracje zastosowane (`dotnet ef database update`)
- [ ] Backend działa (`http://localhost:5047/swagger`)
- [ ] Frontend działa (`http://localhost:8000/index.html`)
- [ ] API odpowiada (`curl http://localhost:5047/api/sensors`)
- [ ] Czujniki są dodane
- [ ] Dashboard pokazuje dane

---

**Ostatnia aktualizacja:** 28 marca 2026  
**Wersja:** 1.0 Final  
**Status:** ✅ Production Ready

