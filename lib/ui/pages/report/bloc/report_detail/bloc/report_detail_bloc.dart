import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';

part "report_detail_event.dart";
part "report_detail_state.dart";

class ReportDetailBloc extends Bloc<ReportDetailEvent, ReportDetailState> {
  ReportDetailBloc({required ID schedule}) : super(ReportDetailState()) {
    on<ReportDetailEventInit>(_onReportDetailInit);
    add(ReportDetailEventInit());
  }

  Future<void> _onReportDetailInit(
    ReportDetailEventInit event,
    Emitter<ReportDetailState> emit,
  ) async {
    emit(ReportDetailStateLoading());

    await Future.delayed(Duration(seconds: 2), () => {});

    emit(ReportDetailStateReady());
  }
}
