import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/notifications.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';

part "notification_page_event.dart";

part "notification_page_state.dart";

class NotificationPageBloc
    extends Bloc<NotificationPageEvent, NotificationPageState> {
  final DataRepository<NotificationRecord> _notificationRepo;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  NotificationPageBloc({
    required DataRepository<NotificationRecord> notificationRepo,
  }) : _notificationRepo = notificationRepo,
       super(NotificationPageStateInitial()) {
    on<NotificationPageEventInit>(_onInitBloc);

    add(NotificationPageEventInit());
  }

  Future<void> _onInitBloc(
    NotificationPageEventInit event,
    Emitter<NotificationPageState> emit,
  ) async {
    emit(NotificationPageStateInitLoading());
    final itemList = await Future.delayed(
      Duration(seconds: 2),
      () => _notificationRepo.search("").itemList,
    );
    emit(NotificationPageStateReady(notifications: itemList));
  }

  void updateList(final int lastIndex, final int count) {
    listKey.currentState!.insertAllItems(lastIndex, count);
  }
}
