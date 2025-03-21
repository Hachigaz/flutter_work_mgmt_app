import 'dart:io';

import 'package:formz/formz.dart';

enum ReportFormTextInputError {
  empty(message: "Trường này không được để trống"),
  invalid(message: "Giá trị không hợp lệ");

  final String message;

  const ReportFormTextInputError({required this.message});
}

class ReportFormTextFieldInput
    extends FormzInput<String, ReportFormTextInputError> {
  const ReportFormTextFieldInput.pure([super.value = '']) : super.pure();
  const ReportFormTextFieldInput.dirty([super.value = '']) : super.dirty();

  @override
  ReportFormTextInputError? validator(String value) {
    if (value.isEmpty) {
      return ReportFormTextInputError.empty;
    }
    return null;
  }
}

enum ReportFormNumberInputError {
  empty(message: "Trường này không được để trống"),
  not_a_number(message: "Giá trị không phải là số");

  final String message;

  const ReportFormNumberInputError({required this.message});
}

class ReportFormNumberFieldInput
    extends FormzInput<String, ReportFormNumberInputError> {
  const ReportFormNumberFieldInput.pure([super.value = ""]) : super.pure();
  const ReportFormNumberFieldInput.dirty([super.value = ""]) : super.dirty();

  @override
  ReportFormNumberInputError? validator(String value) {
    if (value.isEmpty) {
      return ReportFormNumberInputError.empty;
    }
    return null;
  }
}

enum ReportFormSelectInputError {
  empty(message: "Trường này không được để trống");

  final String message;

  const ReportFormSelectInputError({required this.message});
}

class ReportFormSelectFieldInput
    extends FormzInput<List<String>, ReportFormSelectInputError> {
  const ReportFormSelectFieldInput.pure([super.value = const <String>[]])
    : super.pure();
  const ReportFormSelectFieldInput.dirty([super.value = const <String>[]])
    : super.dirty();

  @override
  ReportFormSelectInputError? validator(List<String> value) {
    if (value.isEmpty) {
      return ReportFormSelectInputError.empty;
    }
    return null;
  }
}

enum ReportFormRadioInputError {
  empty(message: "Trường này không được để trống");

  final String message;

  const ReportFormRadioInputError({required this.message});
}

class ReportFormRadioFieldInput
    extends FormzInput<String?, ReportFormRadioInputError> {
  const ReportFormRadioFieldInput.pure([super.value]) : super.pure();
  const ReportFormRadioFieldInput.dirty([super.value]) : super.dirty();

  @override
  ReportFormRadioInputError? validator(String? value) {
    if (value == null) {
      return ReportFormRadioInputError.empty;
    }
    return null;
  }
}

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
