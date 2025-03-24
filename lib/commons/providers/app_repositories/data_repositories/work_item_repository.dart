import 'package:flutter_work_mgmt_app/commons/misc/random.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repositories/data_repository.dart';

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

      recs.add(
        WorkItemRecord(
          id: 1,
          projectId: 1,
          name: "Work Item $stringName",
          nameShort: "Work Item $stringNameShort",
          description: null,
          taskCount: 1,
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
