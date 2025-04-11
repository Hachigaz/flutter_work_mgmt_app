import 'dart:io';

import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_models/_inputs/form_inputs.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_models/models.dart';
import 'package:formz/formz.dart';

FormzInputMap generateEmptyForm(ReportFormStructure structure) {
  final inputMap = <String, FormzInput<dynamic, dynamic>>{};
  for (final section in structure.sections.entries) {
    final sectionIndex = section.value.sectionIndex;
    for (final subsection in section.value.subsections.entries) {
      final subsectionIndex = subsection.value.subsectionIndex;
      for (final category in subsection.value.categories.entries) {
        final categoryIndex = category.value.categoryIndex;
        for (final inputInstance in category.value.inputInstances) {
          final instanceIndex = inputInstance.instanceIndex;
          for (final field in category.value.fields) {
            final fieldIndex = field.fieldItemIndex;
            final fieldKey =
                "${sectionIndex}_${subsectionIndex}_${categoryIndex}_${instanceIndex}_$fieldIndex";

            late final FormzInput<dynamic, dynamic> formzField;

            switch (field.type) {
              case FieldType.textbox:
                formzField = ReportFormTextFieldInput.pure();
                break;
              case FieldType.textboxLarge:
                formzField = ReportFormTextFieldLargeInput.pure();
                break;
              case FieldType.numberInput:
                formzField = ReportFormNumberFieldInput.pure();
                break;
              case FieldType.image:
                formzField = ReportFormImageFieldInput.pure();
                break;
              case FieldType.selection:
                formzField = ReportFormSelectFieldInput.pure();
                break;
              case FieldType.radio:
                formzField = ReportFormRadioFieldInput.pure();
                break;
            }
            inputMap[fieldKey] = formzField;
          }
        }
      }
    }
  }
  return inputMap;
}

FormzInputMap parseFormDataToFormz(ReportFormData formData) {
  final FormzInputMap formInputs = FormzInputMap();
  for (final inputData in formData.serialData.entries) {
    final inputValueType = inputData.value.$1;
    final inputValue = inputData.value.$2;
    switch (inputValueType) {
      case FieldType.textbox:
        formInputs[inputData.key] = ReportFormTextFieldInput.pure(inputValue);
        break;
      case FieldType.textboxLarge:
        formInputs[inputData.key] = ReportFormTextFieldLargeInput.pure(
          inputValue,
        );
        break;
      case FieldType.numberInput:
        formInputs[inputData.key] = ReportFormNumberFieldInput.pure(inputValue);
        break;
      case FieldType.image:
        formInputs[inputData.key] = ReportFormImageFieldInput.pure(
          formData.images[inputData.key],
        );
      case FieldType.selection:
        formInputs[inputData.key] = ReportFormSelectFieldInput.pure(inputValue);
      case FieldType.radio:
        formInputs[inputData.key] = ReportFormRadioFieldInput.pure(inputValue);
    }
  }
  return formInputs;
}

ReportFormData extractValues(FormzInputMap inputMap) {
  final ReportFormData formData = ReportFormData.empty();

  for (final input in inputMap.entries) {
    if (input.value is ReportFormTextFieldInput) {
      formData.serialData[input.key] = (FieldType.textbox, input.value.value);
    } else if (input.value is ReportFormTextFieldLargeInput) {
      formData.serialData[input.key] = (
        FieldType.textboxLarge,
        input.value.value,
      );
    } else if (input.value is ReportFormNumberFieldInput) {
      formData.serialData[input.key] = (
        FieldType.numberInput,
        input.value.value,
      );
    } else if (input.value is ReportFormSelectFieldInput) {
      formData.serialData[input.key] = (FieldType.selection, input.value.value);
    } else if (input.value is ReportFormRadioFieldInput) {
      formData.serialData[input.key] = (FieldType.radio, input.value.value);
    } else if (input.value is ReportFormImageFieldInput) {
      final inputValue = input.value.value as File?;
      if (inputValue != null) {
        formData.serialData[input.key] = (FieldType.image, inputValue.path);
        formData.images[input.key] = inputValue;
      } else {
        formData.serialData[input.key] = (FieldType.image, null);
      }
    }
  }
  return formData;
}
