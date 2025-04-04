part of "../data_layer.dart";

class _WorkItemRepository extends DataRepository<WorkItemRecord> {
  const _WorkItemRepository();

  @override
  WorkItemRecord getOne() {
    return _generateItems(count: 1)[0];
  }

  @override
  ListReturnResult<WorkItemRecord> search(String searchValue) {
    return (isLast: false, itemList: _generateItems(count: 10));
  }

  List<WorkItemRecord> _generateItems({int count = 3}) {
    final List<WorkItemRecord> recs = [];
    for (var i = 0; i < count; i++) {
      final activeTaskCount = (random100u() / 3).toInt();
      final completedTaskCount = (random100u() / 3).toInt();
      final expiredTaskCount = (random100u() / 3).toInt();

      recs.add(
        WorkItemRecord(
          id: 1,
          projectId: 1,
          name: _names[Random().nextInt(_names.length)],
          description: _description[Random().nextInt(_description.length)],
          activeTaskCount: activeTaskCount,
          completedTaskCount: completedTaskCount,
          expiredTaskCount: expiredTaskCount,
          taskCount: activeTaskCount + completedTaskCount + expiredTaskCount,
          progression: random100u() / 100,
          startDate: DateTime.now().add(Duration(days: random100())),
          isCompleted: false,
          isActive: true,
        ),
      );
    }
    return recs;
  }

  static const List<String> _names = [
    "Hạng mục xây dựng hệ thống xử lý nước thải",
    "Hạng mục lắp đặt hệ thống quan trắc môi trường",
    "Hạng mục thu gom và xử lý rác thải rắn",
    "Hạng mục chuyển đổi năng lượng tái tạo",
    "Hạng mục cải tạo hệ thống cấp nước sạch",
    "Hạng mục cải thiện cảnh quan và cây xanh đô thị",
    "Hạng mục nghiên cứu và phát triển vật liệu xanh",
    "Hạng mục nâng cao nhận thức và giáo dục môi trường",
    "Hạng mục xử lý bùn thải và tái chế chất thải nguy hại",
    "Hạng mục giám sát và bảo vệ đa dạng sinh học",
  ];

  static const List<String> _description = [
    "Lắp đặt và vận hành hệ thống xử lý nước thải sử dụng công nghệ sinh học, hóa lý, và màng lọc hiện đại. Đảm bảo nước đầu ra đạt tiêu chuẩn môi trường trước khi xả thải hoặc tái sử dụng.",
    "Triển khai các trạm quan trắc không khí, nước, và tiếng ồn, kết nối dữ liệu với hệ thống giám sát từ xa. Cung cấp thông tin thời gian thực để kịp thời xử lý các vấn đề ô nhiễm.",
    "Xây dựng quy trình thu gom, phân loại và xử lý rác thải rắn theo hướng tái chế và tái sử dụng. Ứng dụng công nghệ xử lý rác thành phân bón hữu cơ hoặc nhiên liệu đốt.",
    "Lắp đặt hệ thống điện mặt trời, điện gió hoặc khí sinh học để giảm phụ thuộc vào nhiên liệu hóa thạch. Hạng mục này giúp tối ưu chi phí vận hành và bảo vệ môi trường.",
    "Nâng cấp đường ống, bể chứa và công nghệ lọc nước nhằm cải thiện chất lượng và khả năng cung cấp nước sạch cho khu dân cư, khu công nghiệp hoặc trang trại.",
    "Triển khai các công trình cây xanh, vườn đứng, hồ điều hòa để cải thiện chất lượng không khí và tăng tính thẩm mỹ cho khu vực. Giúp giảm hiệu ứng đảo nhiệt đô thị và nâng cao chất lượng sống.",
    "Sử dụng vật liệu tái chế, gạch không nung, sơn sinh học trong xây dựng để giảm phát thải CO₂ và tăng độ bền cho công trình. Hạng mục này hướng đến nền kinh tế tuần hoàn và phát triển bền vững.",
    "Tổ chức hội thảo, đào tạo về phân loại rác, tiết kiệm năng lượng và sử dụng sản phẩm thân thiện môi trường. Hạng mục này giúp thay đổi hành vi và nâng cao trách nhiệm cộng đồng.",
    "Xây dựng quy trình xử lý bùn thải từ các nhà máy, khu công nghiệp thành phân bón hoặc vật liệu có ích. Hạng mục này giúp giảm thiểu ô nhiễm và tận dụng tài nguyên hiệu quả.",
    "Thiết lập các khu bảo tồn, kiểm soát nguồn nước và môi trường sống của động thực vật hoang dã. Giúp duy trì sự cân bằng sinh thái và bảo vệ các loài có nguy cơ tuyệt chủng.",
  ];
}
