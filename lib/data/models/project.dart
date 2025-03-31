import 'package:flutter_work_mgmt_app/data/models/model.dart';

class ProjectRecord extends DataRecord {
  final String? name;
  final String? nameShort;
  final String? description;
  final String? workAddress;
  final ID? activeWorkItem;
  final int? workItemCount;
  final int? completedWorkCount;
  final DateTime? startDate;
  final bool? isActive;

  const ProjectRecord({
    super.id,
    this.name,
    this.nameShort,
    this.description,
    this.workAddress,
    this.activeWorkItem,
    this.workItemCount,
    this.completedWorkCount,
    this.startDate,
    this.isActive,
  });
}

class WorkItemRecord extends DataRecord {
  final ID? projectId;
  final String? name;
  final String? nameShort;
  final String? description;
  final int? activeTaskCount;
  final int? completedTaskCount;
  final int? expiredTaskCount;
  final int? taskCount;
  final double? progression;
  final DateTime? startDate;
  final bool? isCompleted;
  final bool? isActive;

  const WorkItemRecord({
    super.id,
    this.projectId,
    this.name,
    this.nameShort,
    this.description,
    this.activeTaskCount,
    this.completedTaskCount,
    this.expiredTaskCount,
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

class TaskRecord extends DataRecord {
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
    super.id,
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
