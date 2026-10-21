# GeoAlarm

GeoAlarm is an Android-first alarm and reminder app that can trigger from **time**, **location**, or a combination of both.

> **Status:** Phase 1 — Scaffold, data models, Material 3 UI, and CI foundation.

## Product goals

- Create time-only, location-only, and combined alarms.
- Trigger when arriving at or leaving a saved place.
- Choose a geofence radius and repeat schedule.
- Support snooze, enable/disable, and clear alarm status.
- Explain and request location, notification, and background permissions transparently.
- Keep core alarm evaluation on-device; treat cloud sync as a later optional feature.

## Planned stack

- **Flutter + Dart** for the mobile app.
- Android location/geofencing and notification integrations.
- Local persistence for alarms and saved places.
- Automated formatting, static analysis, and unit tests in CI.

## Development and testing

Prerequisite: Install [Flutter SDK](https://docs.flutter.dev/get-started/install) (Flutter 3.x / Dart 3.x).

Run the following exact commands to install dependencies, format code, analyze, run unit tests, and start the app:

```sh
# 1. Install dependencies
flutter pub get

# 2. Check and apply code formatting
dart format --output=none --set-exit-if-changed .
# Or to format all files in place:
# dart format .

# 3. Run static code analysis
flutter analyze

# 4. Run unit and widget tests
flutter test

# 5. Run the application
flutter run
```

## Privacy and reliability

- Ask for only the permissions required by features the user enables.
- Explain background location use before requesting it.
- Do not commit API keys, signing keys, personal location data, or secrets.
- Geofence and notification behavior can vary by Android version, device vendor, battery settings, and permission state. Document limitations and test on-device.

## Project docs

- [Roadmap](docs/ROADMAP.md)
- [Contributing](CONTRIBUTING.md)
