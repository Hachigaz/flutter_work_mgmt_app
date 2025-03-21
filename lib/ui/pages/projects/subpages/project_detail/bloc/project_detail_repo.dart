import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';

class ProjectDetailPageRepository {
  ProjectRecord _projectRecord;
  get projectRecord => _projectRecord;

  WorkItemRecord _activeWorkItemRecord;
  get activeWorkItemRecord => _activeWorkItemRecord;

  ProjectDetailPageRepository({required ID projectId})
    : _projectRecord = ProjectRecord(),
      _activeWorkItemRecord = WorkItemRecord() {
    //get project record from id
    _projectRecord = ProjectRecord(
      id: 2,
      name: "Project 2 DEF",
      nameShort: "Project 2",
      description: "",
      workAddress: "123 ADV Tan Binh",
      startDate: DateTime.now(),
      workItemCount: 5,
      isActive: true,
    );

    _activeWorkItemRecord = WorkItemRecord(
      id: 1,
      projectId: 1,
      name: "Work 1 ABC",
      nameShort: "Work 1",
      description: "",
      taskCount: 23,
      progression: 0.1,
      startDate: DateTime.now(),
      isCompleted: false,
      isActive: true,
    );
  }
}
