part of "work_item_detail_bloc.dart";

class WorkItemDetailStateRecordReady
    extends PageDetailStateRecordReady<WorkItemRecord> {
  final List<TaskRecord> activeTaskList;
  final List<TaskRecord> expiredTaskList;

  const WorkItemDetailStateRecordReady({
    required super.record,
    required this.activeTaskList,
    required this.expiredTaskList,
  });

  @override
  List<Object?> get props => [...super.props, activeTaskList, expiredTaskList];
}
