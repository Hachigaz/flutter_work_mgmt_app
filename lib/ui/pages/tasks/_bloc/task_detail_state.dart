part of "task_detail_bloc.dart";

class TaskDetailStateRecordReady
    extends PageDetailStateRecordReady<TaskRecord> {
  final List<ReportScheduleRecord> upcomingReportSchedule;

  const TaskDetailStateRecordReady({
    required super.record,
    required this.upcomingReportSchedule,
  });

  @override
  List<Object?> get props => [...super.props, upcomingReportSchedule];
}
