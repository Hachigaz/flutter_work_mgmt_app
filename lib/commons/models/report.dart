import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/commons/form_builder/models/models.dart';

// enum ReportSectionType {
//   numericInput(label: "Số liệu"),
//   textInput(label: "Văn bản"),
//   imageInput(label: "Hình ảnh"),
//   checkboxInput(label: "Chọn nhiều"),
//   radioInput(label: "Chọn đơn");

//   final String label;
//   const ReportSectionType({required this.label});
// }

// typedef ReportSectionInfoRecord =
//     ({
//       ID id,
//       String title,
//       ReportSectionType type,
//       int inputCount,
//     }); // xài trong template cho các báo cáo

class ReportSchedule {
  //for timestamp schedule type (1 - n)
  final ID? id;
  final ID? taskId;
  final String? title;
  final DateTime? dueDate;
  final bool? isReported;
  final ID? reportId;
  final bool? isActive;

  const ReportSchedule({
    this.id,
    this.taskId,
    this.title,
    this.dueDate,
    this.isReported,
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

// class ReportRecurringSchedule {
//   //for recurring schedule type (1 - n)
//   final ID? id;
//   final ID? reportScheduleId;

//   final String? title;
//   final RecurringType? recurringType;
//   final int? timeIndex; // daily ko có, week từ 0-6, month 0-30, quarter, year

//   final int? count;
//   final bool? isActive;

//   const ReportRecurringSchedule({
//     this.id,
//     this.reportScheduleId,
//     this.title,
//     this.recurringType,
//     this.timeIndex,
//     this.count,
//     this.isActive,
//   });
// }

class TaskReportRecord {
  final ID? id;
  final ID? scheduleId;
  final DateTime? dateCreated;
  final ID? createdBy;
  final DateTime? lastUpdated;
  final ID? lastUpdatedBy;
  final bool? isSubmitted;
  final ID? verifiedBy;
  final ReportFormData? reportData; // JSON report data
  final bool? isActive;

  const TaskReportRecord({
    this.id,
    this.scheduleId,
    this.dateCreated,
    this.createdBy,
    this.lastUpdated,
    this.lastUpdatedBy,
    this.isSubmitted,
    this.verifiedBy,
    this.reportData,
    this.isActive,
  });
}
