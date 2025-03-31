import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/project.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/description_display_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/pages/tasks/_bloc/task_detail_bloc.dart';
import 'package:forui/forui.dart';

class TaskInfoSection extends StatelessWidget {
  const TaskInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    return PageListSection(
      label: Text(
        "Thông tin công việc",
        style: typography.xl2.copyWith(fontWeight: FontWeight.w600),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: padding_2xl),
        child: BlocBuilder<TaskDetailBloc, PageDetailState<TaskRecord>>(
          builder: (context, state) {
            if (state is PageDetailStateRecordReady<TaskRecord>) {
              final taskRecord = state.record;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spacing_md,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Tên công việc: ", style: typography.lg),
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
              return LoadingCircleWidget();
            }
          },
        ),
      ),
    );
  }
}

class TaskInfoDescriptionSection extends StatelessWidget {
  const TaskInfoDescriptionSection({super.key});
  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    return PageListSection(
      label: Text(
        "Mô tả",
        style: typography.xl.copyWith(fontWeight: FontWeight.w600),
      ),
      child: BlocBuilder<TaskDetailBloc, PageDetailState<TaskRecord>>(
        builder: (context, state) {
          if (state is PageDetailStateRecordReady<TaskRecord>) {
            final description = state.record.description;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: DescriptionDisplayWidget(
                description: description,
                descriptionTextStyle: typography.base,
              ),
            );
          } else {
            return LoadingCircleWidget();
          }
        },
      ),
    );
  }
}
