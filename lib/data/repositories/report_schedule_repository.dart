import 'dart:math';

import 'package:flutter_work_mgmt_app/commons/misc/random.dart';
import 'package:flutter_work_mgmt_app/data/models/report.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';

class ReportScheduleRepository extends DataRepository<ReportSchedule> {
  @override
  ListReturnResult<ReportSchedule> search(String searchValue) {
    return (itemList: _generateItems(), isLast: false);
  }

  @override
  ReportSchedule getOne() {
    return _generateItems(count: 1)[0];
  }

  List<ReportSchedule> _generateItems({int count = 3}) {
    final List<ReportSchedule> recs = [];
    for (var i = 0; i < count; i++) {
      recs.add(
        ReportSchedule(
          id: 1,
          taskId: 1,
          title: "Schedule ${generateRandomString(4)}",
          dueDate: DateTime.now().add(Duration(days: random100() + 100)),
          isReported: false,
          reportId: (Random().nextInt(2) % 3 == 0 ? 1 : null),
          isActive: true,
        ),
      );
    }
    return recs;
  }
}
