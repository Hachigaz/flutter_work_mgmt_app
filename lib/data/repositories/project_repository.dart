part of "../data_layer.dart";

class _ProjectRepository extends DataRepository<ProjectRecord> {
  const _ProjectRepository();

  @override
  ProjectRecord getOne() {
    return _generateItems(count: 1)[0];
  }

  @override
  ListReturnResult<ProjectRecord> search(String searchValue) {
    return (isLast: true, itemList: _generateItems());
  }

  List<ProjectRecord> _generateItems({int count = 3}) {
    final List<ProjectRecord> recs = [];
    for (var i = 0; i < count; i++) {
      final int completedWorkCount = random100u();

      recs.add(
        ProjectRecord(
          id: 1,
          name: _titles[Random().nextInt(_titles.length)],
          description: _description[Random().nextInt(_description.length)],
          workAddress: _addresses[Random().nextInt(_addresses.length)],
          activeWorkItem: 1,
          workItemCount: completedWorkCount + (random100u() / 2).toInt(),
          completedWorkCount: completedWorkCount,
          startDate: DateTime.now().add(Duration(days: random100())),
          isActive: true,
        ),
      );
    }
    return recs;
  }

  static const List<String> _titles = [
    "Dự án xử lý nước thải khu công nghiệp X",
    "Dự án quan trắc tự động nước thải tại nhà máy sản xuất Y",
    "Dự án điện mặt trời áp mái cho nhà máy Z",
    "Dự án xử lý khí thải lò hơi bằng hệ thống lọc bụi tĩnh điện",
    "Dự án tái chế rác thải nhựa thành nguyên liệu sản xuất",
    "Dự án xử lý bùn thải công nghiệp thành phân bón hữu cơ",
    "Dự án lắp đặt hệ thống thu gom và xử lý nước mưa tại khu dân cư",
    "Dự án cải tạo hệ thống xử lý nước cấp cho khu công nghiệp",
    "Dự án quan trắc chất lượng không khí tại đô thị lớn",
    "Dự án chuyển đổi rác thải sinh hoạt thành năng lượng điện",
    "Dự án xử lý nước thải chăn nuôi bằng công nghệ biogas",
    "Dự án sử dụng vật liệu xanh trong xây dựng",
    "Dự án phát triển mô hình khu dân cư sinh thái",
    "Dự án cải tạo hệ thống thoát nước đô thị để chống ngập",
    "Dự án giáo dục và nâng cao ý thức bảo vệ môi trường",
  ];

  static const List<String> _description = [
    "Dự án xây dựng hệ thống xử lý nước thải với công suất 5.000 m³/ngày, áp dụng công nghệ MBR kết hợp hóa lý. Hệ thống giúp giảm thiểu ô nhiễm, đảm bảo nước thải đầu ra đạt chuẩn QCVN. Dự án bao gồm các bể xử lý sinh học, bể lắng, và khu vực tái sử dụng nước sau xử lý.",
    "Lắp đặt hệ thống quan trắc tự động giúp giám sát liên tục chất lượng nước thải, kết nối trực tiếp với Sở TNMT. Hệ thống bao gồm cảm biến đo COD, pH, DO và thiết bị truyền dữ liệu theo thời gian thực. Giúp doanh nghiệp tuân thủ quy định môi trường và tối ưu chi phí vận hành.",
    "Triển khai hệ thống điện mặt trời công suất 1MWp trên mái nhà xưởng, cung cấp năng lượng xanh và giảm tải điện lưới. Hệ thống sử dụng tấm pin hiệu suất cao, tích hợp bộ inverter thông minh giúp theo dõi sản lượng điện. Dự kiến giảm phát thải hơn 1.000 tấn CO₂ mỗi năm.",
    "Cải tiến công nghệ xử lý khí thải bằng hệ thống lọc bụi tĩnh điện (ESP) giúp loại bỏ 98% hạt bụi mịn PM2.5 từ quá trình đốt lò hơi. Hệ thống tích hợp bộ hấp thụ khí SO₂, NOₓ bằng than hoạt tính, đảm bảo khí thải đạt tiêu chuẩn môi trường.",
    "Ứng dụng công nghệ phân loại và tái chế nhựa tự động để tạo ra hạt nhựa tái sinh đạt chuẩn công nghiệp. Dự án giúp giảm thiểu rác thải nhựa ra môi trường, cung cấp nguồn nguyên liệu bền vững cho ngành sản xuất bao bì và nhựa tái chế.",
    "Triển khai công nghệ xử lý bùn thải bằng phương pháp lên men hiếu khí, giúp chuyển hóa bùn thành phân bón hữu cơ giàu dinh dưỡng. Giải pháp này không chỉ giảm thiểu ô nhiễm môi trường mà còn tạo ra sản phẩm có giá trị sử dụng cao trong nông nghiệp.",
    "Xây dựng hệ thống thu gom nước mưa với bể chứa lớn, tích hợp công nghệ lọc và khử trùng để cung cấp nước tái sử dụng cho tưới cây, rửa đường và phòng cháy chữa cháy. Giúp giảm áp lực lên hệ thống cấp nước đô thị và tận dụng tài nguyên hiệu quả.",
    "Nâng cấp hệ thống xử lý nước cấp bằng công nghệ lọc màng RO và than hoạt tính, đảm bảo chất lượng nước đạt tiêu chuẩn sinh hoạt và sản xuất. Hệ thống có khả năng xử lý kim loại nặng, vi khuẩn, và tạp chất, nâng cao hiệu suất sử dụng nước.",
    "Lắp đặt mạng lưới cảm biến đo chất lượng không khí (AQI) tại các điểm nóng ô nhiễm, kết nối dữ liệu với hệ thống cảnh báo thời gian thực. Giúp cơ quan chức năng và người dân có biện pháp ứng phó kịp thời với ô nhiễm bụi mịn và khí độc hại.",
    "Ứng dụng công nghệ đốt rác phát điện (WTE) để xử lý rác thải sinh hoạt, tạo ra điện năng phục vụ sinh hoạt và sản xuất. Hệ thống tích hợp bộ lọc khí thải tiên tiến để giảm thiểu ô nhiễm, góp phần giải quyết vấn đề quá tải bãi chôn lấp rác.",
    "Xây dựng hệ thống hầm biogas quy mô lớn để xử lý nước thải từ các trang trại chăn nuôi, tận dụng khí sinh học để phát điện và sưởi ấm. Hệ thống giúp giảm ô nhiễm môi trường, đồng thời cung cấp nguồn năng lượng sạch và phân bón hữu cơ.",
    "Nghiên cứu và triển khai các vật liệu xây dựng thân thiện môi trường như gạch không nung, bê tông từ tro bay, và sơn sinh học. Dự án giúp giảm phát thải CO₂, tối ưu chi phí xây dựng và tạo ra công trình bền vững.",
    "Thiết kế và xây dựng khu dân cư thân thiện với môi trường, tích hợp các giải pháp tiết kiệm năng lượng, xử lý rác thải tại nguồn, và không gian xanh rộng lớn. Mô hình giúp nâng cao chất lượng sống và bảo vệ tài nguyên thiên nhiên.",
    "Lắp đặt hệ thống cống thoát nước thông minh, kết hợp hồ điều hòa và trạm bơm công suất lớn để giảm thiểu tình trạng ngập úng tại các thành phố lớn. Hệ thống được tích hợp công nghệ giám sát tự động để điều chỉnh lưu lượng nước phù hợp.",
    "Tổ chức các chương trình tuyên truyền, đào tạo về phân loại rác tại nguồn, sử dụng năng lượng tái tạo, và giảm thiểu sử dụng nhựa dùng một lần. Dự án hướng đến thay đổi thói quen tiêu dùng và nâng cao trách nhiệm cộng đồng trong bảo vệ môi trường.",
  ];

