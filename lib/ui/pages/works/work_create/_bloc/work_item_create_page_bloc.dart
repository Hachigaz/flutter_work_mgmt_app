import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';

part "work_item_create_page_event.dart";
part "work_item_create_page_state.dart";

class WorkItemCreatePageBloc
    extends Bloc<WorkItemCreatePageEvent, WorkItemCreatePageState> {
  WorkItemCreatePageBloc() : super(WorkItemCreatePageState());
}
