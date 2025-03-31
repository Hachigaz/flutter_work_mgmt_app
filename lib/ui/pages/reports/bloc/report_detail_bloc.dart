import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/report.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';

part "report_detail_state.dart";

class ReportDetailBloc extends PageDetailBloc<ReportSchedule> {
  final DataRepository<TaskReportRecord> _taskReportRepo;

  ReportDetailBloc({
    required super.dataRepo,
    required super.recordId,
    required DataRepository<TaskReportRecord> taskReportRepo,
  }) : _taskReportRepo = taskReportRepo;

  @override
  Future<void> onPageDetailEventInit(
    PageDetailEventInit<ReportSchedule> event,
    Emitter<PageDetailState<ReportSchedule>> emit,
  ) async {
    await super.onPageDetailEventInit(event, emit);

    if (this.state is! PageDetailStateRecordReady<ReportSchedule>) {
      throw Exception("Unexpected Error");
    }
    final state = this.state as PageDetailStateRecordReady<ReportSchedule>;

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
