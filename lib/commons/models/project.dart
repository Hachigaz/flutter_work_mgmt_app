import 'package:flutter_work_mgmt_app/commons/models/model.dart';

class ProjectRecord {
  final ID? id;
  final String? name;
  final String? nameShort;
  final String? description;
  final String? workAddress;
  final int? workItemCount;
  final DateTime? startDate;
  final bool? isActive;

  const ProjectRecord({
    this.id,
    this.name,
    this.nameShort,
    this.description,
    this.workAddress,
    this.workItemCount,
    this.startDate,
    this.isActive,
  });
}

class WorkItemRecord {
  final ID? id;
  final ID? projectId;
  final String? name;
  final String? nameShort;
  final String? description;
  final int? taskCount;
  final double? progression;
  final DateTime? startDate;
  final bool? isCompleted;
  final bool? isActive;

  const WorkItemRecord({
    this.id,
    this.projectId,
    this.name,
    this.nameShort,
    this.description,
    this.taskCount,
    this.progression,
    this.startDate,
    this.isCompleted,
    this.isActive,
  });
}

enum TaskStatus {
  active(label: "Đang hoạt động"),
  completed(label: "Hoàn thành");

  final String label;
  const TaskStatus({required this.label});
}

// enum TaskType {
//   recurring(label: "Định kỳ"),
//   timestamp(label: "Công việc");

//   final String label;
//   const TaskType({required this.label});
// }

class TaskRecord {
  final ID? id;
  final ID? workId;
  final String? name;
  final String? nameShort;
  final String? description;
  final TaskStatus? status;
  // final TaskType? type;
  final ID? closestReport;
  final ID? formStructureId;
  final bool? isActive;

  const TaskRecord({
    this.id,
    this.workId,
    this.name,
    this.nameShort,
    this.description,
    this.status,
    // this.type,
    this.closestReport,
    this.formStructureId,
    this.isActive,
  });
}
