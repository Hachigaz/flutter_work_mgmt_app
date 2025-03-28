import 'dart:io';

import 'package:formz/formz.dart';

enum ReportFormImageInputError {
  empty(message: "Trường này không được để trống");

  final String message;

  const ReportFormImageInputError({required this.message});
}

class ReportFormImageFieldInput
    extends FormzInput<File?, ReportFormImageInputError> {
  const ReportFormImageFieldInput.pure([super.value]) : super.pure();
  const ReportFormImageFieldInput.dirty([super.value]) : super.dirty();

  @override
  ReportFormImageInputError? validator(File? value) {
    if (value == null) {
      return ReportFormImageInputError.empty;
    }
    return null;
  }
}
