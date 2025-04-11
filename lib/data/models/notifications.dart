import 'package:flutter_work_mgmt_app/data/models/model.dart';

enum NotificationImportance {
  normal(label: "Bình thường"),
  important(label: "Quan trọng");

  final String label;
  const NotificationImportance({required this.label});

  Map<String, dynamic> toJson() => {"name": name};

  static NotificationImportance fromName({required String name}) {
    return NotificationImportance.values.firstWhere(
      (value) => value.name == name,
    );
  }
}

enum NotificationStatus {
  unread(label: "Chưa đọc"),
  read(label: "Đã đọc");

  final String label;
  const NotificationStatus({required this.label});

  Map<String, dynamic> toJson() => {"name": name};

  static NotificationStatus fromName({required String name}) {
    return NotificationStatus.values.firstWhere((value) => value.name == name);
  }
}

class NotificationRecord extends DataRecord {
  const NotificationRecord({
    super.id,
    this.title,
    this.message,
    this.timestamp,
    this.importance,
    this.status,
  });

  final String? title;
  final String? message;
  final DateTime? timestamp;
  final NotificationImportance? importance;
  final NotificationStatus? status;

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "message": message,
    "timestamp": timestamp,
    "importance": importance,
    "status": status,
  };

  factory NotificationRecord.fromJson(Map<String, dynamic> json) =>
      NotificationRecord(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        timestamp: json["timestamp"],
        importance: NotificationImportance.fromName(name: json["importance"]),
        status: NotificationStatus.fromName(name: json["status"]),
      );
}
