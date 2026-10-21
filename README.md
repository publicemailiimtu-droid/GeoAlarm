# GeoAlarm

GeoAlarm is an Android-first alarm and reminder app that can trigger from **time**, **location**, or a combination of both.

> **Status:** Planning / initial scaffold. Location triggers, background execution, and alarm reliability must be validated on real Android devices before any production claim.

## Product goals

- Create time-only, location-only, and combined alarms.
- Trigger when arriving at or leaving a saved place.
- Choose a geofence radius and repeat schedule.
- Support snooze, enable/disable, and clear alarm status.
- Explain and request location, notification, and background permissions transparently.
- Keep core alarm evaluation on-device; treat cloud sync as a later optional feature.

## Planned stack

- **Flutter + Dart** for the mobile app.
- Android location/geofencing and notification integrations, selected after a platform feasibility spike.
- Local persistence for alarms and saved places.
- Automated formatting, static analysis, and unit tests in CI.

## MVP scope

1. App shell and alarm data model.
2. Create/edit/delete alarms and local persistence.
3. Time schedules and notifications.
4. Location picker and arrival/departure geofences.
5. Combined time + location conditions (explicit AND/OR setting).
6. Repeat rules, snooze, permission education, and reliability tests.

## Development

Install the Flutter SDK, then run:

```sh
flutter doctor
flutter pub get
flutter analyze
flutter test
flutter run
```

These commands become usable after the Flutter application scaffold is committed.

## Privacy and reliability

- Ask for only the permissions required by features the user enables.
- Explain background location use before requesting it.
- Do not commit API keys, signing keys, personal location data, or secrets.
- Geofence and notification behavior can vary by Android version, device vendor, battery settings, and permission state. Document limitations and test on-device.

## Project docs

- [Roadmap](docs/ROADMAP.md)
- [Contributing](CONTRIBUTING.md)
