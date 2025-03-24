part of "task_detail_bloc.dart";

class TaskDetailState extends Equatable {
  const TaskDetailState();

  @override
  List<Object?> get props => [];
}

class TaskDetailStateLoading extends TaskDetailState {}

class TaskDetailStateReady extends TaskDetailState {
  final TaskRecord taskRecord;
  final List<ReportSchedule>? reportSchedules;
  // final List<ReportRecurringSchedule>? recurringSchedules;

  const TaskDetailStateReady({
    required this.taskRecord,
    this.reportSchedules,
    // this.recurringSchedules,
  });
}
