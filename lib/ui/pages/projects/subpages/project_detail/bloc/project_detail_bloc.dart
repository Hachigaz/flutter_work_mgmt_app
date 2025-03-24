import 'package:bloc/src/bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';

part "project_detail_state.dart";

class ProjectDetailBloc extends PageDetailBloc<ProjectRecord> {
  final DataRepository<WorkItemRecord> workItemRepo;
  ProjectDetailBloc({
    required super.dataRepo,
    required this.workItemRepo,
    required super.recordId,
  });

  @override
  Future<void> onPageDetailEventInit(
    PageDetailEventInit<ProjectRecord> event,
    Emitter<PageDetailState<ProjectRecord>> emit,
  ) async {
    await super.onPageDetailEventInit(event, emit);

    if (this.state is! PageDetailStateRecordReady) {
      throw Exception("Unexpected error");
    }
    final state = this.state as PageDetailStateRecordReady;

    final activeWorkItems = workItemRepo.search("").itemList;

    emit(
      ProjectDetailStateRecordReady(
        record: state.record,
        activeWorkItems: activeWorkItems,
      ),
    );
  }
}
