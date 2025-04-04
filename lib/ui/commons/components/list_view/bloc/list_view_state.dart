part of "list_view_bloc.dart";

sealed class ListViewState<T extends DataRecord> extends Equatable {
  const ListViewState();

  @override
  List<Object?> get props => [];
}

class ListViewStateInitial<T extends DataRecord> extends ListViewState<T> {}

class ListViewStateInitialLoading<T extends DataRecord>
    extends ListViewStateInitial<T> {}

sealed class ListViewStateReadyBase<T extends DataRecord>
    extends ListViewState<T> {
  final List<T> itemList;
  final String currentSearchValue;
  final bool isLast;

  const ListViewStateReadyBase({
    required this.itemList,
    required this.currentSearchValue,
    required this.isLast,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    itemList,
    currentSearchValue,
    isLast,
  ];
}

class ListViewStateReady<T extends DataRecord>
    extends ListViewStateReadyBase<T> {
  const ListViewStateReady({
    required super.itemList,
    required super.currentSearchValue,
    required super.isLast,
  });
  ListViewStateReady<T> copyWith(
    List<T>? itemList,
    String? currentSearchValue,
    bool? isLast,
  ) {
    return ListViewStateReady<T>(
      itemList: itemList ?? this.itemList,
      currentSearchValue: currentSearchValue ?? this.currentSearchValue,
      isLast: isLast ?? this.isLast,
    );
  }
}

class ListViewStateLoading<T extends DataRecord>
    extends ListViewStateReadyBase<T> {
  const ListViewStateLoading({
    required super.itemList,
    required super.currentSearchValue,
    required super.isLast,
  });
  ListViewStateLoading<T> copyWith(
    List<T>? itemList,
    String? currentSearchValue,
    bool? isLast,
  ) {
    return ListViewStateLoading<T>(
      itemList: itemList ?? this.itemList,
      currentSearchValue: currentSearchValue ?? this.currentSearchValue,
      isLast: isLast ?? this.isLast,
    );
  }
}
