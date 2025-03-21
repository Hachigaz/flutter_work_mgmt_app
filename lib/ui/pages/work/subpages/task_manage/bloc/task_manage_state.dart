part of "task_manage_bloc.dart";

class TaskManageState extends Equatable {
  const TaskManageState();

  @override
  List<Object?> get props => [];
}

class TaskManageStateLoading extends TaskManageState {}

class TaskManageStateReady extends TaskManageState {}

// state(initial) -> loading -> ready -> loading -> ready...
class TaskManageTaskListState {
  final String currentSearchValue;
  final List<TaskRecord> taskList;
  final bool isLast;

  const TaskManageTaskListState({
    required this.taskList,
    this.isLast = false,
    this.currentSearchValue = "",
  });

  TaskManageTaskListState copyWith({
    List<TaskRecord>? taskList,
    bool? isLast,
    String? currentSearchValue,
  }) {
    return TaskManageTaskListState(
      taskList: taskList ?? this.taskList,
      isLast: isLast ?? this.isLast,
      currentSearchValue: currentSearchValue ?? this.currentSearchValue,
    );
  }
}

class TaskManageTaskListStateLoading extends TaskManageTaskListState {
  const TaskManageTaskListStateLoading({
    required super.taskList,
    super.isLast,
    required super.currentSearchValue,
  });
}

class TaskManageTaskListStateReady extends TaskManageTaskListState {
  const TaskManageTaskListStateReady({
    required super.taskList,
    super.isLast,
    required super.currentSearchValue,
  });
}
