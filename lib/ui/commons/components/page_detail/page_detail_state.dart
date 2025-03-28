part of "page_detail_bloc.dart";

class PageDetailState<T extends DataRecord> extends Equatable {
  const PageDetailState();

  @override
  List<Object?> get props => [];
}

class PageDetailStateLoading<T extends DataRecord> extends PageDetailState<T> {}

class PageDetailStateRecordReady<T extends DataRecord>
    extends PageDetailState<T> {
  final T record;

  const PageDetailStateRecordReady({required this.record});
}
