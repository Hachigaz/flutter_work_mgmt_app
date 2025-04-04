part of "../data_layer.dart";

class _TaskReportRepository extends DataRepository<TaskReportRecord> {
  const _TaskReportRepository();

  @override
  TaskReportRecord getOne() {
    return _generateItems(count: 1)[0];
  }

  @override
  ListReturnResult<TaskReportRecord> search(String searchValue) {
    return (itemList: _generateItems(count: 10), isLast: true);
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
          submittedDate: DateTime.now().add(Duration(days: random100())),
          verifiedBy: 1,
          reportData: null,
          isActive: true,
        ),
      );
    }
    return recs;
  }
}
