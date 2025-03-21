part of '../work_item_detail_page.dart';

class _WorkItemInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    // final colorScheme = appThemeData.colorScheme;
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
                return renderLoadedWidget(workItemRecord: state.workItem);
              } else {
                return SizedBox();
              }
            },
            buildWhen: (previous, current) {
              return previous != WorkItemDetailStateReady;
            },
          ),
        ],
      ),
    );
  }

  Widget renderLoadedWidget({required WorkItemRecord workItemRecord}) {
    final typography = appThemeData.typography;
    // final colorScheme = appThemeData.colorScheme;

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
                  style: typography.lg.copyWith(color: Colors.white),
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
                  style: typography.base.copyWith(color: Colors.white),
                ),
                TextSpan(
                  text:
                      "${(workItemRecord.description!.isEmpty ? "Chưa có mô tả" : workItemRecord.description)}",
                  style: typography.lg.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
