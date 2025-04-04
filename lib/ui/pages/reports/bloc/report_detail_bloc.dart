import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/reports.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';

part "report_detail_state.dart";

class ReportDetailBloc extends PageDetailBloc<ReportScheduleRecord> {
  final DataRepository<TaskReportRecord> _taskReportRepo;

  ReportDetailBloc({
    required super.dataRepo,
    required super.recordId,
    required DataRepository<TaskReportRecord> taskReportRepo,
  }) : _taskReportRepo = taskReportRepo;

  @override
  Future<void> onPageDetailEventInit(
    PageDetailEventInit<ReportScheduleRecord> event,
    Emitter<PageDetailState<ReportScheduleRecord>> emit,
  ) async {
    await super.onPageDetailEventInit(event, emit);

    if (this.state is! PageDetailStateRecordReady<ReportScheduleRecord>) {
      throw Exception("Unexpected Error");
    }
    final state =
        this.state as PageDetailStateRecordReady<ReportScheduleRecord>;

    late final TaskReportRecord reportRecord;

    await Future.delayed(Duration(seconds: 1), () {
      reportRecord = _taskReportRepo.getOne();
    });

    emit(
      ReportDetailStateRecordReady(
        record: state.record,
        reportRecord: reportRecord,
      ),
    );
  }
}
