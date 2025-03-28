import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_loader_bloc/repos/storage_repo.dart';

part 'app_loader_event.dart';
part 'app_loader_state.dart';

class AppLoaderBloc extends Bloc<AppLoaderEvent, AppLoaderState> {
  AppLoaderBloc() : super(AppLoaderState()) {
    on<AppLoaderEventInit>(_onInitApp);
    add(AppLoaderEventInit());
  }

  Future<void> _onInitApp(
    AppLoaderEventInit event,
    Emitter<AppLoaderState> emit,
  ) async {
    emit(AppLoaderStateLoading());

    StorageRepository storageRepo = StorageRepository();
    await storageRepo.repoInit();

    emit(AppLoaderStateReady(storageRepo: storageRepo));
  }
}
