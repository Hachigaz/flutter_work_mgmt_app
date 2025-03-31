import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';

part "page_detail_event.dart";
part "page_detail_state.dart";

class PageDetailBloc<T extends DataRecord>
    extends Bloc<PageDetailEvent<T>, PageDetailState<T>> {
  final DataRepository<T> _dataRepo;

  PageDetailBloc({required DataRepository<T> dataRepo, required ID recordId})
    : _dataRepo = dataRepo,
      super(PageDetailState<T>()) {
    on<PageDetailEventInit<T>>(onPageDetailEventInit);
    add(PageDetailEventInit<T>(recordId: recordId));
  }

  @protected
  Future<void> onPageDetailEventInit(
    PageDetailEventInit<T> event,
    Emitter<PageDetailState<T>> emit,
  ) async {
    emit(PageDetailStateLoading());

    final record = await Future.delayed(
      Duration(seconds: 2),
      () => _dataRepo.getOne(),
    );

    emit(PageDetailStateRecordReady(record: record));
  }
}
