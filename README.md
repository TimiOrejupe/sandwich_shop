# sandwich_shop

A simple Flutter app that demonstrates a small sandwich-order UI: choose bread, select sandwich size (Footlong / Six-inch), adjust quantity, add notes, and see an order summary. This project is intended as a learning/example app and a starting point for expansion.

## Features
- Select sandwich size (Footlong / Six-inch) via checkboxes
- Choose bread type (White / Wheat / Wholemeal) using a dropdown
- Increment / decrement quantity with Add / Remove buttons (buttons visually disabled at min/max)
- Notes entry via a text field
- Order summary rendered by `OrderItemDisplay`
- Small, testable widget surface for learning widget testing

## Prerequisites
- Flutter SDK (stable channel) installed and on your PATH
- Git (to clone the repo)
- Recommended: a modern browser for web target (Edge / Chrome) or a device/emulator

## Installation & Setup (Windows / PowerShell)
1. Clone the repository:
   git clone https://github.com/TimiOrejupe/sandwich_shop
   cd sandwich_shop

2. Fetch packages:
   flutter pub get

3. Run static analysis:
   flutter analyze

4. Run tests:
   flutter test
   (Note: some tests in `test/` may be placeholders and can fail until the widgets are fully implemented.)

## Running the App
- Run on Edge (web):
  flutter run -d edge

- Run on Chrome (web):
  flutter run -d chrome

## Usage
- On launch the home screen shows the order UI.
- Toggle between "Footlong" and "Six-inch" using the checkboxes (only one is active at a time).
- Change bread type from the dropdown.
- Use Add / Remove buttons to change the quantity. Buttons become disabled when the quantity is at 0 or at the configured `maxQuantity`.
- Enter optional order notes in the text field.
- The order summary updates to reflect your selections.

Tip: `maxQuantity` is passed to `OrderScreen` in `main.dart` (e.g. `OrderScreen(maxQuantity: 5)`) — change this to change the limit.

## Project structure (key files)
- lib/
  - main.dart — main app, `App`, `OrderScreen`, state, widgets such as `StyledButton` and `OrderItemDisplay`
  - views/app_styles.dart — visual styles used by the app
  - repositories/order_repository.dart — simple order state/logic (quantity limits, increment/decrement)
- test/
  - views/widget_test.dart — widget tests (may contain placeholder tests that need fixing)
- README.md — this file

## Technologies used
- Flutter (Dart)
- Material widgets
- Flutter test framework for widget tests

## Known issues / Limitations
- Some tests in `test/views/widget_test.dart` include placeholder or malformed test code and may fail — review and fix assertions and async usage.
- Parts of `lib/main.dart` may contain TODO/placeholder implementations or commented fragments depending on local edits; run `flutter analyze` to surface remaining issues.
- When running on web, service-worker caching (from previous builds) can cause stale assets; use `flutter clean` and reload the page or use an incognito window.
- The app is sample-level and not production hardened (no persistence, no backend integration, no input validation beyond basic guards).

## Contributing
- Fix bugs, improve UI, add tests.
- Make a branch, open a PR, and include a clear description and screenshots (if relevant).
- Run `flutter analyze` and `flutter test` before submitting.

## Contact 
- Timi Orejupe
- Email: Timiorejupe9@gmail.com

