import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';

part "task_manage_event.dart";
part "task_manage_state.dart";
part "mock_data.dart";

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

class TaskManageTaskListBloc
    extends Bloc<TaskManageTaskListEvent, TaskManageTaskListState> {
  TaskManageTaskListBloc()
    : super(TaskManageTaskListState(taskList: <TaskRecord>[])) {
    on<TaskManageTaskListEventSearchCall>(_onTaskListSearchCall);
    on<TaskManageTaskListEventLoadMoreCall>(_onTaskListLoadMoreCall);

    add(TaskManageTaskListEventSearchCall(searchValue: ""));
  }

  Future<void> _onTaskListSearchCall(
    TaskManageTaskListEventSearchCall event,
    Emitter<TaskManageTaskListState> emit,
  ) async {
    emit(
      TaskManageTaskListStateLoading(
        taskList: state.taskList,
        currentSearchValue: state.currentSearchValue,
      ),
    );
    final String searchValue = event.searchValue;

    //call the api and get search results
    List<TaskRecord> result = await Future.delayed(Duration(seconds: 2), () {
      return _searchTaskList
          .where((item) => item.name!.contains(searchValue))
          .toList();
    });

    emit(
      TaskManageTaskListStateReady(
        taskList: result,
        currentSearchValue: searchValue,
      ),
    );
  }

  FutureOr<void> _onTaskListLoadMoreCall(
    TaskManageTaskListEventLoadMoreCall event,
    Emitter<TaskManageTaskListState> emit,
  ) async {
    emit(
      TaskManageTaskListStateLoading(
        taskList: state.taskList,
        currentSearchValue: state.currentSearchValue,
      ),
    );

    //call the api and get search results
    List<TaskRecord> result = await Future.delayed(Duration(seconds: 2), () {
      return _addTaskList(count: 4);
    });

    state.taskList.addAll(result);

    emit(
      TaskManageTaskListStateReady(
        taskList: state.taskList,
        currentSearchValue: state.currentSearchValue,
      ),
    );
  }
}
