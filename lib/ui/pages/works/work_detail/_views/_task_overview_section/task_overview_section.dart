import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:flutter_work_mgmt_app/providers/ui/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/swipable_list_view.dart';
import 'package:flutter_work_mgmt_app/ui/pages/works/work_detail/_bloc/work_item_detail_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import "_components/components.dart";

class WorkDetailTaskOverviewSection extends StatelessWidget {
  const WorkDetailTaskOverviewSection({super.key});

  void onClickTaskManageButton({
    required BuildContext context,
    required ID workId,
  }) {
    context.push("${context.namedLocation("works")}/$workId/task_manage");
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tổng quan công việc",
              style: typography.xl.copyWith(fontWeight: FontWeight.w600),
            ),
            BlocBuilder<WorkItemDetailBloc, PageDetailState<WorkItemRecord>>(
              builder: (context, state) {
                if (state is PageDetailStateRecordReady<WorkItemRecord>) {
                  return OutlinedButton(
                    onPressed: () {
                      onClickTaskManageButton(
                        context: context,
                        workId: state.record.id!,
                      );
                    },
                    style: presets.button_style_default_rounded.copyWith(
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: Text("Chi tiết"),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
        TaskOverviewStatisticSection(),
        PageListSection(
          labelText: "Công việc hôm nay",
          child:
              BlocBuilder<WorkItemDetailBloc, PageDetailState<WorkItemRecord>>(
                builder: (context, state) {
                  if (state is WorkItemDetailStateRecordReady) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 140.h),
                      child: SwipableListView(
                        viewportFraction: 0.95,
                        children: [
                          for (final record in state.activeTaskList)
                            TaskDisplayItemCardSmall(taskRecord: record),
                        ],
                      ),
                    );
                  } else {
                    return LoadingCircleWidget(
                      circleColor: colorScheme.primary,
                    );
                  }
                },
              ),
        ),
        const SizedBox(height: 30),
        PageListSection(
          labelText: "Công việc trễ hạn",
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 140.h),
            child: BlocBuilder<
              WorkItemDetailBloc,
              PageDetailState<WorkItemRecord>
            >(
              builder: (context, state) {
                if (state is WorkItemDetailStateRecordReady) {
                  return SwipableListView(
                    viewportFraction: 0.95,
                    children: [
                      for (final record in state.expiredTaskList)
                        TaskDisplayItemCardSmall(
                          taskRecord: record,
                          itemColor: const Color.fromARGB(183, 255, 166, 0),
                        ),
                    ],
                  );
                } else {
                  return LoadingCircleWidget(circleColor: colorScheme.primary);
                }
              },
            ),
          ),
        ),
        // _ActiveTaskListSection(),
        // _CompletedTaskListSection(),
      ],
    );
  }
}
