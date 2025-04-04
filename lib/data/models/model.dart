typedef ID = int;

abstract class DataRecord {
  final ID? id;

  const DataRecord({required this.id});
}

class RefRecord<T extends DataRecord> {
  final ID? refId;
  final T? record;

  RefRecord({required this.refId, this.record});
}
