part of "../task_detail_page.dart";

class _TaskInfoSection extends StatelessWidget {
  const _TaskInfoSection();

  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;
    return PageListSection(
      label: Text(
        "Thông tin công việc",
        style: typography.xl2.copyWith(fontWeight: FontWeight.w600),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: padding_2xl),
        child: BlocBuilder<TaskDetailBloc, TaskDetailState>(
          builder: (context, state) {
            if (state is TaskDetailStateReady) {
              final taskRecord = state.taskRecord;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spacing_md,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Công việc: ", style: typography.lg),
                        TextSpan(
                          text: taskRecord.name,
                          style: typography.lg.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   style: typography.lg,
                  //   maxLines: 5,
                  //   overflow: TextOverflow.ellipsis,
                  //   "Mô tả: ${(taskRecord.description?.isEmpty ?? true ? "Chưa có mô tả" : taskRecord.description)}",
                  // ),
                  Text(
                    "Trạng thái: ${taskRecord.status?.label}",
                    style: typography.lg,
                  ),
                  // taskRecord.type == TaskType.timestamp
                  //     ? Text(
                  //       "Thời gian thực hiện: ${taskRecord.nameShort}",
                  //       style: typography.base,
                  //     )
                  //     : Text("Công việc định kỳ", style: typography.base),
                ],
              );
            } else {
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: colorScheme.primary),
              );
            }
          },
          buildWhen: (previous, current) {
            return previous != TaskDetailStateReady;
          },
        ),
      ),
    );
  }
}

class _TaskInfoDescriptionSection extends StatelessWidget {
  const _TaskInfoDescriptionSection();
  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;
    return PageListSection(
      label: Text(
        "Mô tả",
        style: typography.xl.copyWith(fontWeight: FontWeight.w600),
      ),
      child: BlocBuilder<TaskDetailBloc, TaskDetailState>(
        builder: (context, state) {
          if (state is TaskDetailStateReady) {
            final description = state.taskRecord.description;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: DescriptionDisplayWidget(
                description: description,
                descriptionTextStyle: typography.base,
              ),
            );
          } else {
            return Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }
        },
        buildWhen: (previous, current) {
          return previous is! TaskDetailStateReady;
        },
      ),
    );
  }
}
