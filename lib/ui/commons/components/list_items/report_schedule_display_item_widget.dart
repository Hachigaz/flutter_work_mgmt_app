import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart' show ID;
import 'package:flutter_work_mgmt_app/data/models/reports.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/presets/date_formats.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class ReportScheduleListItemWidget extends StatelessWidget {
  final ReportScheduleRecord schedule;

  void _onTapReportItem({
    required BuildContext context,
    required ID scheduleId,
  }) {
    context.push("${context.namedLocation("reports")}/$scheduleId/detail");
  }

  const ReportScheduleListItemWidget({required this.schedule});
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    // final presets = context.read<ThemeBloc>().state.presets;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 4,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            date_fmat_datemonth.format(schedule.dueDate!),
            style: typography.lg.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 15.sp,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: FTappable.animated(
            onPress: () {
              _onTapReportItem(context: context, scheduleId: schedule.id!);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: colorScheme.primary.darker(10).withAlpha(80),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Badge(
                    padding: EdgeInsets.all(0),
                    offset: Offset(-52, -6),
                    backgroundColor: Colors.white.withAlpha(0),
                    label:
                        (schedule.dueDate!.isBefore(DateTime.now()))
                            ? Row(
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: colorScheme.error,
                                  size: 20,
                                ),
                                Text(
                                  "Trễ hạn",
                                  style: typography.sm.copyWith(
                                    color: colorScheme.error,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                            : SizedBox(),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 8),
                      child: Row(
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.only(bottom: 23, right: 10),
                          //   child: Icon(
                          //     Icons.web_rounded,
                          //     color: colorScheme.foreground,
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(top: 6, right: 10),
                            child: Icon(
                              schedule.category!.icon,
                              color: colorScheme.foreground,
                            ),
                          ),
                          Text(
                            // schedule.title != null
                            //     ? "${schedule.title}"
                            //     : "Báo cáo",
                            schedule.category!.label,
                            style: typography.xl.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      schedule.title!,
                      style: typography.base,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mức độ ưu tiên: ", style: typography.base),
                        Text(
                          "Trung bình",
                          style: typography.base.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Trạng thái: ", style: typography.base),
                        Text(
                          schedule.reportId == null
                              ? "Chưa thực hiện"
                              : "Chưa gửi",
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
          ),
        ),
      ],
    );
  }
}
