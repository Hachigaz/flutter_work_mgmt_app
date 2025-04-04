import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class TaskDisplayItemCardSmall extends StatelessWidget {
  final TaskRecord taskRecord;
  final Color? itemColor;
  final Color? textColor;

  const TaskDisplayItemCardSmall({
    super.key,
    required this.taskRecord,
    this.itemColor,
    this.textColor,
  });

  void onTapTaskItem(BuildContext context) {
    context.push("${context.namedLocation("tasks")}/${taskRecord.id}/detail");
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    return GestureDetector(
      onTap: () => onTapTaskItem(context),
      child: Stack(
        children: [
          Image.asset("assets/images/task_item_background.png"),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color:
                  itemColor?.withAlpha(150) ??
                  colorScheme.primary.withAlpha(120),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.task_alt,
                                color: colorScheme.foreground,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  "Công việc",
                                  style: typography.base.copyWith(
                                    color: colorScheme.foreground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    "${taskRecord.name}\n",
                                    style: typography.xl.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                Text(
                                  "Báo cáo sắp tới:",
                                  style: typography.sm.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    taskRecord.closestReport!.record!.title!,
                                    style: typography.sm.copyWith(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (DateTime.now().toUtc().isBefore(
                                    // taskRecord.closestReport,
                                    DateTime.now(),
                                  ) &&
                                  taskRecord.status != TaskStatus.completed)
                              ? Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: colorScheme.error,
                                      size: 20,
                                    ),
                                    Text(
                                      "Trễ hạn",
                                      style: typography.base.copyWith(
                                        color: colorScheme.error,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : SizedBox(),
                          SizedBox(height: 30),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              value: 7 / 10, // 70% progress
                              strokeWidth: 4.0, // Adjust thickness
                              backgroundColor: colorScheme.foreground.withAlpha(
                                50,
                              ), // Optional background
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.foreground,
                              ), // Progress color
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "70.0%\n Hoàn thành",
                              textAlign: TextAlign.center,
                              style: typography.sm.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
