import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../lib/services/database_service.dart';
import '../lib/models/event.dart';

// Generate mock annotations
@GenerateMocks([Database])
import 'database_service_test.mocks.dart';

void main() {
  group('DatabaseService Tests', () {
    late DatabaseService databaseService;

    setUp(() async {
      // Initialize the database service
      await DatabaseService.initialize();
      databaseService = DatabaseService();
    });

    test('should insert and retrieve an event', () async {
      final event = Event(
        type: 'ALERT',
        timestamp: DateTime.now(),
        description: 'Test alert event',
      );

      // Insert the event
      final id = await databaseService.insertEvent(event);
      expect(id, greaterThan(0));

      // Retrieve all events
      final events = await databaseService.getAllEvents();
      expect(events.length, 1);
      expect(events.first.type, 'ALERT');
      expect(events.first.description, 'Test alert event');
    });

    test('should store multiple events', () async {
      final event1 = Event(
        type: 'ALERT',
        timestamp: DateTime.now(),
        description: 'First alert',
      );

      final event2 = Event(
        type: 'INFO',
        timestamp: DateTime.now().add(const Duration(minutes: 1)),
        description: 'Second alert',
      );

      await databaseService.insertEvent(event1);
      await databaseService.insertEvent(event2);

      final events = await databaseService.getAllEvents();
      expect(events.length, 2);

      // Check that events are sorted by timestamp (newest first)
      expect(events[0].description, 'Second alert');
      expect(events[1].description, 'First alert');
    });

    test('should clear all events', () async {
      final event = Event(
        type: 'ALERT',
        timestamp: DateTime.now(),
        description: 'Test alert to be cleared',
      );

      await databaseService.insertEvent(event);
      var events = await databaseService.getAllEvents();
      expect(events.length, 1);

      await databaseService.clearAllEvents();
      events = await databaseService.getAllEvents();
      expect(events.length, 0);
    });
  });
}