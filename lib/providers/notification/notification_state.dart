part of "notification_bloc.dart";

class NotificationState extends Equatable {
  final List<NotificationRecord> notifications;

  const NotificationState({required this.notifications});

  @override
  List<Object?> get props => [];
}
