part of "../data_layer.dart";

class _TaskRepository extends DataRepository<TaskRecord> {
  final _ReportScheduleRepository _reportRepo;

  const _TaskRepository({required _ReportScheduleRepository reportRepo})
    : _reportRepo = reportRepo;

  @override
  ListReturnResult<TaskRecord> search(String searchValue) {
    return (itemList: _generateItems(count: 5), isLast: false);
  }

  @override
  TaskRecord getOne() {
    return _generateItems(count: 1)[0];
  }

  List<TaskRecord> _generateItems({int count = 3}) {
    final List<TaskRecord> recs = [];
    for (var i = 0; i < count; i++) {
      recs.add(
        TaskRecord(
          id: 1,
          workId: 1,
          name: _names[Random().nextInt(_names.length)],
          description: _descriptions[Random().nextInt(_descriptions.length)],
          closestReport: RefRecord<ReportScheduleRecord>(
            refId: 1,
            record: _reportRepo.getOne(),
          ),
          status: TaskStatus.values[Random().nextInt(TaskStatus.values.length)],
          priority:
              TaskPriority.values[Random().nextInt(TaskPriority.values.length)],
          isActive: true,
        ),
      );
    }
    return recs;
  }
}

final List<String> _names = <String>[
  "Kiểm tra và giám sát chất lượng nước thải",
  "Vận hành và bảo trì hệ thống xử lý nước thải",
  "Quản lý và thu gom rác thải sinh hoạt và công nghiệp",
  "Quan trắc môi trường không khí và tiếng ồn",
  "Kiểm tra và giám sát xử lý chất thải nguy hại",
  "Tư vấn và thực hiện giải pháp tiết kiệm năng lượng",
  "Lập báo cáo đánh giá tác động môi trường (ĐTM)",
  "Triển khai chương trình trồng cây xanh và bảo vệ cảnh quan",
  "Kiểm tra và xử lý sự cố ô nhiễm môi trường",
  "Nâng cao nhận thức về bảo vệ môi trường",
  "Kiểm tra và quản lý chất lượng không khí trong nhà máy",
  "Kiểm tra và bảo trì hệ thống cấp thoát nước",
  "Hướng dẫn doanh nghiệp thực hiện quy định môi trường",
  "Giám sát và quản lý dự án môi trường",
  "Thực hiện các giải pháp tái chế chất thải",
  "Giám sát an toàn lao động trong lĩnh vực môi trường",
  "Kiểm tra và quản lý tài nguyên nước",
  "Triển khai mô hình năng lượng sạch trong sản xuất",
  "Kiểm tra và kiểm soát phát thải khí nhà kính",
  "Ứng dụng công nghệ số vào quản lý môi trường",
];

