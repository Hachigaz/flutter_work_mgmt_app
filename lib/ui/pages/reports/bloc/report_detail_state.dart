part of "report_detail_bloc.dart";

class ReportDetailStateRecordReady
    extends PageDetailStateRecordReady<ReportSchedule> {
  final TaskReportRecord reportRecord;

  const ReportDetailStateRecordReady({
    required super.record,
    required this.reportRecord,
  });

  @override
  List<Object?> get props => [...super.props, reportRecord];
}
