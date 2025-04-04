import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:flutter_work_mgmt_app/data/models/reports.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';

part "task_detail_state.dart";

class TaskDetailBloc extends PageDetailBloc<TaskRecord> {
  final DataRepository<ReportScheduleRecord> scheduleRepo;

  TaskDetailBloc({
    required super.dataRepo,
    required super.recordId,
    required this.scheduleRepo,
  });

  @override
  Future<void> onPageDetailEventInit(
    PageDetailEventInit<TaskRecord> event,
    Emitter<PageDetailState<TaskRecord>> emit,
  ) async {
    await super.onPageDetailEventInit(event, emit);

    if (this.state is! PageDetailStateRecordReady<TaskRecord>) {
      throw Exception("Unexpected Error");
    }
    final state = this.state as PageDetailStateRecordReady<TaskRecord>;

    late final List<ReportScheduleRecord> upcomingReportSchedule;
    await Future.delayed(Duration(seconds: 1), () {
      upcomingReportSchedule = scheduleRepo.search("").itemList;
    });

    emit(
      TaskDetailStateRecordReady(
        record: state.record,
        upcomingReportSchedule: upcomingReportSchedule,
      ),
    );
  }
}
