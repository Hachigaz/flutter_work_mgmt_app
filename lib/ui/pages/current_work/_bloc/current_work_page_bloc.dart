import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/reports.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:forui/forui.dart';

part "current_work_page_event.dart";
part "current_work_page_state.dart";

class CurrentWorkPageBloc
    extends Bloc<CurrentWorkPageEvent, CurrentWorkPageState> {
  final ListViewBloc<ReportScheduleRecord> listViewBloc;
  final FCalendarController calendarController;

  CurrentWorkPageBloc({
    required DataRepository<ReportScheduleRecord> scheduleRepo,
  }) : listViewBloc = ListViewBloc<ReportScheduleRecord>(
         dataRepo: scheduleRepo,
       ),
       calendarController = FCalendarController.date(
         initialSelection: DateTime.now(),
       ),
       super(CurrentWorkPageState(selectedDate: DateTime.now())) {
    on<CurrentWorkPageEventChangeWeekday>(_onChangeWeekday);
    on<CurrentWorkPageEventChangeCalendar>(_onChangeCalendar);
  }

  FutureOr<void> _onChangeWeekday(
    CurrentWorkPageEventChangeWeekday event,
    Emitter<CurrentWorkPageState> emit,
  ) {
    emit(state.copyWith(selectedDate: event.selectedDate));
    listViewBloc.add(
      ListViewEventSearchCall<ReportScheduleRecord>(searchValue: ""),
    );
  }

  FutureOr<void> _onChangeCalendar(
    CurrentWorkPageEventChangeCalendar event,
    Emitter<CurrentWorkPageState> emit,
  ) {
    emit(state.copyWith(selectedDate: event.selectedDate));
    listViewBloc.add(
      ListViewEventSearchCall<ReportScheduleRecord>(searchValue: ""),
    );
  }
}
