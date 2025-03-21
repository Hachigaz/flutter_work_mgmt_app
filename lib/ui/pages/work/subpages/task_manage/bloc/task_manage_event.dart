part of "task_manage_bloc.dart";

class TaskManageEvent extends Equatable {
  const TaskManageEvent();

  @override
  List<Object?> get props => [];
}

class TaskManageEventInit extends TaskManageEvent {}

class TaskManageTaskListEvent extends Equatable {
  const TaskManageTaskListEvent();

  @override
  List<Object?> get props => [];
}

class TaskManageTaskListEventSearchCall extends TaskManageTaskListEvent {
  final String searchValue;

  const TaskManageTaskListEventSearchCall({required this.searchValue});

  @override
  List<Object?> get props => [...super.props, searchValue];
}

class TaskManageTaskListEventLoadMoreCall extends TaskManageTaskListEvent {}
