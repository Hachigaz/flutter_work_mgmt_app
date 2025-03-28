part of "schedule_create_bloc.dart";

class ScheduleCreateState extends Equatable {
  const ScheduleCreateState();

  @override
  List<Object?> get props => [];
}

class ScheduleCreateStateLoading extends ScheduleCreateState {
  const ScheduleCreateStateLoading();
}

class ScheduleCreateStateReady extends ScheduleCreateState {
  final TaskRecord taskRecord;
  final bool isRecursive;
  final ReportFormTemplateRecord? templateRecord;

  const ScheduleCreateStateReady({
    required this.taskRecord,
    required this.isRecursive,
    required this.templateRecord,
  });

  ScheduleCreateStateReady copyWith({
    TaskRecord? taskRecord,
    ReportFormTemplateRecord? templateRecord,
    bool? isRecursive,
  }) {
    return ScheduleCreateStateReady(
      taskRecord: taskRecord ?? this.taskRecord,
      isRecursive: isRecursive ?? this.isRecursive,
      templateRecord: templateRecord ?? this.templateRecord,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    taskRecord,
    templateRecord,
    isRecursive,
  ];
}
