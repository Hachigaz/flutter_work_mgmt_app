part of "../task_manage.dart";

class _TaskListDisplayItem extends StatelessWidget {
  final TaskRecord _taskRecord;

  const _TaskListDisplayItem({required TaskRecord taskRecord})
    : _taskRecord = taskRecord;
  void onTapTaskItem({required BuildContext context}) {
    context.push("${context.namedLocation("tasks")}/${_taskRecord.id}/detail");
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    return GestureDetector(
      onTap: () => {onTapTaskItem(context: context)},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.background,
          border: Border(
            top: BorderSide(color: colorScheme.border, width: 1),
            bottom: BorderSide(color: colorScheme.border, width: 1),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: padding_xl,
            horizontal: padding_2xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding_md),
                child: Text(
                  "${_taskRecord.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.typography.xl.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding_sm),
                child: Text(
                  "Trạng thái: ${"Đang hoạt động"}",
                  style: typography.base,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding_sm),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Hạn báo cáo: ", style: typography.base),
                      TextSpan(
                        text:
                            _taskRecord.closestReport != null
                                ? date_fmat_date.format(DateTime.now())
                                : "",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkItemTaskListViewSection extends StatelessWidget {
  final ScrollController scrollController;

  const _WorkItemTaskListViewSection({required this.scrollController});
  @override
  Widget build(BuildContext context) {
    final taskListBloc = ListViewBloc(
      dataRepo: context.read<DataRepository<TaskRecord>>(),
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding_lg),
      child: Column(
        children: [
          SearchBarWidget<
            TaskRecord,
            ListViewStateLoading<TaskRecord>,
            ListViewEventSearchCall<TaskRecord>
          >(
            hintText: "Nhập tên công việc",
            searchCallCreator:
                (searchValue) => ListViewEventSearchCall<TaskRecord>(
                  searchValue: searchValue,
                ),
            listBloc: taskListBloc,
          ),
          ListViewWidget<TaskRecord>(
            listBuilder: (taskList) {
              return Column(
                children: [
                  for (final taskRecord in taskList)
                    _TaskListDisplayItem(taskRecord: taskRecord),
                ],
              );
            },
            scrollController: scrollController,
            listBloc: taskListBloc,
          ),
        ],
      ),
    );
    // final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    // return Padding(
    //   padding: EdgeInsets.symmetric(vertical: padding_lg),
    //   child: BlocBuilder<WorkItemDetailBloc, WorkItemDetailState>(
    //     builder: (context, workItemState) {
    //       if (workItemState is WorkItemDetailStateReady) {
    //         return BlocBuilder<TaskManageTaskListBloc, TaskManageTaskListState>(
    //           builder: (context, taskListState) {
    //             return Column(
    //               children: [
    //                 for (final task in taskListState.taskList)
    //                   _TaskListDisplayItem(taskRecord: task),
    //               ],
    //             );
    //           },
    //         );
    //       } else {
    //         return Align(
    //           alignment: Alignment.center,
    //           child: CircularProgressIndicator(color: colorScheme.primary),
    //         );
    //       }
    //     },
    //     buildWhen: (previous, current) {
    //       return previous is! WorkItemDetailStateReady;
    //     },
    //   ),
    // );
  }
}
