import 'package:flutter_work_mgmt_app/commons/models/project.dart';

class ProjectRootRepository {
  final projectRecord = ProjectRecord(
    id: 2,
    name: "Project 2 DEF",
    nameShort: "Project 2",
    description: "",
    workAddress: "",
    startDate: DateTime.now(),
    workItemCount: 5,
    isActive: true,
  );
}
