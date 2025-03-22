part of "list_view_bloc.dart";

class ListViewEvent<T> {
  const ListViewEvent();
}

class ListViewEventSearchCall<T> extends ListViewEvent<T> {
  final String searchValue;
  const ListViewEventSearchCall({required this.searchValue});
}

class ListViewEventLoadMoreCall<T> extends ListViewEvent<T> {
  const ListViewEventLoadMoreCall();
}
