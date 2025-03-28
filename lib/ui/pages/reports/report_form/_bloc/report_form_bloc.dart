import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_helpers/helpers.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/bloc/report_detail_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_models/form_inputs.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_models/models.dart';

part "report_form_event.dart";
part "report_form_state.dart";

class ReportFormBloc extends Bloc<ReportFormEvent, ReportFormState> {
  final ReportDetailBloc _reportDetailBloc;
  final DataRepository<ReportFormTemplateRecord> _formTemplateRepo;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final ReportFormStructure formStructure;
  final BuildType buildType;

  bool isInReadyState = false;

  ReportFormBloc({
    required ReportDetailBloc reportDetailBloc,
    required this.buildType,
    required DataRepository<ReportFormTemplateRecord> formTemplateRepo,
  }) : _reportDetailBloc = reportDetailBloc,
       _formTemplateRepo = formTemplateRepo,
       super(ReportFormStateInital()) {
    on<ReportFormInit>(_onReportFormInit);
    on<ReportFormInputChange>(_onFormInputChange);
    on<ReportFormSubmit>(_onSaveReportForm);
    add(ReportFormInit());
  }

  //get form data and structure from given id, then change the state to ready state to trigger form building
  _onReportFormInit(ReportFormInit event, Emitter<ReportFormState> emit) async {
    //make sure report detail bloc state is ready
    if (_reportDetailBloc.state is! ReportDetailStateRecordReady) {
      throw Exception("Unexpected Error");
    }
    final reportDetailState =
        _reportDetailBloc.state as ReportDetailStateRecordReady;

    emit(ReportFormStateLoading());

    //should be replaced with
    // formStructure = reportDetailState.record.reportStructure;
    formStructure = await Future<ReportFormStructure>.delayed(
      Duration(seconds: 1),
      () {
        final formTemplate = _formTemplateRepo.getOne();
        return ReportFormStructure.fromJson(
          jsonDecode(formTemplate.formStructureData),
        );
      },
    );

    TaskReportRecord reportRecord = reportDetailState.reportRecord;

    //parse the available form data to formz map or generate one if not available
    final formInputs =
        (reportRecord.reportData != null)
            ? parseFormDataToFormz(reportRecord.reportData!)
            : generateEmptyForm(formStructure);

    emit(ReportFormStateReady(formInputs: formInputs, lastChangedValue: ""));
  }

  _onFormInputChange<T>(
    ReportFormInputChange event,
    Emitter<ReportFormState> emit,
  ) {
    final state = (this.state as ReportFormStateReady);
    late final FormzInput<dynamic, dynamic> newInput;
    switch (event.fieldType) {
      case FieldType.textbox:
        if (event.value is! String) {
          throw (Exception("Invalid Value Type"));
        }
        newInput = ReportFormTextFieldInput.dirty(event.value);
        break;
      case FieldType.textboxLarge:
        if (event.value is! String) {
          throw (Exception("Invalid Value Type"));
        }
        newInput = ReportFormTextFieldLargeInput.dirty(event.value);
        break;
      case FieldType.numberInput:
        if (event.value is! String) {
          throw (Exception("Invalid Value Type"));
        }
        newInput = ReportFormNumberFieldInput.dirty(event.value);
        break;
      case FieldType.image:
        if (event.value is! File) {
          throw (Exception("Invalid Value Type"));
        }
        newInput = ReportFormImageFieldInput.dirty(event.value);
        break;
      case FieldType.selection:
        if (event.value is! (String, bool)) {
          throw (Exception("Invalid Value Type"));
        }
        final inputValue = [
          ...(state.formInputs[event.inputKey] as ReportFormSelectFieldInput)
              .value,
        ];
        final eventValue = event.value as (String, bool);
        if (eventValue.$2) {
          inputValue.add(eventValue.$1);
        } else {
          inputValue.remove(eventValue.$1);
        }
        newInput = ReportFormSelectFieldInput.dirty(inputValue);
        break;
      case FieldType.radio:
        if (event.value is! (String, bool)) {
          throw (Exception("Invalid Value Type"));
        }
        final eventValue = event.value as (String, bool);
        newInput = ReportFormRadioFieldInput.dirty(eventValue.$1);
        break;
    }

    state.formInputs[event.inputKey] = newInput;

    Formz.validate([newInput]);

    emit(
      state.copyWith(
        formInputs: state.formInputs,
        lastChangedValue: event.inputKey,
      ),
    );

    // switched from formdata to formz
    // formData.serialData[event.inputKey] = eventValue;
  }

  _onSaveReportForm(ReportFormSubmit submit, Emitter<ReportFormState> emit) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //cast from form inputs to form data type
      final state = this.state as ReportFormStateReady;
      final formInputs = state.formInputs;

      final validationResult = _validateAllFields();

      if (!validationResult) {
        emit(state.copyWith(lastChangedValue: "all"));
      }

      final formData = extractValues(formInputs);

      print(
        "VALIDATION RESULT $validationResult MESSAGE LENGTH ${formData.serialData.toString().length}",
      );

      print(jsonEncode(formData));
    }
  }

  bool _validateAllFields() {
    if (this.state is! ReportFormStateReady) {
      throw Exception("Unexpected Error");
    }

    final state = this.state as ReportFormStateReady;

    for (final field in state.formInputs.entries) {
      if (field.value is ReportFormTextFieldInput) {
        state.formInputs[field.key] = ReportFormTextFieldInput.dirty(
          field.value.value,
        );
      } else if (field.value is ReportFormTextFieldLargeInput) {
        state.formInputs[field.key] = ReportFormTextFieldLargeInput.dirty(
          field.value.value,
        );
      } else if (field.value is ReportFormNumberFieldInput) {
        state.formInputs[field.key] = ReportFormNumberFieldInput.dirty(
          field.value.value,
        );
      } else if (field.value is ReportFormRadioFieldInput) {
        state.formInputs[field.key] = ReportFormRadioFieldInput.dirty(
          field.value.value,
        );
      } else if (field.value is ReportFormSelectFieldInput) {
        state.formInputs[field.key] = ReportFormSelectFieldInput.dirty(
          field.value.value,
        );
      } else if (field.value is ReportFormImageFieldInput) {
        state.formInputs[field.key] = ReportFormImageFieldInput.dirty(
          field.value.value,
        );
      } else {
        throw Exception("Unexpected Error");
      }
    }

    return Formz.validate(state.formInputs.values.toList());
  }
}
