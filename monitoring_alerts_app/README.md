# Monitoring Alerts App

A Flutter application for monitoring and alert notifications with critical mode capabilities.

## Features

- **Dashboard Screen**: Shows system status and allows triggering alerts
- **Preferences Screen**: Configure notification settings and critical mode
- **History Screen**: View all triggered events with timestamps
- **Local Notifications**: Native notifications that work in background
- **Critical Mode**: Bypasses silent mode and Do Not Disturb
- **Local Persistence**: SQLite for events, SharedPreferences for preferences
- **API Integration**: Integration with public API (JSONPlaceholder)
- **State Management**: Provider pattern for state management
- **Unit Tests**: Comprehensive test coverage

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── event.dart           # Event model
│   └── preferences.dart     # Preferences model
├── services/
│   ├── notification_service.dart  # Local notifications
│   ├── preferences_service.dart   # Preferences management
│   ├── database_service.dart      # Local database operations
│   └── api_service.dart           # API integration
├── screens/
│   ├── dashboard_screen.dart     # Main dashboard
│   ├── preferences_screen.dart   # Settings screen
│   └── history_screen.dart       # Event history
└── widgets/
    └── status_card.dart          # Reusable UI component
```

## Dependencies

- `flutter_local_notifications`: For local notifications
- `provider`: For state management
- `shared_preferences`: For preferences persistence
- `sqflite`: For local database
- `http`: For API integration
- `permission_handler`: For notification permissions

## How to Run

1. Make sure you have Flutter installed
2. Clone the repository
3. Run `flutter pub get`
4. Run `flutter run`

## Key Functionality

### Dashboard Screen
- Toggle system activation
- Simulate alerts with the panic button
- View API integration results
- Quick access to notification preferences

### Preferences Screen
- Enable/disable vibration, sound, and banner notifications
- Toggle critical mode for silent mode bypass
- Settings are persisted using SharedPreferences

### History Screen
- Lists all triggered events
- Shows event type, description, and timestamp
- Data persisted in SQLite database

### Notifications
- Local notifications that work in background
- Critical notifications that bypass silent mode
- Proper permissions handling

### API Integration
- Fetches user data from JSONPlaceholder API
- Displays API results on dashboard
- Error handling for network requests

## Testing

The project includes unit tests for:
- Preferences service
- Database service
- Event model

Run tests with:
```bash
flutter test
```

## Platform Support

This app is designed for both Android and iOS platforms with native notification support.

## Architecture

The app follows a clean architecture pattern with:
- Models for data representation
- Services for business logic
- Screens for UI
- State management using Provider
- Proper separation of concerns