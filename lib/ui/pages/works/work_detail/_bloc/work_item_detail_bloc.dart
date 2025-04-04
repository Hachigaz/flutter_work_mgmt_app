import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';

part "work_item_detail_state.dart";

class WorkItemDetailBloc extends PageDetailBloc<WorkItemRecord> {
  final DataRepository<TaskRecord> _taskRepo;
  WorkItemDetailBloc({
    required super.dataRepo,
    required DataRepository<TaskRecord> taskRepo,
    required super.recordId,
  }) : _taskRepo = taskRepo;

  @override
  Future<void> onPageDetailEventInit(
    PageDetailEventInit<WorkItemRecord> event,
    Emitter<PageDetailState<WorkItemRecord>> emit,
  ) async {
    await super.onPageDetailEventInit(event, emit);

    if (this.state is! PageDetailStateRecordReady<WorkItemRecord>) {
      throw Exception("Unexpected Error");
    }

    final state = this.state as PageDetailStateRecordReady<WorkItemRecord>;
    late final List<TaskRecord> activeTaskList;
    late final List<TaskRecord> expiredTaskList;
    await Future<void>.delayed(Duration(seconds: 1), () {
      activeTaskList = _taskRepo.search("").itemList;
      expiredTaskList = _taskRepo.search("").itemList;
    });

    emit(
      WorkItemDetailStateRecordReady(
        record: state.record,
        activeTaskList: activeTaskList,
        expiredTaskList: expiredTaskList,
      ),
    );
  }
}
