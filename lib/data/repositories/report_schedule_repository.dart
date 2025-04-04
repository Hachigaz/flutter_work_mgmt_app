part of "../data_layer.dart";

class _ReportScheduleRepository extends DataRepository<ReportScheduleRecord> {
  const _ReportScheduleRepository();

  @override
  ListReturnResult<ReportScheduleRecord> search(String searchValue) {
    final itemList = _generateItems(count: 5);
    itemList.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
    return (itemList: itemList, isLast: false);
  }

  @override
  ReportScheduleRecord getOne() {
    return _generateItems(count: 1)[0];
  }

  List<ReportScheduleRecord> _generateItems({int count = 3}) {
    final List<ReportScheduleRecord> recs = [];
    for (var i = 0; i < count; i++) {
      recs.add(
        ReportScheduleRecord(
          id: 1,
          taskId: 1,
          title: _titles[Random().nextInt(_titles.length)],
          category:
              ReportScheduleCategory.values[Random().nextInt(
                ReportScheduleCategory.values.length,
              )],
          priority:
              ReportSchedulePriority.values[Random().nextInt(
                ReportSchedulePriority.values.length,
              )],
          dueDate: DateTime.now().add(Duration(days: random100() + 100)),
          status:
              ReportScheduleStatus.values[Random().nextInt(
                ReportScheduleStatus.values.length,
              )],
          reportId: (Random().nextInt(2) % 3 == 0 ? 1 : null),
          isActive: true,
        ),
      );
    }
    return recs;
  }

  static const List<String> _titles = [
    "Báo cáo tổng hợp công tác xử lý chất thải nguy hại",
    "Báo cáo bảo trì, bảo dưỡng thiết bị xử lý môi trường",
    "Báo cáo tình trạng ô nhiễm không khí tại khu vực sản xuất",
    "Báo cáo tiến độ thi công hệ thống xử lý nước thải",
    "Báo cáo tổng hợp công tác quan trắc môi trường",
    "Báo cáo công việc vận hành hệ thống xử lý nước thải",
    "Báo cáo quan trắc môi trường hàng ngày",
    "Báo cáo thu gom và xử lý rác thải sinh hoạt",
    "Báo cáo kiểm tra chất lượng nước đầu ra",
    "Báo cáo giám sát khí thải công nghiệp",
    "Báo cáo đánh giá chất lượng nước thải sau xử lý",
    "Báo cáo chi tiết lượng rác thải đã thu gom và xử lý",
    "Báo cáo tổng hợp mức tiêu thụ năng lượng và nước",
    "Báo cáo kiểm tra định kỳ hệ thống quan trắc tự động",
    "Báo cáo kết quả đo lường chỉ số môi trường",
    "Báo cáo phân tích xu hướng ô nhiễm môi trường",
    "Báo cáo kiểm tra định kỳ hệ thống lọc khí",
    "Báo cáo tổng hợp các sự cố môi trường và biện pháp khắc phục",
    "Báo cáo đánh giá tác động môi trường của dự án đang thực hiện",
    "Báo cáo kiểm tra mức độ tuân thủ các quy định pháp lý",
    "Báo cáo tổng hợp hoạt động bảo vệ môi trường của công ty",
    "Báo cáo đánh giá hiệu quả hệ thống xử lý chất thải",
    "Báo cáo kiểm kê lượng phát thải khí nhà kính",
    "Báo cáo tổng kết chiến lược quản lý môi trường",
    "Báo cáo đề xuất cải tiến công nghệ xử lý môi trường",
  ];
}
