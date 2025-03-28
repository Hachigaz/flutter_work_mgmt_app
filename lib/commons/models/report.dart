import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_models/models.dart';

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

class ReportSchedule extends DataRecord {
  //for timestamp schedule type (1 - n)

  final ID? taskId;
  final String? title;
  final DateTime? dueDate;
  final ID? reportStructure;
  final bool? isReported;
  final ID? reportId;
  final bool? isActive;

  const ReportSchedule({
    super.id,
    this.taskId,
    this.title,
    this.dueDate,
    this.reportStructure,
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
