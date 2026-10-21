# Contributing to GeoAlarm

## Workflow
- Keep changes focused and describe user-visible behavior in the commit or pull request.
- Add or update tests when changing alarm scheduling, condition evaluation, persistence, or permission flows.
- Run `dart format .`, `flutter analyze`, and `flutter test` when the Flutter scaffold is available.
- Do not claim checks passed unless they were actually run and their results inspected.

## Safety and privacy
- Never commit API keys, tokens, Android signing credentials, personal data, or real location histories.
- Request location and notification permissions only when needed, with a plain-language explanation.
- Avoid collecting or uploading location history by default.
- Treat release builds, publishing, and destructive repository changes as approval-gated actions.
