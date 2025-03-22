import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/report_schedule_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/task_repository.dart';

part "task_detail_event.dart";
part "task_detail_state.dart";

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  final TaskRepository taskRepo;
  final ReportScheduleRepository scheduleRepo;

  TaskDetailBloc({
    required ID taskId,
    required this.taskRepo,
    required this.scheduleRepo,
  }) : super(TaskDetailState()) {
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

    await Future.delayed(
      Duration(seconds: 2),
      () => {
        taskRecord = taskRepo.getOne(),
        reportSchedules = scheduleRepo.search("").itemList,
      },
    );

    emit(
      TaskDetailStateReady(
        taskRecord: taskRecord,
        reportSchedules: reportSchedules,
      ),
    );
  }
}
