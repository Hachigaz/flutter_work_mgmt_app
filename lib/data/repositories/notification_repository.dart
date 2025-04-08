part of "../data_layer.dart";

class _NotificationRepository extends DataRepository<NotificationRecord> {
  @override
  NotificationRecord getOne() {
    return _generateItems(count: 1)[0];
  }

  @override
  ListReturnResult<NotificationRecord> search(String searchValue) {
    return (itemList: _generateItems(count: 10), isLast: false);
  }

  List<NotificationRecord> _generateItems({int count = 3}) {
    final List<NotificationRecord> recs = [];
    for (var i = 0; i < count; i++) {
      recs.add(
        NotificationRecord(
          id: 1,
          title: _titles[Random().nextInt(_titles.length)],
          message: _messages[Random().nextInt(_messages.length)],
          timestamp: DateTime.now().add(Duration(days: random100())),
          importance:
              NotificationImportance.values[Random().nextInt(
                NotificationImportance.values.length,
              )],
          status:
              NotificationStatus.values[Random().nextInt(
                NotificationStatus.values.length,
              )],
        ),
      );
    }
    return recs;
  }
}

final _titles = <String>[
  "Cập nhật hệ thống",
  "Khuyến mãi đặc biệt",
  "Tin nhắn mới",
  "Lịch hẹn",
  "Cảnh báo bảo mật",
  "Chào mừng!",
  "Cập nhật phiên bản",
  "Thông báo thanh toán",
  "Sự kiện sắp diễn ra",
  "Đặt hàng thành công",
  "Giao hàng thất bại",
  "Tài khoản bị khóa",
  "Nhắc nhở hóa đơn",
  "Cảnh báo vi phạm",
  "Mời bạn tham gia khảo sát",
  "Thông báo bảo trì",
  "Cập nhật tính năng",
  "Lời mời kết bạn",
  "Bình luận mới",
  "Đánh giá sản phẩm",
  "Thay đổi chính sách",
  "Mất kết nối Internet",
  "Hệ thống hoạt động lại",
  "Thời tiết hôm nay",
  "Lời nhắc sinh nhật",
  "Tăng giới hạn lưu trữ",
  "Khóa học mới có sẵn",
];

final _messages = <String>[
  "Hệ thống sẽ bảo trì vào lúc 02:00 AM ngày mai.",
  "Nhận ngay giảm giá 50% khi mua hàng hôm nay!",
  "Bạn có một tin nhắn mới từ Nguyễn Văn A.",
  "Bạn có một cuộc họp vào lúc 10:00 AM ngày mai.",
  "Phát hiện đăng nhập bất thường vào tài khoản của bạn.",
  "Cảm ơn bạn đã đăng ký, hãy khám phá các tính năng mới!",
  "Phiên bản 2.0 đã ra mắt với nhiều cải tiến hấp dẫn!",
  "Bạn có một giao dịch thanh toán thành công.",
  "Sự kiện hội thảo công nghệ sẽ diễn ra vào thứ Sáu.",
  "Đơn hàng của bạn đã được xác nhận và đang xử lý.",
  "Chúng tôi không thể giao hàng, vui lòng liên hệ hỗ trợ.",
  "Tài khoản của bạn bị khóa do hoạt động đáng ngờ.",
  "Hóa đơn tháng này sẽ hết hạn vào ngày 10, vui lòng thanh toán.",
  "Bạn đã vi phạm nguyên tắc cộng đồng, vui lòng kiểm tra lại.",
  "Hãy dành 2 phút để giúp chúng tôi cải thiện dịch vụ!",
  "Hệ thống sẽ tạm dừng để bảo trì vào tối nay.",
  "Chúng tôi vừa bổ sung tính năng mới cho ứng dụng!",
  "Nguyễn Văn B đã gửi cho bạn một lời mời kết bạn.",
  "Bạn có một bình luận mới trên bài viết của mình.",
  "Người dùng A vừa đánh giá sản phẩm bạn mua 5 sao!",
  "Chính sách sử dụng đã được cập nhật, vui lòng đọc kỹ.",
  "Không có kết nối Internet, vui lòng thử lại sau.",
  "Hệ thống đã hoạt động lại bình thường sau bảo trì.",
  "Nhiệt độ hôm nay là 28°C, trời nắng nhẹ.",
  "Hôm nay là sinh nhật của Nguyễn Văn C, hãy gửi lời chúc!",
  "Bạn vừa được nâng cấp gói lưu trữ lên 50GB.",
  "Một khóa học lập trình mới vừa được thêm vào thư viện.",
];
