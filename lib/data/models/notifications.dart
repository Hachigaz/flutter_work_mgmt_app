import 'package:flutter_work_mgmt_app/data/models/model.dart';

enum NotificationImportance {
  normal(label: "Bình thường"),
  important(label: "Quan trọng");

  final String label;
  const NotificationImportance({required this.label});
}

enum NotificationStatus {
  unread(label: "Chưa đọc"),
  read(label: "Đã đọc");

  final String label;
  const NotificationStatus({required this.label});
}

class NotificationRecord extends DataRecord {
  NotificationRecord({
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
}
