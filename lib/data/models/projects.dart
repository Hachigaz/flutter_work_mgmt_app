import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/models/reports.dart';

class ProjectRecord extends DataRecord {
  final String? name;
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
    this.description,
    this.workAddress,
    this.activeWorkItem,
    this.workItemCount,
    this.completedWorkCount,
    this.startDate,
    this.isActive,
  });

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "workAddress": workAddress,
    "activeWorkItem": activeWorkItem,
    "workItemCount": workItemCount,
    "completedWorkCount": completedWorkCount,
    "startDate": startDate,
    "isActive": isActive,
  };

  factory ProjectRecord.fromJson(Map<String, dynamic> json) => ProjectRecord(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    workAddress: json["workAddress"],
    activeWorkItem: json["activeWorkItem"],
    workItemCount: json["workItemCount"],
    completedWorkCount: json["completedWorkCount"],
    startDate: json["startDate"],
    isActive: json["isActive"],
  );
}

class WorkItemRecord extends DataRecord {
  final ID? projectId;
  final String? name;
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

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "projectId": projectId,
    "name": name,
    "description": description,
    "activeTaskCount": activeTaskCount,
    "completedTaskCount": completedTaskCount,
    "expiredTaskCount": expiredTaskCount,
    "taskCount": taskCount,
    "progression": progression,
    "startDate": startDate,
    "isCompleted": isCompleted,
    "isActive": isActive,
  };

  factory WorkItemRecord.fromJson(Map<String, dynamic> json) => WorkItemRecord(
    id: json["id"],
    projectId: json["projectId"],
    name: json["name"],
    description: json["description"],
    activeTaskCount: json["activeTaskCount"],
    completedTaskCount: json["completedTaskCount"],
    expiredTaskCount: json["expiredTaskCount"],
    taskCount: json["taskCount"],
    progression: json["progression"],
    startDate: json["startDate"],
    isCompleted: json["isCompleted"],
    isActive: json["isActive"],
  );
}

enum TaskStatus {
  active(label: "Đang hoạt động"),
  completed(label: "Hoàn thành");

  final String label;
  const TaskStatus({required this.label});

  Map<String, dynamic> toJson() => {"name": name};

  static TaskStatus fromName(String name) {
    return TaskStatus.values.firstWhere((value) => value.name == name);
  }
}

enum TaskPriority {
  norm(label: "Bình thường"),
  low(label: "Thấp"),
  medium(label: "Trung bình"),
  high(label: "Cao");

  final String label;
  const TaskPriority({required this.label});

  Map<String, dynamic> toJson() => {"name": name};

  static TaskPriority fromName(String name) {
    return TaskPriority.values.firstWhere((value) => value.name == name);
  }
}

class TaskRecord extends DataRecord {
  final ID? workId;
  final String? name;
  final String? description;
  final TaskStatus? status;
  final TaskPriority? priority;
  // TODO: havent handle refrecord for json yet
  final RefRecord<ReportScheduleRecord>? closestReport;
  final bool? isActive;

  const TaskRecord({
    super.id,
    this.workId,
    this.name,
    this.description,
    this.status,
    this.priority,
    this.closestReport,
    this.isActive,
  });

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "workId": workId,
    "name": name,
    "description": description,
    "status": status,
    "priority": priority,
    "closestReport": closestReport,
    "isActive": isActive,
  };

  factory TaskRecord.fromJson(Map<String, dynamic> json) => TaskRecord(
    id: json["id"],
    workId: json["workId"],
    name: json["name"],
    description: json["description"],
    status: TaskStatus.fromName(json["status"]),
    priority: TaskPriority.fromName(json["priority"]),
    closestReport: json["closestReport"],
    isActive: json["isActive"],
  );
}
