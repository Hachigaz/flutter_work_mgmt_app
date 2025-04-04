part of "notification_page_bloc.dart";

class NotificationPageEvent extends Equatable {
  const NotificationPageEvent();

  @override
  List<Object?> get props => [];
}

class NotificationPageEventInit extends NotificationPageEvent {}

class NotificationPageEventLoadMore extends NotificationPageEvent {}

class NotificationPageEventRefresh extends NotificationPageEvent {}
