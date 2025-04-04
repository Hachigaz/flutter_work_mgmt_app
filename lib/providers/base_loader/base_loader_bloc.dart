import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/providers/base_loader/repos/storage_repo.dart';

part 'base_loader_event.dart';
part 'base_loader_state.dart';

class BaseLoaderBloc extends Bloc<BaseLoaderEvent, BaseLoaderState> {
  BaseLoaderBloc() : super(BaseLoaderState()) {
    on<BaseLoaderEventInit>(_onInitApp);
    add(BaseLoaderEventInit());
  }

  Future<void> _onInitApp(
    BaseLoaderEventInit event,
    Emitter<BaseLoaderState> emit,
  ) async {
    emit(BaseLoaderStateLoading());

    StorageRepository storageRepo = StorageRepository();
    await storageRepo.repoInit();

    emit(BaseLoaderStateReady(storageRepo: storageRepo));
  }
}
