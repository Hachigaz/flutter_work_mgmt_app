part of "notification_page_bloc.dart";

sealed class NotificationPageState extends Equatable {
  const NotificationPageState();

  @override
  List<Object?> get props => [];
}

class NotificationPageStateInitial extends NotificationPageState {}

class NotificationPageStateInitLoading extends NotificationPageStateInitial {}

class NotificationPageStateReady extends NotificationPageState {
  final List<NotificationRecord> notifications;

  const NotificationPageStateReady({required this.notifications});
}

class NotificationPageStateLoading extends NotificationPageStateReady {
  const NotificationPageStateLoading({required super.notifications});
}
