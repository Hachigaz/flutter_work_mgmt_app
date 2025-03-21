part of "../project_detail_page.dart";

class _ProjectDetailTopInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    // final colorScheme = appThemeData.colorScheme;
    final projectDetailPageRepo = context.read<ProjectDetailPageRepository>();
    final projectRecord = projectDetailPageRepo.projectRecord;
    return PageListSection(
      label: Text(
        "Thông tin dự án",
        style: typography.base.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: padding_lg,
          horizontal: padding_md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spacing_sm,
          children: [
            Text.rich(
              style: typography.base,
              TextSpan(
                children: [
                  TextSpan(
                    text: "Tên dự án: ",
                    style: typography.base.copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: projectRecord.name,
                    style: typography.lg.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Ngày khởi công: ",
                    style: typography.base.copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: date_fmat_date.format(projectRecord.startDate),
                    style: typography.base.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectDetailBottomInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    // final colorScheme = appThemeData.colorScheme;
    final projectDetailPageRepo = context.read<ProjectDetailPageRepository>();
    final projectRecord = projectDetailPageRepo.projectRecord;
    return PageListSection(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style: typography.base.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  "Mô tả chung ",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding_md),
                  child: Text(
                    style: typography.base,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "${(projectRecord.description.isEmpty ? "Chưa có mô tả" : projectRecord.description)}",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Số hạng mục",
                  style: typography.base.copyWith(fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding_md),
                  child: Text(
                    style: typography.base,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "${projectRecord.workItemCount}",
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  style: typography.base.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  "Địa chỉ:",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding_md),
                  child: Text(
                    style: typography.base,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "${projectRecord.workAddress}",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
