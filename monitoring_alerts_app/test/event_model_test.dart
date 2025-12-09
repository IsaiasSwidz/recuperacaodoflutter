import 'package:flutter_test/flutter_test.dart';
import '../lib/models/event.dart';

void main() {
  group('Event Model Tests', () {
    test('should create an event with all parameters', () {
      final now = DateTime.now();
      final event = Event(
        id: 1,
        type: 'ALERT',
        timestamp: now,
        description: 'Test event',
      );

      expect(event.id, 1);
      expect(event.type, 'ALERT');
      expect(event.timestamp, now);
      expect(event.description, 'Test event');
    });

    test('should create an event with only required parameters', () {
      final now = DateTime.now();
      final event = Event(
        type: 'INFO',
        timestamp: now,
      );

      expect(event.id, null);
      expect(event.type, 'INFO');
      expect(event.timestamp, now);
      expect(event.description, null);
    });

    test('should convert event to map and back', () {
      final now = DateTime.now();
      final originalEvent = Event(
        id: 1,
        type: 'WARNING',
        timestamp: now,
        description: 'Converted event test',
      );

      // Convert to map
      final map = originalEvent.toMap();
      expect(map['id'], 1);
      expect(map['type'], 'WARNING');
      expect(map['timestamp'], now.toIso8601String());
      expect(map['description'], 'Converted event test');

      // Convert back from map
      final newEvent = Event.fromMap(map);
      expect(newEvent.id, 1);
      expect(newEvent.type, 'WARNING');
      expect(newEvent.timestamp, now);
      expect(newEvent.description, 'Converted event test');
    });

    test('should handle different event types', () {
      final alertEvent = Event(
        type: 'ALERT',
        timestamp: DateTime.now(),
      );
      final infoEvent = Event(
        type: 'INFO',
        timestamp: DateTime.now(),
      );
      final warningEvent = Event(
        type: 'WARNING',
        timestamp: DateTime.now(),
      );

      expect(alertEvent.type, 'ALERT');
      expect(infoEvent.type, 'INFO');
      expect(warningEvent.type, 'WARNING');
    });

    test('should have correct string representation', () {
      final event = Event(
        id: 5,
        type: 'TEST',
        timestamp: DateTime(2023, 1, 1, 12, 0),
        description: 'Test description',
      );

      final expectedString = 'Event(id: 5, type: TEST, timestamp: 2023-01-01 12:00:00.000, description: Test description)';
      expect(event.toString(), expectedString);
    });
  });
}