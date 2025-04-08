class LogEntity {
  final String id;
  final String action;
  final String performedBy;
  final DateTime timestamp;

  LogEntity({
    required this.id,
    required this.action,
    required this.performedBy,
    required this.timestamp,
  });
}
