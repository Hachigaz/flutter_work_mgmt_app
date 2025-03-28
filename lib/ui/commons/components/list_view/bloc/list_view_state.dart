part of "list_view_bloc.dart";

class ListViewState<T extends DataRecord> extends Equatable {
  final List<T> itemList;
  final String currentSearchValue;
  final bool isLast;

  const ListViewState({
    required this.itemList,
    required this.currentSearchValue,
    required this.isLast,
  });

  @override
  List<Object?> get props => [itemList, isLast];

  ListViewState copyWith(
    List<T>? itemList,
    String? currentSearchValue,
    bool? isLast,
  ) {
    return ListViewState(
      itemList: itemList ?? this.itemList,
      currentSearchValue: currentSearchValue ?? this.currentSearchValue,
      isLast: isLast ?? this.isLast,
    );
  }
}

class ListViewStateLoading<T extends DataRecord> extends ListViewState<T> {
  const ListViewStateLoading({
    required super.itemList,
    required super.currentSearchValue,
    required super.isLast,
  });
}

class ListViewStateReady<T extends DataRecord> extends ListViewState<T> {
  const ListViewStateReady({
    required super.itemList,
    required super.currentSearchValue,
    required super.isLast,
  });
}
