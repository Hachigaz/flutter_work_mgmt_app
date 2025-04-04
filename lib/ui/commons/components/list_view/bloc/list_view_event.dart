part of "list_view_bloc.dart";

sealed class ListViewEvent<T extends DataRecord> {
  const ListViewEvent();
}

class _ListViewEventInit<T extends DataRecord> extends ListViewEvent<T> {
  const _ListViewEventInit();
}

class ListViewEventSearchCall<T extends DataRecord> extends ListViewEvent<T> {
  final String searchValue;
  const ListViewEventSearchCall({required this.searchValue});
}

class ListViewEventLoadMoreCall<T extends DataRecord> extends ListViewEvent<T> {
  const ListViewEventLoadMoreCall();
}
