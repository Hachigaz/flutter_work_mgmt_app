import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_models/models.dart';

enum ReportScheduleCategory {
  daily(label: "Báo cáo ngày", icon: CupertinoIcons.arrow_counterclockwise),
  weekly(label: "Báo cáo tuần", icon: CupertinoIcons.arrow_counterclockwise),
  monthly(label: "Báo cáo quý", icon: CupertinoIcons.arrow_counterclockwise),
  quarterly(label: "Báo cáo năm", icon: CupertinoIcons.arrow_counterclockwise),
  yearly(label: "Báo cáo", icon: Icons.calendar_month_outlined);

  final String label;
  final IconData icon;
  const ReportScheduleCategory({required this.label, required this.icon});
}

enum ReportSchedulePriority {
  normal(label: "Bình thường"),
  low(label: "Thấp"),
  medium(label: "Trung bình"),
  high(label: "Cao");

  final String label;
  const ReportSchedulePriority({required this.label});
}

enum ReportScheduleStatus {
  not_created(label: "Chưa thực hiện"),
  not_sent(label: "Chưa gửi"),
  pending_verification(label: "Chờ duyệt"),
  verified(label: "Đã xác nhận");

  final String label;
  const ReportScheduleStatus({required this.label});
}

class ReportFormTemplateRecord extends DataRecord {
  final String formName;
  final String description;
  final String formStructureData;

  ReportFormTemplateRecord({
    required super.id,
    required this.formName,
    required this.description,
    required this.formStructureData,
  });
}

class ReportScheduleRecord extends DataRecord {
  //for timestamp schedule type (1 - n)

  final ID? taskId;
  final String? title;
  final ReportScheduleCategory? category;
  final ReportSchedulePriority? priority;
  final DateTime? dueDate;
  final ID? reportStructure;
  final ReportScheduleStatus? status;
  final ID? reportId;
  final bool? isActive;

  const ReportScheduleRecord({
    super.id,
    this.taskId,
    this.title,
    this.category,
    this.priority,
    this.dueDate,
    this.reportStructure,
    this.status,
    this.reportId,
    this.isActive,
  });
}

// enum RecurringType {
//   daily(label: "Hàng ngày"), // nên có ko
//   weekly(label: "Hàng tuần"),

//   monthly(label: "Hàng tháng"),
//   quarterly(label: "Hàng quý"),
//   yearly(label: "Hàng năm");

//   final String label;
//   const RecurringType({required this.label});
// }

// class ReportRecurringSchedule extends DataRecord{
//   //for recurring schedule type (1 - n)
//
//   final ID? reportScheduleId;

//   final String? title;
//   final RecurringType? recurringType;
//   final int? timeIndex; // daily ko có, week từ 0-6, month 0-30, quarter, year

//   final int? count;
//   final bool? isActive;

//   const ReportRecurringSchedule({
//     super.id,
//     this.reportScheduleId,
//     this.title,
//     this.recurringType,
//     this.timeIndex,
//     this.count,
//     this.isActive,
//   });
// }

class TaskReportRecord extends DataRecord {
  final ID? scheduleId;
  final DateTime? dateCreated;
  final ID? createdBy;
  final DateTime? lastUpdated;
  final ID? lastUpdatedBy;
  final bool? isSubmitted;
  final DateTime? submittedDate;
  final ID? verifiedBy;
  final ReportFormData? reportData; // JSON report data
  final bool? isActive;

  const TaskReportRecord({
    super.id,
    this.scheduleId,
    this.dateCreated,
    this.createdBy,
    this.lastUpdated,
    this.lastUpdatedBy,
    this.isSubmitted,
    this.submittedDate,
    this.verifiedBy,
    this.reportData,
    this.isActive,
  });
}
