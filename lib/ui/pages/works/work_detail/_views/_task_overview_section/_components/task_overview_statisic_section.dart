import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/data/models/project.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/works/work_detail/_bloc/work_item_detail_bloc.dart';
import 'package:forui/forui.dart';

class TaskOverviewStatisticSection extends StatelessWidget {
  const TaskOverviewStatisticSection({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    const double animationMaxVal = 1000;
    return BlocBuilder<WorkItemDetailBloc, PageDetailState<WorkItemRecord>>(
      builder: (context, state) {
        if (state is PageDetailStateRecordReady<WorkItemRecord>) {
          final record = state.record;
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: animationMaxVal),
            curve: Curves.easeInOutExpo,
            duration: Duration(milliseconds: 1000),
            builder: (context, angle, child) {
              final animationOffset = angle / animationMaxVal;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tổng công việc:",
                              style: typography.base.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(record.taskCount! * animationOffset).toInt()}",
                              style: typography.base.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Đang thực hiện:",
                                style: typography.base.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${(record.activeTaskCount! * animationOffset).toInt()}",
                                style: typography.base.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hoàn thành:",
                                style: typography.base.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${(record.completedTaskCount! * animationOffset).toInt()}",
                                style: typography.base.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Trễ hạn:",
                                style: typography.base.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${(record.expiredTaskCount! * animationOffset).toInt()}",
                                style: typography.base.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150.r,
                          height: 150.r,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value:
                                      record.activeTaskCount! * animationOffset,
                                  color: Colors.blue,
                                  radius: 25.r,
                                  showTitle: false,
                                ),
                                PieChartSectionData(
                                  value:
                                      record.completedTaskCount! *
                                      animationOffset,
                                  color: const Color.fromARGB(
                                    255,
                                    101,
                                    254,
                                    111,
                                  ),
                                  radius: 25.r,
                                  showTitle: false,
                                ),
                                PieChartSectionData(
                                  value: record.expiredTaskCount!.toDouble(),
                                  color: const Color.fromARGB(255, 254, 86, 86),
                                  radius: 25.r * animationOffset,
                                  showTitle: false,
                                ),
                              ],
                              sectionsSpace: 0,
                              centerSpaceRadius: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return LoadingCircleWidget();
        }
      },
    );
  }
}
