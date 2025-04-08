part of "notification_bloc.dart";

sealed class NotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationEventGetNotifsCall extends NotificationEvent {}

class NotificationEventReceivedNotification extends NotificationEvent {
  final NotificationRecord notification;

  NotificationEventReceivedNotification({required this.notification});

  @override
  List<Object?> get props => [...super.props, notification];
}
