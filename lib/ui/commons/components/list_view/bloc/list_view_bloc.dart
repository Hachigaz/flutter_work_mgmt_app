library;

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';

part "list_view_event.dart";
part "list_view_state.dart";

class ListViewBloc<T extends DataRecord>
    extends Bloc<ListViewEvent<T>, ListViewState<T>> {
  final DataRepository<T> _dataRepo;

  ListViewBloc({required DataRepository<T> dataRepo})
    : _dataRepo = dataRepo,
      super(ListViewStateInitial<T>()) {
    on<_ListViewEventInit<T>>(_onInitBloc);
    on<ListViewEventSearchCall<T>>(_onListViewSeach);
    on<ListViewEventLoadMoreCall<T>>(_onListViewLoadMore);

    add(_ListViewEventInit<T>());
  }

  Future<void> _onInitBloc(
    _ListViewEventInit<T> event,
    Emitter<ListViewState<T>> emit,
  ) async {
    emit(ListViewStateInitialLoading<T>());

    await Future.delayed(Duration(seconds: 1));

    add(ListViewEventSearchCall<T>(searchValue: ""));
  }

  Future<void> _onListViewSeach(
    ListViewEventSearchCall<T> event,
    Emitter<ListViewState<T>> emit,
  ) async {
    emit(
      ListViewStateLoading<T>(
        itemList: [],
        currentSearchValue: event.searchValue,
        isLast: true,
      ),
    );

    final searchValue = event.searchValue;

    final result = await Future.delayed(
      Duration(seconds: 2),
      () => _dataRepo.search(searchValue),
    );

    emit(
      ListViewStateReady<T>(
        itemList: result.itemList,
        currentSearchValue: searchValue,
        isLast: result.isLast,
      ),
    );
  }

  FutureOr<void> _onListViewLoadMore(
    ListViewEventLoadMoreCall<T> event,
    Emitter<ListViewState<T>> emit,
  ) async {
    final state = this.state as ListViewStateReadyBase<T>;

    emit(
      ListViewStateLoading<T>(
        itemList: state.itemList,
        currentSearchValue: state.currentSearchValue,
        isLast: state.isLast,
      ),
    );

    final result = await Future.delayed(
      Duration(seconds: 2),
      () => _dataRepo.search(state.currentSearchValue),
    );

    state.itemList.addAll(result.itemList);

    emit(
      ListViewStateReady<T>(
        itemList: state.itemList,
        currentSearchValue: state.currentSearchValue,
        isLast: result.isLast,
      ),
    );
  }
}
