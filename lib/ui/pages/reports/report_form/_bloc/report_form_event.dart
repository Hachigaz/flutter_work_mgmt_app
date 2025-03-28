part of "report_form_bloc.dart";

sealed class ReportFormEvent {
  const ReportFormEvent();
}

final class ReportFormInit extends ReportFormEvent {
  const ReportFormInit();
}

final class ReportFormInputChange extends ReportFormEvent {
  final String inputKey;
  final FieldType fieldType;
  final dynamic value;

  ReportFormInputChange({
    required this.inputKey,
    required this.fieldType,
    required this.value,
  });
}

final class ReportFormSubmit extends ReportFormEvent {
  const ReportFormSubmit();
}
