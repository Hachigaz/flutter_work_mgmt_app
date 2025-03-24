import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/commons/form_builder/bloc/mock_data.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/commons/form_builder/models/form_inputs.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/commons/form_builder/models/models.dart';

part "report_form_event.dart";
part "report_form_state.dart";

class ReportFormBloc extends Bloc<ReportFormEvent, ReportFormState> {
  final ID reportFormStructureId;
  final ID? reportFormId;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final ReportFormStructure formStructure;
  final BuildType buildType;

  bool isInReadyState = false;

  ReportFormBloc({
    required this.buildType,
    required this.reportFormStructureId,
    required this.reportFormId,
  }) : super(ReportFormStateInital()) {
    on<ReportFormInit>(_onReportFormInit);
    on<ReportFormInputChange>(_onFormInputChange);
    on<ReportFormSubmit>(_onSaveReportForm);
    add(ReportFormInit());
  }

  //get form data and structure from given id, then change the state to ready state to trigger form building
  _onReportFormInit(
    ReportFormInit submit,
    Emitter<ReportFormState> emit,
  ) async {
    emit(ReportFormStateLoading());

    formStructure = await Future<ReportFormStructure>.delayed(
      Duration(seconds: 1),
      () => mockFormStructure,
    );

    TaskReportRecord? reportRecord;
    if (reportFormId != null) {
      reportRecord = await Future<TaskReportRecord>.delayed(
        Duration(seconds: 1),
        () => mockReportRecord,
      );
    }
    //generate formz input for each available reportdata
    // emit(ReportFormStateReady(formInputs: reportRecord!.reportData!));
    final reportData = reportRecord!.reportData!;
    final formInputs = FormInputMap();

    for (final inputData in reportData.serialData.entries) {
      final inputValueType = inputData.value.$1;
      final inputValue = inputData.value.$2;
      switch (inputValueType) {
        case FieldType.textbox || FieldType.textboxLarge:
          formInputs[inputData.key] = ReportFormTextFieldInput.pure(inputValue);
          break;
        case FieldType.numberInput:
          formInputs[inputData.key] = ReportFormNumberFieldInput.pure(
            inputValue,
          );
          break;
        case FieldType.image:
          formInputs[inputData.key] = ReportFormImageFieldInput.pure(
            reportData.images[inputData.key],
          );
        case FieldType.selection:
          formInputs[inputData.key] = ReportFormSelectFieldInput.pure(
            inputValue,
          );
        case FieldType.radio:
          formInputs[inputData.key] = ReportFormRadioFieldInput.pure(
            inputValue,
          );
      }
    }
    emit(ReportFormStateReady(formInputs: formInputs));
    print(formInputs);
  }

  _onFormInputChange<T>(
    ReportFormInputChange<T> event,
    Emitter<ReportFormState> emit,
  ) {
    // final formState = (state as ReportFormStateReady);
    // var formInput = formState.formInputs[event.inputKey];
    // var newInput;
    // if (event is ReportFormInputChange<String>) {
    //   final eventValue = event.value as String;
    //   newInput = ReportFormTextFieldInput.dirty(eventValue);
    // } else if (event is ReportFormInputChange<(String, bool)>) {
    //   final eventValue = event.value as (String, bool);
    //   if (formInput is ReportFormRadioFieldInput) {
    //     newInput = ReportFormRadioFieldInput.dirty(eventValue.$1);
    //   } else if (formInput is ReportFormSelectFieldInput) {
    //     final fieldValues = formInput.value;
    //     if (eventValue.$2) {
    //       fieldValues.add(eventValue.$1);
    //     } else {
    //       fieldValues.remove(eventValue.$1);
    //     }
    //     newInput = ReportFormSelectFieldInput.dirty(fieldValues);
    //   } else {
    //     throw UnimplementedError();
    //   }
    // } else if (event is ReportFormInputChange<Image>) {
    //   final eventValue = event.value as File?;
    //   newInput = ReportFormImageFieldInput.dirty(eventValue);
    // } else {
    //   throw UnimplementedError();
    // }
    // formState.formInputs[event.inputKey] = newInput;
    // emit(
    //   formState.copyWith(
    //     formInputs: formState.formInputs,
    //     isValid: Formz.validate([newInput]),
    //   ),
    // );

    // emit(ReportFormStateReady(formInputs: formState.formInputs));

    // switched from formdata to formz
    // formData.serialData[event.inputKey] = eventValue;
  }

  _onSaveReportForm(ReportFormSubmit submit, Emitter<ReportFormState> emit) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //cast from form inputs to form data type
      final blocState = state as ReportFormStateReady;
      final formInputs = blocState.formInputs;

      final formData = ReportFormData(
        serialData: <String, DataField>{},
        images: <String, File?>{},
      );

      for (final input in formInputs.entries) {
        if (input.value is ReportFormTextFieldInput) {
          formData.serialData[input.key] = (
            FieldType.textbox,
            input.value.value,
          );
        } else if (input.value is ReportFormNumberFieldInput) {
          formData.serialData[input.key] = (
            FieldType.numberInput,
            input.value.value,
          );
        } else if (input.value is ReportFormSelectFieldInput) {
          formData.serialData[input.key] = (
            FieldType.selection,
            input.value.value,
          );
        } else if (input.value is ReportFormRadioFieldInput) {
          formData.serialData[input.key] = (FieldType.radio, input.value.value);
        } else if (input.value is ReportFormImageFieldInput) {
          formData.serialData[input.key] = (FieldType.image, input.value.value);
        }
      }
      //save images
      print(formData.serialData);
    }
  }
}
