part of "report_form_bloc.dart";

// typedef FormInputMap = Map<String, dynamic>;
// typedef FormInputMap = ReportFormData;
typedef FormInputMap = Map<String, FormzInput<dynamic, dynamic>>;

class ReportFormState extends Equatable {
  const ReportFormState();
  @override
  List<Object?> get props => [];
}

class ReportFormStateInital extends ReportFormState {
  const ReportFormStateInital();
}

class ReportFormStateLoading extends ReportFormState {
  const ReportFormStateLoading();
}

class ReportFormStateReady extends ReportFormState {
  final FormInputMap formInputs;
  final bool isValid;
  final FormzSubmissionStatus status;
  const ReportFormStateReady({
    required this.formInputs,
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  @override
  List<Object?> get props => [formInputs, isValid, status];

  ReportFormStateReady copyWith({
    FormInputMap? formInputs,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return ReportFormStateReady(
      formInputs: formInputs ?? this.formInputs,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }
}
