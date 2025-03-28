import 'package:flutter_work_mgmt_app/commons/models/model.dart';

typedef ListReturnResult<T extends DataRecord> =
    ({bool isLast, List<T> itemList});

abstract class DataRepository<T extends DataRecord> {
  ListReturnResult<T> search(String searchValue);
  T getOne();
}
