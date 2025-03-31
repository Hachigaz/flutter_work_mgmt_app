import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/models/project.dart';
import 'package:flutter_work_mgmt_app/data/models/report.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';

part "schedule_create_event.dart";
part "schedule_create_state.dart";

class ScheduleCreateBloc
    extends Bloc<ScheduleCreateEvent, ScheduleCreateState> {
  final DataRepository<TaskRecord> _taskRepo;

  ScheduleCreateBloc({
    required DataRepository<TaskRecord> taskRepo,
    required ID taskId,
    required Map<String, String> queryParams,
  }) : _taskRepo = taskRepo,
       super(ScheduleCreateState()) {
    on<ScheduleCreateEventInit>(_onInitScheduleCreate);
    on<ScheduleCreateEventChangeScheduleType>(_onChangeScheduleType);
    on<ScheduleCreateEventSelectTemplate>(_onSelectReportTemplate);
    add(
      ScheduleCreateEventInit(
        taskId: taskId,
        isRecursive: queryParams["create_opt"] == "recursive" ? true : false,
      ),
    );
  }

  Future<void> _onInitScheduleCreate(
    ScheduleCreateEventInit event,
    Emitter<ScheduleCreateState> emit,
  ) async {
    emit(ScheduleCreateStateLoading());

    final taskRecord = await Future.delayed(
      Duration(seconds: 2),
      () => _taskRepo.getOne(),
    );

    emit(
      ScheduleCreateStateReady(
        taskRecord: taskRecord,
        isRecursive: event.isRecursive,
        templateRecord: null,
      ),
    );
  }

  FutureOr<void> _onChangeScheduleType(
    ScheduleCreateEventChangeScheduleType event,
    Emitter<ScheduleCreateState> emit,
  ) {
    if (this.state is! ScheduleCreateStateReady) {
      throw Exception("Unexpected Error");
    }
    final state = this.state as ScheduleCreateStateReady;
    emit(state.copyWith(isRecursive: event.isRecursive));
  }

  FutureOr<void> _onSelectReportTemplate(
    ScheduleCreateEventSelectTemplate event,
    Emitter<ScheduleCreateState> emit,
  ) {
    if (state is! ScheduleCreateStateReady) {
      throw Exception("Unexpected Error");
    }
    emit(
      (state as ScheduleCreateStateReady).copyWith(
        templateRecord: event.templateRecord,
      ),
    );
  }
}
