# GeoAlarm implementation roadmap

## Phase 0 — Foundation
- [ ] Create the Flutter project scaffold and confirm the supported Flutter/Dart versions.
- [ ] Add lint rules, formatting guidance, and a basic CI workflow.
- [ ] Define alarm, schedule, location trigger, and condition models.
- [ ] Add unit tests for model validation and condition evaluation.

## Phase 1 — Time alarms
- [ ] Build the dashboard and create/edit alarm flows.
- [ ] Persist alarms locally.
- [ ] Implement one-time and repeating time schedules.
- [ ] Integrate notifications and document exact-alarm permission behavior where applicable.
- [ ] Test timezone changes, daylight-saving transitions, reboot, and missed alarms.

## Phase 2 — Location alarms
- [ ] Build a map/place selection flow.
- [ ] Support arrival and departure triggers with configurable radius.
- [ ] Evaluate foreground and background geofencing options for Android.
- [ ] Explain foreground/background location permissions and provide graceful fallbacks.
- [ ] Test permissions denied, approximate location, battery restrictions, and device reboot.

## Phase 3 — Combined conditions
- [ ] Support time AND location and time OR location.
- [ ] Prevent duplicate firing and define cooldown/re-arm behavior.
- [ ] Add snooze, pause/resume, and repeat behavior.
- [ ] Cover condition logic with unit tests.

## Phase 4 — Quality and release readiness
- [ ] Add accessibility, empty states, and clear permission recovery screens.
- [ ] Run static analysis and automated tests in CI.
- [ ] Complete a real-device test matrix across Android versions and battery modes.
- [ ] Add privacy policy and data-retention documentation before public release.
- [ ] Prepare signed release builds only after explicit release approval.

## Product decisions to keep explicit
- Android-first MVP; evaluate iOS separately because background geofencing and alarm behavior differ.
- Local-first data model; cloud accounts/sync are not MVP requirements.
- Combined trigger behavior must be selected by the user (AND/OR), never guessed.
- Never claim alarms are guaranteed when the OS or permissions can suppress delivery.
