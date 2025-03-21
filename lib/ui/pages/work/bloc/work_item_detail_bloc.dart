import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';

part "work_item_detail_event.dart";
part "work_item_detail_state.dart";
part "mock_data.dart";

class WorkItemDetailBloc
    extends Bloc<WorkItemDetailEvent, WorkItemDetailState> {
  WorkItemDetailBloc({required ID workItemId}) : super(WorkItemDetailState()) {
    on<WorkItemDetailEventInit>(_onWorkItemDetailInit);
    add(WorkItemDetailEventInit());
  }

  Future<void> _onWorkItemDetailInit(
    WorkItemDetailEventInit event,
    Emitter<WorkItemDetailState> emit,
  ) async {
    emit(WorkItemDetailStateLoading());

    await Future.delayed(Duration(seconds: 2), () {
      emit(
        WorkItemDetailStateReady(
          workItem: _workItem,
          activeTaskRecord: _workItemList,
          completedTaskRecord: _workItemList,
        ),
      );
    });
  }
}
