part of "report_detail_bloc.dart";

class ReportDetailState extends Equatable {
  const ReportDetailState();

  @override
  List<Object?> get props => [];
}

class ReportDetailStateLoading extends ReportDetailState {}

class ReportDetailStateReady extends ReportDetailState {
  const ReportDetailStateReady();
}
