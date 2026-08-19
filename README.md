# dtje029 Agar.io Mod

iOS tweak for Agar.io met in-game menu en automatische IPA building via GitHub Actions.

## Features
- 🎮 In-game menu met floating button (draggable)
- ⚡ Speed Hack
- 🔍 Zoom Hack
- 🚫 No Ads
- 💪 God Mode
- 🔄 Automatische build via GitHub Actions
- 📱 Installeerbaar met ksign/esign/TrollStore

## Installation

1. Download de laatste IPA van GitHub Actions artifacts
2. Installeer met ksign, esign, of TrollStore
3. Trust het certificate indien nodig
4. Open agar.io - je ziet een blauwe "D" button
5. Tap de "D" button om het menu te openen!

## In-Game Menu

- **Floating "D" button**: Draggable naar elke positie
- **Menu features**: Toggle switches voor elke hack
- **Clean UI**: Modern design met dtje029 branding

## Building

### Prerequisites
- Theos installed
- Base agar.io IPA file

### GitHub Actions (Aanbevolen)
Push naar main branch en de IPA wordt automatisch gebuild!

### Local Build
```bash
make clean
make package
./build.sh
```

## Structure
```
.
├── Tweak.x                 # Main tweak code met menu systeem
├── Makefile                # Theos makefile
├── control                 # Package control file
├── .github/
│   └── workflows/
│       └── build.yml       # GitHub Actions workflow
└── Payload/                # IPA payload
    └── agar.io.app/        # Officiële agar.io app
```

## Credits
- dtje029 Team
- Theos
