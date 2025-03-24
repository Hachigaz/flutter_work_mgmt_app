part of "project_detail_bloc.dart";

class ProjectDetailStateRecordReady
    extends PageDetailStateRecordReady<ProjectRecord> {
  final List<WorkItemRecord> activeWorkItems;

  const ProjectDetailStateRecordReady({
    required super.record,
    required this.activeWorkItems,
  });
}
