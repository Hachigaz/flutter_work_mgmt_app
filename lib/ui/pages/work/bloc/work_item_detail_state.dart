part of "work_item_detail_bloc.dart";

class WorkItemDetailState extends Equatable {
  const WorkItemDetailState();

  @override
  List<Object?> get props => [];
}

class WorkItemDetailStateLoading extends WorkItemDetailState {}

class WorkItemDetailStateReady extends WorkItemDetailState {
  final WorkItemRecord workItem;
  final List<TaskRecord> activeTaskRecord;
  final List<TaskRecord> completedTaskRecord;

  const WorkItemDetailStateReady({
    required this.workItem,
    required this.activeTaskRecord,
    required this.completedTaskRecord,
  });
}
