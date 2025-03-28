part of "schedule_create_bloc.dart";

class ScheduleCreateEvent extends Equatable {
  const ScheduleCreateEvent();

  @override
  List<Object?> get props => [];
}

class ScheduleCreateEventInit extends ScheduleCreateEvent {
  final ID taskId;
  final bool isRecursive;

  const ScheduleCreateEventInit({
    required this.taskId,
    required this.isRecursive,
  });

  @override
  List<Object?> get props => [...super.props, taskId];
}

class ScheduleCreateEventSelectTemplate extends ScheduleCreateEvent {
  final ReportFormTemplateRecord templateRecord;

  const ScheduleCreateEventSelectTemplate({required this.templateRecord});

  @override
  List<Object?> get props => [...super.props, templateRecord];
}

class ScheduleCreateEventChangeScheduleType extends ScheduleCreateEvent {
  final bool isRecursive;

  const ScheduleCreateEventChangeScheduleType({required this.isRecursive});

  @override
  List<Object?> get props {
    return [...super.props, isRecursive];
  }
}

class ScheduleCreateEventSubmit extends ScheduleCreateEvent {
  final BuildContext context;

  const ScheduleCreateEventSubmit({required this.context});
}
