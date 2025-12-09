class Event {
  final int? id;
  final String type;
  final DateTime timestamp;
  final String? description;

  Event({
    this.id,
    required this.type,
    required this.timestamp,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
      'description': description,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      type: map['type'],
      timestamp: DateTime.parse(map['timestamp']),
      description: map['description'],
    );
  }

  @override
  String toString() {
    return 'Event(id: $id, type: $type, timestamp: $timestamp, description: $description)';
  }
}