final List<String> _descriptions = <String>[
  "Lấy mẫu nước thải tại các điểm xả thải, phân tích các chỉ tiêu hóa lý, sinh học để đảm bảo đạt tiêu chuẩn môi trường. Báo cáo kết quả kiểm tra và đề xuất các biện pháp xử lý nếu có dấu hiệu ô nhiễm.",
  "Theo dõi hoạt động của các bể xử lý, kiểm tra hệ thống bơm, máy thổi khí và các thiết bị liên quan. Thực hiện bảo trì định kỳ để đảm bảo hệ thống vận hành ổn định và hiệu quả.",
  "Lập kế hoạch thu gom, phân loại và vận chuyển rác thải đến khu xử lý. Kiểm tra việc thực hiện đúng quy trình và đảm bảo an toàn vệ sinh môi trường trong quá trình thu gom.",
  "Lắp đặt và vận hành các thiết bị đo nồng độ bụi, khí thải, độ ồn tại các khu vực cần giám sát. Tổng hợp số liệu, đánh giá mức độ ô nhiễm và đề xuất giải pháp kiểm soát phù hợp.",
  "Đánh giá quy trình phân loại, lưu trữ và xử lý chất thải nguy hại tại các nhà máy, khu công nghiệp. Hướng dẫn các đơn vị thực hiện đúng quy định và đảm bảo an toàn lao động.",
  "Đánh giá mức tiêu thụ năng lượng của doanh nghiệp, đề xuất các giải pháp tối ưu như sử dụng năng lượng tái tạo, cải thiện hiệu suất thiết bị, thay thế công nghệ cũ.",
  "Thu thập số liệu về môi trường, đánh giá ảnh hưởng của dự án đến hệ sinh thái và sức khỏe con người. Đề xuất các biện pháp giảm thiểu tác động tiêu cực trước khi triển khai dự án.",
  "Lập kế hoạch trồng cây tại các khu công nghiệp, đô thị hoặc vùng bị ảnh hưởng bởi biến đổi khí hậu. Giám sát quá trình chăm sóc cây để đảm bảo phát triển bền vững.",
  "Phản ứng nhanh khi phát hiện sự cố tràn dầu, rò rỉ hóa chất hoặc các hiện tượng ô nhiễm bất thường. Xây dựng kế hoạch ứng phó khẩn cấp để hạn chế tác động đến môi trường.",
  "Tổ chức các buổi tập huấn, hội thảo về phân loại rác, sử dụng sản phẩm thân thiện môi trường. Phát động các chiến dịch bảo vệ môi trường, giảm thiểu rác thải nhựa.",
  "Đánh giá mức độ phát thải khí độc hại, đề xuất cải thiện hệ thống thông gió, lắp đặt bộ lọc không khí. Đảm bảo môi trường làm việc an toàn cho công nhân.",
  "Kiểm tra đường ống nước sạch, hệ thống cống thoát nước để phát hiện sự cố rò rỉ, tắc nghẽn. Thực hiện bảo trì định kỳ để duy trì hiệu suất hoạt động tốt nhất.",
  "Hỗ trợ doanh nghiệp trong việc xin cấp phép môi trường, tuân thủ các quy chuẩn về khí thải, nước thải, chất thải rắn. Kiểm tra định kỳ và đề xuất biện pháp cải thiện.",
  "Lập kế hoạch, theo dõi tiến độ triển khai các dự án xử lý môi trường. Đảm bảo công trình thực hiện đúng kỹ thuật, đáp ứng các tiêu chuẩn chất lượng đề ra.",
  "Nghiên cứu và triển khai mô hình tái chế rác thải nhựa, giấy, kim loại thành nguyên liệu sản xuất. Khuyến khích áp dụng mô hình kinh tế tuần hoàn để giảm áp lực lên môi trường.",
  "Kiểm tra việc thực hiện quy định an toàn khi làm việc với hóa chất, thiết bị xử lý chất thải. Đảm bảo công nhân tuân thủ các biện pháp bảo vệ sức khỏe và phòng ngừa tai nạn.",
  "Theo dõi chất lượng và mức độ sử dụng tài nguyên nước tại các khu vực khai thác. Đề xuất các biện pháp bảo vệ nguồn nước, tránh khai thác quá mức gây suy giảm tài nguyên.",
  "Tư vấn và lắp đặt hệ thống điện mặt trời, biogas hoặc công nghệ tận dụng nhiệt thải trong sản xuất công nghiệp. Hỗ trợ doanh nghiệp chuyển đổi sang mô hình sản xuất thân thiện với môi trường.",
  "Đánh giá lượng khí CO₂, CH₄ phát thải từ các hoạt động công nghiệp. Đề xuất giải pháp giảm phát thải như cải tiến quy trình sản xuất, tăng cường trồng cây xanh.",
  "Triển khai các phần mềm giám sát chất lượng môi trường, sử dụng AI để dự báo tình trạng ô nhiễm. Cập nhật dữ liệu liên tục để hỗ trợ quản lý và ra quyết định kịp thời.",
];
