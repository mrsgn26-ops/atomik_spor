# atomik_spor

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

## Tooling requirements

This codebase targets Flutter 3.13 or newer and Dart 3.2 or newer (see
`pubspec.lock` for the exact constraints). Make sure the matching Flutter SDK is
installed and on your `PATH` before trying to build or run the app.

## Setup

1. Fetch all dependencies:

   ```bash
   flutter pub get
   ```

2. Regenerate the localization files whenever you pull new translations or
   modify the ARB files in `lib/l10n/`:

   ```bash
   flutter gen-l10n
   ```

   Flutter removed the legacy `synthetic-package` option, so the generated
   `AppLocalizations` class now lives directly under `lib/l10n/`. The imports in
   the source code already point at this location.

3. Launch the application on the desired device or emulator:

   ```bash
   flutter run
   ```

## Additional resources

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter localization guide](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)

For broader Flutter guidance, refer to the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, mobile development guidance, and a full API reference.
