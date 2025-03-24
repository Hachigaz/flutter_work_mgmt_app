import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repositories/data_repository.dart';

part "page_detail_event.dart";
part "page_detail_state.dart";

class PageDetailBloc<T> extends Bloc<PageDetailEvent<T>, PageDetailState<T>> {
  final DataRepository<T> dataRepo;

  PageDetailBloc({required this.dataRepo, required ID recordId})
    : super(PageDetailState<T>()) {
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
      () => dataRepo.getOne(),
    );

    emit(PageDetailStateRecordReady(record: record));
  }
}
