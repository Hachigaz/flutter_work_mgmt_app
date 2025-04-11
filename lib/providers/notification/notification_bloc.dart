import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/notifications.dart';

part "notification_event.dart";
part "notification_state.dart";
part "models/models.dart";

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationState(notifications: [])) {
    on<NotificationEventGetNotifsCall>(_onCallGetNotifs);
    on<NotificationEventReceivedNotification>(onReceiveNotification);

    add(NotificationEventGetNotifsCall());
  }

  FutureOr<void> _onCallGetNotifs(
    NotificationEventGetNotifsCall event,
    Emitter<NotificationState> emit,
  ) {}

  FutureOr<void> onReceiveNotification(
    NotificationEventReceivedNotification event,
    Emitter<NotificationState> emit,
  ) {}
}
