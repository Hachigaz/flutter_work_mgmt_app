part of "page_detail_bloc.dart";

class PageDetailEvent<T> extends Equatable {
  const PageDetailEvent();

  @override
  List<Object?> get props => [];
}

class PageDetailEventInit<T> extends PageDetailEvent<T> {
  final ID recordId;
  const PageDetailEventInit({required this.recordId});

  @override
  List<Object?> get props => [recordId];
}
