class SanctionModel {
  final String id;
  final String workId;
  final String approvedBy;
  final String status;

  SanctionModel({
    required this.id,
    required this.workId,
    required this.approvedBy,
    required this.status,
  });

  factory SanctionModel.fromJson(Map<String, dynamic> json) {
    return SanctionModel(
      id: json['id'],
      workId: json['workId'],
      approvedBy: json['approvedBy'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workId': workId,
      'approvedBy': approvedBy,
      'status': status,
    };
  }

  // ✅ Added copyWith method for updating fields
  SanctionModel copyWith({
    String? id,
    String? workId,
    String? approvedBy,
    String? status,
  }) {
    return SanctionModel(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      approvedBy: approvedBy ?? this.approvedBy,
      status: status ?? this.status,
    );
  }
}
