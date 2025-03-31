import 'package:bloc/bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/project.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';

part "project_detail_state.dart";

class ProjectDetailBloc extends PageDetailBloc<ProjectRecord> {
  final DataRepository<WorkItemRecord> _workItemRepo;
  ProjectDetailBloc({
    required super.dataRepo,
    required DataRepository<WorkItemRecord> workItemRepo,
    required super.recordId,
  }) : _workItemRepo = workItemRepo;

  @override
  Future<void> onPageDetailEventInit(
    PageDetailEventInit<ProjectRecord> event,
    Emitter<PageDetailState<ProjectRecord>> emit,
  ) async {
    await super.onPageDetailEventInit(event, emit);

    if (this.state is! PageDetailStateRecordReady<ProjectRecord>) {
      throw Exception("Unexpected error");
    }
    final state = this.state as PageDetailStateRecordReady<ProjectRecord>;

    final activeWorkItems = _workItemRepo.search("").itemList;

    emit(
      ProjectDetailStateRecordReady(
        record: state.record,
        activeWorkItems: activeWorkItems,
      ),
    );
  }
}
