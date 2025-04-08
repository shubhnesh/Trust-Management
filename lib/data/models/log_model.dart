class LogModel {
  final String id;
  final String action;
  final String performedBy;
  final DateTime timestamp;

  LogModel({
    required this.id,
    required this.action,
    required this.performedBy,
    required this.timestamp,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      id: json['id'],
      action: json['action'],
      performedBy: json['performedBy'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'action': action,
      'performedBy': performedBy,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
