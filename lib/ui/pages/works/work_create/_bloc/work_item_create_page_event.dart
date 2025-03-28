part of "work_item_create_page_bloc.dart";

class WorkItemCreatePageEvent {
  const WorkItemCreatePageEvent();
}

class WorkItemCreatePageEventInit extends WorkItemCreatePageEvent {
  final ID projectID;

  const WorkItemCreatePageEventInit({required this.projectID});
}
