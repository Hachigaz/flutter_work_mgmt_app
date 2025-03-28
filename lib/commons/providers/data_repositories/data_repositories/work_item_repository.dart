import 'package:flutter_work_mgmt_app/commons/misc/random.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/data_repository.dart';

class WorkItemRepository extends DataRepository<WorkItemRecord> {
  @override
  WorkItemRecord getOne() {
    return _generateItems(count: 1)[0];
  }

  @override
  ListReturnResult<WorkItemRecord> search(String searchValue) {
    return (isLast: true, itemList: _generateItems());
  }

  List<WorkItemRecord> _generateItems({int count = 3}) {
    final List<WorkItemRecord> recs = [];
    for (var i = 0; i < count; i++) {
      final stringName = generateRandomString(5);
      final stringNameShort = generateRandomString(3);

      final activeTaskCount = (random100u() / 3).toInt();
      final completedTaskCount = (random100u() / 3).toInt();
      final expiredTaskCount = (random100u() / 3).toInt();

      recs.add(
        WorkItemRecord(
          id: 1,
          projectId: 1,
          name: "Work Item $stringName",
          nameShort: "Work Item $stringNameShort",
          description: """
Nhà em có một chú mèo tam thể rất đáng yêu, em đặt tên cho nó là Miu.

Miu có bộ lông ba màu: trắng, vàng và đen xen kẽ nhau trông rất đẹp. Đôi mắt tròn, xanh biếc như hai viên ngọc. Mũi nhỏ xinh màu hồng, lúc nào cũng ươn ướt. Đặc biệt, bộ ria mép dài giúp Miu trông thật oai phong. Bốn chân nhỏ nhưng rất nhanh nhẹn. Đuôi mèo dài, luôn ngoe nguẩy mỗi khi nó vui.

Miu rất thích rượt đuổi những chú chuột nhỏ trong góc bếp. Khi ngủ, nó thường cuộn tròn như một cục bông mềm mại. Những lúc rảnh rỗi, em hay ôm Miu vào lòng, vuốt ve bộ lông mượt mà của nó.

Em rất yêu Miu, vì nó không chỉ đáng yêu mà còn giúp gia đình em bắt chuột nữa!""",
          activeTaskCount: activeTaskCount,
          completedTaskCount: completedTaskCount,
          expiredTaskCount: expiredTaskCount,
          taskCount: activeTaskCount + completedTaskCount + expiredTaskCount,
          progression: 0.34,
          startDate: DateTime.now().add(Duration(days: random100())),
          isCompleted: false,
          isActive: true,
        ),
      );
    }
    return recs;
  }
}
