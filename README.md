# Owl Parking

A Flutter app for Kennesaw State University that lets students and staff check real-time parking availability across campus lots and decks.

## Features

- **Home screen** — KSU-branded dashboard with live traffic alerts (road closures, congestion, special event notices, shuttle info)
- **Parking screen** — scrollable list of all 17 campus lots with occupancy bars and availability badges
  - Search by lot name or address
  - Filter by All / Available / Full
  - Lots sorted by compass direction (North → East → South → West → Other)
- **Lot detail view** — per-lot breakdown of every individual space (green = free, red = taken)
  - Multi-floor decks show a tab per floor (e.g. West Parking Deck: Floors 1–4)
  - Summary stats: available, occupied, and total spaces

## Project structure

```
lib/
├── main.dart                   # App entry point, theme, bottom-nav shell
├── data/
│   └── mock_data.dart          # Static seed data for all 17 lots
├── models/
│   ├── parking_lot.dart        # ParkingLot (supports flat or multi-floor layout)
│   ├── parking_floor.dart      # ParkingFloor (label + spaces)
│   └── parking_space.dart      # ParkingSpace (id + isOccupied)
├── screens/
│   ├── home_screen.dart        # Home tab with hero card and alert feed
│   ├── lots_list_screen.dart   # Parking tab with search, filter, and lot list
│   └── lot_detail_screen.dart  # Per-lot space grid (tabbed for multi-floor)
└── widgets/
    ├── lot_card.dart           # Card with name, address, occupancy bar, badge
    ├── availability_badge.dart # Pill badge: "X free" or "FULL"
    └── space_grid.dart         # 5-column grid of individual space tiles
```

## Campus lots included

| ID | Name | Spaces |
|----|------|--------|
| 1–2 | Central Parking 1 & 2 | 150 each |
| 3 | Lot Y | 50 |
| 4 | Visitor Parking | 50 |
| 5–6 | East Parking Lot 1 & 2 | 150 each |
| 7 | East Residence Lot | 50 |
| 8 | East Economy | 150 |
| 9–10 | Lot D & Lot E | 50 each |
| 11 | West Parking Lot | 150 |
| 12–14 | Lot H, F & G | 50 each |
| 15 | West Residence Lot | 150 |
| 16 | Shuttle Lot | 150 |
| 17 | West Parking Deck | 200 × 4 floors |

## Viewing the app (no coding required)

Follow these steps to run the app in your browser using Appetize.io:

1. **Create a free account** at [appetize.io](https://appetize.io) and sign in
2. Click **"Upload"** on the dashboard
3. Upload the file `app-debug.apk` (located in `build/app/outputs/flutter-apk/`)
4. When prompted to choose a device, select **Pixel 8**
5. Click **"Tap to Play"** — the app will launch in your browser within a few seconds

No phone or installation needed. The app runs entirely in your browser window.

---

## Getting started (for developers)

**Prerequisites:** Flutter SDK ≥ 3.0.0

```bash
flutter pub get
flutter run
```

Supports Android and iOS. The KSU owl logo asset (`assets/images/Kennesaw_State_Owls_logo.svg.png`) is required for the app bar; if missing, a fallback school icon is shown.

## Tech stack

- Flutter / Dart — UI and logic
- Material 3 with a dark KSU theme (black + `#FFFF00` gold)
- No external state-management package — plain `setState` throughout
- Mock data only (no live backend yet)