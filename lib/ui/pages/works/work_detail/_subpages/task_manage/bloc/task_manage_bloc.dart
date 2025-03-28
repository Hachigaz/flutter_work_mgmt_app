import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "task_manage_event.dart";
part "task_manage_state.dart";

class TaskManageBloc extends Bloc<TaskManageEvent, TaskManageState> {
  TaskManageBloc() : super(TaskManageState()) {
    on<TaskManageEventInit>(_onTaskManageInit);
    add(TaskManageEventInit());
  }

  FutureOr<void> _onTaskManageInit(
    TaskManageEventInit event,
    Emitter<TaskManageState> emit,
  ) async {
    emit(TaskManageStateLoading());

    emit(TaskManageStateReady());
  }
}
