import 'package:flutter_work_mgmt_app/commons/misc/random.dart';
import 'package:flutter_work_mgmt_app/data/models/project.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';

class ProjectRepository extends DataRepository<ProjectRecord> {
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
      final stringName = generateRandomString(5);
      final stringNameShort = generateRandomString(3);
      final addressString = generateRandomString(20);

      final int completedWorkCount = random100u();

      recs.add(
        ProjectRecord(
          id: 1,
          name: "Project $stringName",
          nameShort: "Project $stringNameShort",
          description: null,
          workAddress: addressString,
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
}
