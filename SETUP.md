# Agar.io Shark Mod - Setup Instructions

## ✅ Project Structure Created

Je project is nu klaar met de volgende structuur:

```
dtje029mod/
├── .github/
│   └── workflows/
│       └── build.yml          # GitHub Actions workflow
├── Payload/
│   └── README.md              # Instructies voor base IPA
├── Makefile                   # Theos build configuratie
├── Tweak.x                    # Je tweak code
├── control                    # Package info
├── build.sh                   # Build script
├── .gitignore                 # Git ignore
├── .theos_env                 # Theos environment
└── README.md                  # Project documentatie

## 📋 Volgende Stappen

### 1. Kopieer de Base Agar.io App

Je moet nu de base agar.io app vanuit shark kopiëren:

**PowerShell commando:**
```powershell
Copy-Item -Path "C:\Users\dtje0\Downloads\shark\_extract\Payload\agar.io.app" -Destination "C:\Users\dtje0\Desktop\dtje029mod\Payload\" -Recurse
```

### 2. Initialiseer Git Repository

```powershell
cd C:\Users\dtje0\Desktop\dtje029mod
git init
git add .
git commit -m "Initial commit - Agar.io Shark setup"
```

### 3. Push naar GitHub

```powershell
# Maak een nieuwe repo op GitHub en dan:
git remote add origin https://github.com/JOUW_USERNAME/agario-shark.git
git branch -M main
git push -u origin main
```

### 4. GitHub Actions zal automatisch:
- De dylib builden met Theos
- De dylib injecteren in de Payload
- Een IPA maken
- De IPA uploaden als artifact

### 5. Download & Installeer

1. Ga naar je GitHub repo → Actions tab
2. Download de `agario-shark-ipa` artifact
3. Installeer met ksign/esign/TrollStore

## 🔧 Lokaal Builden (optioneel)

Als je Theos lokaal hebt:
```bash
chmod +x build.sh
./build.sh
```

## ✏️ Je Tweak Aanpassen

Edit `Tweak.x` om je modificaties toe te voegen. Voorbeelden:
- Menu cheats
- Zoom aanpassingen
- Speed hacks
- Skin unlocks

## 📦 Belangrijke Bestanden

- **Tweak.x**: Hier schrijf je je tweak code
- **Makefile**: Build configuratie
- **control**: Package metadata (versie, naam, etc.)
- **.github/workflows/build.yml**: GitHub Actions CI/CD

Wil je dat ik de base app nu kopieer?
