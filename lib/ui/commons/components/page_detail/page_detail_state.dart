part of "page_detail_bloc.dart";

class PageDetailState<T> extends Equatable {
  const PageDetailState();

  @override
  List<Object?> get props => [];
}

class PageDetailStateLoading<T> extends PageDetailState<T> {}

class PageDetailStateRecordReady<T> extends PageDetailState<T> {
  final T record;

  const PageDetailStateRecordReady({required this.record});
}