  static const List<String> _addresses = [
    "123 Đường Nguyễn Hữu Cảnh, Phường 22, Quận Bình Thạnh, TP. Hồ Chí Minh",
    "Km 45, Quốc lộ 1A, Huyện Thanh Trì, TP. Hà Nội",
    "150 Đường Lê Lợi, Phường Bến Thành, Quận 1, TP. Hồ Chí Minh",
    "Khu đô thị Eco Park, Phường Văn Giang, Huyện Văn Giang, Tỉnh Hưng Yên",
    "Đường Long Biên, Quận Ba Đình, TP. Hà Nội",
    "25 Đường Nguyễn Tất Thành, Quận Hải Châu, TP. Đà Nẵng",
    "100 Đường Lê Duẩn, Quận 1, TP. Hồ Chí Minh",
    "45 Đường Đinh Tiên Hoàng, Phường 1, Quận Bình Thạnh, TP. Hồ Chí Minh",
    "789 Đường Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh",
    "432 Đường Hoàng Quốc Việt, Quận Cầu Giấy, TP. Hà Nội",
    "256 Đường Lê Đại Hành, Quận 11, TP. Hồ Chí Minh",
    "112 Đường Phan Đình Phùng, Quận Phú Nhuận, TP. Hồ Chí Minh",
    "36 Đường Võ Thị Sáu, Quận 3, TP. Hồ Chí Minh",
    "69 Đường Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh",
    "15 Đường Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh",
    "88 Đường Nguyễn Hồng, Quận Gò Vấp, TP. Hồ Chí Minh",
    "201 Đường Hồ Tùng Mậu, Quận Cầu Giấy, TP. Hà Nội",
    "56 Đường Trần Phú, Quận Hà Đông, TP. Hà Nội",
    "98 Đường Láng Hạ, Quận Đống Đa, TP. Hà Nội",
    "204 Đường Minh Khai, Quận Hai Bà Trưng, TP. Hà Nội",
    "567 Đường Nguyễn Trãi, Quận Thanh Xuân, TP. Hà Nội",
    "321 Đường Kim Mã, Quận Ba Đình, TP. Hà Nội",
    "45 Đường Nguyễn Thị Thập, Quận 7, TP. Hồ Chí Minh",
    "78 Đường Quang Trung, Quận 12, TP. Hồ Chí Minh",
    "101 Đường Trường Chinh, Quận Tân Phú, TP. Hồ Chí Minh",
    "25 Đường Phạm Văn Đồng, Quận Thủ Đức, TP. Hồ Chí Minh",
    "888 Đường Lê Quang Đạo, Quận Nam Từ Liêm, TP. Hà Nội",
    "120 Đường Đào Duy Anh, Quận Đống Đa, TP. Hà Nội",
    "432 Đường Nguyễn Trãi, Quận Thanh Xuân, TP. Hà Nội",
    "15 Đường Cao Thắng, Quận 3, TP. Hồ Chí Minh",
  ];
}
