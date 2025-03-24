import 'package:flutter_work_mgmt_app/commons/misc/random.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repositories/data_repository.dart';

class TaskRepository extends DataRepository<TaskRecord> {
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
      final stringShort = generateRandomString(3);

      final stringName = generateRandomString(5);

      recs.add(
        TaskRecord(
          id: 1,
          workId: 1,
          name: "Task $stringShort $stringName",
          nameShort: "Task $stringShort",
          status: TaskStatus.active,
          isActive: true,
        ),
      );
    }
    return recs;
  }
}
