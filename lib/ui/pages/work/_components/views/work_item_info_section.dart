import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/_components/bloc/work_item_detail_bloc.dart';
import 'package:forui/forui.dart';

class WorkItemInfoSection extends StatelessWidget {
  const WorkItemInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        top: padding_2xl,
        left: padding_2xl,
        right: padding_2xl,
        bottom: padding_2xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thông tin chung",
            style: typography.lg.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          BlocBuilder<WorkItemDetailBloc, WorkItemDetailState>(
            builder: (context, state) {
              if (state is WorkItemDetailStateReady) {
                //data is loaded
                final workItemRecord = state.workItem;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: padding_sm,
                        left: padding_2xl,
                        right: padding_2xl,
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Tên hạng mục: ",
                              style: typography.lg.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "${workItemRecord.name}",
                              style: typography.lg.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: padding_sm,
                        left: padding_2xl,
                        right: padding_2xl,
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Mô tả: ",
                              style: typography.base.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${(workItemRecord.description!.isEmpty ? "Chưa có mô tả" : workItemRecord.description)}",
                              style: typography.lg.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
            buildWhen: (previous, current) {
              return previous is! WorkItemDetailStateReady;
            },
          ),
        ],
      ),
    );
  }
}
