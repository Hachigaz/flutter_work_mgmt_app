part of "report_form_bloc.dart";

class ReportFormState {
  const ReportFormState();
}

class ReportFormStateInital extends ReportFormState {
  const ReportFormStateInital();
}

class ReportFormStateLoading extends ReportFormState {
  const ReportFormStateLoading();
}

class ReportFormStateReady extends ReportFormState {
  final FormzInputMap formInputs;
  final String lastChangedValue;
  final FormzSubmissionStatus status;
  const ReportFormStateReady({
    required this.formInputs,
    required this.lastChangedValue,
    this.status = FormzSubmissionStatus.initial,
  });

  ReportFormStateReady copyWith({
    FormzInputMap? formInputs,
    String? lastChangedValue,
    FormzSubmissionStatus? status,
  }) {
    return ReportFormStateReady(
      formInputs: formInputs ?? this.formInputs,
      lastChangedValue: lastChangedValue ?? this.lastChangedValue,
      status: status ?? this.status,
    );
  }
}
