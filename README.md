# DevilFruitCollector

DevilFruitCollector is a simple iOS app for tracking and collecting Devil Fruits from the One Piece universe. It uses a SwiftUI interface and Core Data for persistent storage.

## Features
- Devil fruit list
- Add new fruit
- Edit on the detail screen
- Delete from the list
- Awakened status
- Danger level slider (1.0–5.0)
- First appearance date and notes

## Tech Stack
- SwiftUI
- Core Data
- iOS 18.1 target

## Data Model (Core Data)
The `DevilFruit` entity includes:
- `id` (UUID)
- `name` (String)
- `type` (String)
- `powerDescription` (String)
- `isAwakened` (Bool)
- `dangerLevel` (Double)
- `firstAppearance` (Date)
- `notes` (String)

## Setup and Run
1. Open the project in Xcode: `DevilFruitCollector.xcodeproj`
2. Select an iOS simulator or a physical device.
3. Build & Run.

## Quick Usage
- The `+` button adds a new fruit.
- Swipe left on a list item to delete.
- Tap a fruit to edit in the detail screen and press `Save`.