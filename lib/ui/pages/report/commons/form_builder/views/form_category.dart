part of "report_form.dart";

const nullValidationEnabled = false;

class _FormCategoryWidget extends StatelessWidget {
  final FormCategory _category;
  final String _parentRefKey;

  const _FormCategoryWidget({
    required FormCategory category,
    required String parentRefKey,
  }) : _category = category,
       _parentRefKey = parentRefKey;

  @override
  Widget build(BuildContext context) {
    List<Widget> formInputs = [];
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    final formBloc = context.read<ReportFormBloc>();
    final presets = context.read<ThemeBloc>().state.presets;
    formInputs.add(
      Padding(
        padding: EdgeInsets.only(top: padding_xl, bottom: padding_md),
        child: Text(
          style: typography.base.copyWith(fontWeight: FontWeight.w600),
          "Category ${_category.label}",
        ),
      ),
    );
    // _category instance loop
    for (final InputInstance instance in _category.inputInstances) {
      // add spacing between instances
      if (instance != _category.inputInstances.first) {
        formInputs.add(
          Divider(
            color: colorScheme.foreground,
            thickness: 1,
            height: spacing_2xl,
          ),
        );
      }
      // add instance label
      formInputs.add(
        Padding(
          padding: EdgeInsets.only(bottom: padding_md),
          child: Text(
            style: typography.sm.copyWith(fontWeight: FontWeight.w600),
            "Instance ${instance.label}",
          ),
        ),
      );

      // input fields for each instance loop
      for (final FormFieldItem fieldItem in _category.fields) {
        // key id for each field
        final inputKey =
            "${_parentRefKey}_${_category.categoryIndex}_${instance.instanceIndex}_${fieldItem.fieldItemIndex}";

        //field value loaded from form data
        final initialValue =
            (formBloc.state as ReportFormStateReady)
                .formInputs[inputKey]
                ?.value;

        // add label for each field
        Widget fieldLabel = Text.rich(
          TextSpan(
            children: [
              TextSpan(
                style: typography.sm.copyWith(fontWeight: FontWeight.w500),
                text:
                    "${fieldItem.type.label} Input ${fieldItem.label} - $inputKey",
              ),
              if (fieldItem.required)
                TextSpan(
                  text: "*",
                  style: typography.base.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.theme.colorScheme.error,
                  ),
                ),
            ],
          ),
        );

        Widget fieldWidget;

        switch (fieldItem.type) {
          case FieldType.textbox:
            fieldWidget = TextFormField(
              initialValue: initialValue as String?,
              style: typography.base,
              cursorColor: colorScheme.primary,
              cursorErrorColor: colorScheme.error,
              keyboardType: TextInputType.text,
              decoration: presets.input_dec_bordered.copyWith(
                label: fieldLabel,
              ),
              onChanged: (value) {
                context.read<ReportFormBloc>().add(
                  ReportFormInputChange<String>(
                    value: value,
                    inputKey: inputKey,
                  ),
                );
              },
              maxLines: 1,
            );
            break;
          case FieldType.textboxLarge:
            fieldWidget = TextFormField(
              initialValue: initialValue as String?,
              style: typography.base,
              cursorColor: colorScheme.primary,
              cursorErrorColor: colorScheme.error,
              keyboardType: TextInputType.text,
              decoration: presets.input_dec_bordered.copyWith(
                label: fieldLabel,
              ),
              onChanged: (value) {
                context.read<ReportFormBloc>().add(
                  ReportFormInputChange<String>(
                    value: value,
                    inputKey: inputKey,
                  ),
                );
              },
              minLines: 4,
              maxLines: 10,
            );
            break;
          case FieldType.numberInput:
            fieldWidget = TextFormField(
              initialValue: initialValue as String?,
              style: typography.base,
              cursorColor: colorScheme.primary,
              cursorErrorColor: colorScheme.error,
              keyboardType: TextInputType.text,
              decoration: presets.input_dec_bordered.copyWith(
                label: fieldLabel,
              ),
              onChanged: (value) {
                context.read<ReportFormBloc>().add(
                  ReportFormInputChange<String>(
                    value: value,
                    inputKey: inputKey,
                  ),
                );
              },
              minLines: 1,
            );
            break;
          case FieldType.image:
            fieldWidget = ImagePickerFormField(
              label: fieldLabel,
              initValue: initialValue,
              onChanged:
                  (file) => {
                    context.read<ReportFormBloc>().add(
                      ReportFormInputChange<File>(
                        value: file,
                        inputKey: inputKey,
                      ),
                    ),
                  },
            );
            break;
          case FieldType.selection:
            fieldWidget = FSelectGroup<String>(
              label: fieldLabel,
              items: [
                for (final selectItem in fieldItem.extra!.selectionOptions!)
                  FSelectGroupItem<String>.checkbox(
                    value: selectItem.name,

                    label: Text(selectItem.label),
                  ),
              ],
              controller: FMultiSelectGroupController(
                values:
                    initialValue != null
                        ? (initialValue as List<String>).toSet()
                        : {},
                onUpdate: (value) {
                  formBloc.add(
                    ReportFormInputChange<(String, bool)>(
                      inputKey: inputKey,
                      value: value,
                    ),
                  );
                },
              ),
            );
            break;
          case FieldType.radio:
            fieldWidget = FSelectGroup<String>(
              label: fieldLabel,
              items: [
                for (final radioItem in fieldItem.extra!.radioFieldOptions!)
                  FSelectGroupItem<String>.radio(
                    value: radioItem.name,
                    label: Text(radioItem.label),
                  ),
              ],
              controller: FRadioSelectGroupController(
                value: initialValue as String?,
                onUpdate: (value) {
                  formBloc.add(
                    ReportFormInputChange<(String, bool)>(
                      inputKey: inputKey,
                      value: value,
                    ),
                  );
                },
              ),
            );
            break;
        }

        formInputs.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: padding_sm),
            child: fieldWidget,
          ),
        );
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        top: padding_sm,
        bottom: padding_sm,
        left: padding_sm,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: formInputs,
      ),
    );
  }
}
