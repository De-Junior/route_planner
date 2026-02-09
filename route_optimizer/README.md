# Route Optimizer (Flutter)

A simple Flutter application that allows a user to create and manage a route with multiple stops, apply validation to user input, and reorder stops using a deterministic optimization rule.

This project was built as a take-home exercise to demonstrate clean architecture, basic state management, validation, sorting logic, and unit testing in Flutter.

---

## Features

- View a route with a list of stops
- Add new stops with validation
- Delete individual stops
- Optimize stop order based on latitude and longitude
- Edit the route name
- Fully tested business logic (no UI tests required)

---

## Tech Stack

- **Flutter**
- **Dart**
- **Provider** (ChangeNotifier)
- **flutter_test** for unit testing

---

## Project Structure

lib/
 ├─ models/
 │   ├─ stop.dart
 │   └─ route_plan.dart
 │
 ├─ state/
 │   └─ route_plan_notifier.dart
 │
 ├─ screens/
 │   ├─ route_screen.dart
 │   └─ add_stop_screen.dart
 │
 │
 └─ main.dart

 ---

## Architecture
Input validation (non-empty name, latitude/longitude ranges) and stop optimization logic live in
`RoutePlanNotifier` (`lib/state/route_plan_notifier.dart`). The UI screens in `lib/screens/` only
collect user input, call notifier methods (`addStop`, `deleteStop`, `optimizeStops`), and render
the current `RoutePlan` state.

---

## Running the app
```bash
flutter pub get
flutter run

  Running tests
flutter test
