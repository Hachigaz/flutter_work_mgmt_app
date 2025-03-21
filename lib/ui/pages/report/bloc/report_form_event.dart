part of "report_form_bloc.dart";

sealed class ReportFormEvent {
  const ReportFormEvent();
}

final class ReportFormInit extends ReportFormEvent {
  const ReportFormInit();
}

final class ReportFormInputChange<T> extends ReportFormEvent {
  final String inputKey;
  T value;

  ReportFormInputChange({required this.inputKey, required this.value});
}

final class ReportFormSubmit extends ReportFormEvent {
  const ReportFormSubmit();
}
