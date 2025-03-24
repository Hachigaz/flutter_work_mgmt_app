import 'package:flutter_work_mgmt_app/commons/misc/random.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repositories/data_repository.dart';

class ReportRepository extends DataRepository<TaskReportRecord> {
  @override
  ListReturnResult<TaskReportRecord> search(String searchValue) {
    return (itemList: _generateItems(count: 5), isLast: false);
  }

  @override
  TaskReportRecord getOne() {
    return _generateItems(count: 1)[0];
  }

  List<TaskReportRecord> _generateItems({int count = 3}) {
    final List<TaskReportRecord> recs = [];
    for (var i = 0; i < count; i++) {
      recs.add(
        TaskReportRecord(
          id: 1,
          scheduleId: 1,
          dateCreated: DateTime.now().add(Duration(days: random100())),
          createdBy: 1,
          lastUpdated: DateTime.now().add(Duration(days: random100())),
          lastUpdatedBy: 1,
          isSubmitted: false,
          verifiedBy: 2,
          reportData: null,
          isActive: true,
        ),
      );
    }
    return recs;
  }
}
