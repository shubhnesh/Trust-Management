class WorkModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String assignedTo;

  WorkModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.assignedTo,
  });

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      assignedTo: json['assignedTo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'assignedTo': assignedTo,
    };
  }

  // ✅ Added copyWith method
  WorkModel copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    String? assignedTo,
  }) {
    return WorkModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      assignedTo: assignedTo ?? this.assignedTo,
    );
  }
}
