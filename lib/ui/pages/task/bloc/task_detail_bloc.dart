import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';

part "task_detail_event.dart";
part "task_detail_state.dart";
part "mock_data.dart";

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  TaskDetailBloc({required ID taskId}) : super(TaskDetailState()) {
    on<TaskDetailEventInit>(_onTaskDetailInit);
    add(TaskDetailEventInit());
  }

  Future<void> _onTaskDetailInit(
    TaskDetailEventInit event,
    Emitter<TaskDetailState> emit,
  ) async {
    emit(TaskDetailStateLoading());

    TaskRecord taskRecord = TaskRecord();

    List<ReportSchedule>? reportSchedules;
    // List<ReportRecurringSchedule>? recurringSchedules;

    List<TaskReportRecord>? recentReports;

    await Future.delayed(
      Duration(seconds: 2),
      () => {
        taskRecord = _taskRecord,
        reportSchedules = _reportSchedules,
        // recurringSchedules = _recurringSchedules,
        recentReports = _recentReports,
      },
    );

    emit(
      TaskDetailStateReady(
        taskRecord: taskRecord,
        reportSchedules: reportSchedules,
        // recurringSchedules: recurringSchedules,
        recentReports: recentReports,
      ),
    );
  }
}
