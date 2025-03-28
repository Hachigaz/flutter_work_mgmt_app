import 'package:formz/formz.dart';

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
