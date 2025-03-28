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
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;

    List<Widget> formInputs = [];
    final formBloc = context.read<ReportFormBloc>();
    formInputs.add(
      Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            style: typography.lg.copyWith(fontWeight: FontWeight.w800),
            _category.label,
          ),
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
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            style: typography.base.copyWith(fontWeight: FontWeight.w600),
            instance.label,
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
                text: fieldItem.label,
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
            fieldWidget = _TextFieldInputWidget(
              inputKey: inputKey,
              fieldLabel: fieldLabel,
              initialValue: initialValue,
            );
            break;
          case FieldType.textboxLarge:
            fieldWidget = _TextFieldLargeInputWidget(
              inputKey: inputKey,
              fieldLabel: fieldLabel,
              initialValue: initialValue,
            );
            break;
          case FieldType.numberInput:
            fieldWidget = _NumberInputWidget(
              inputKey: inputKey,
              fieldLabel: fieldLabel,
              initialValue: initialValue,
            );
            break;
          case FieldType.image:
            fieldWidget = _ImageInputWidget(
              inputKey: inputKey,
              fieldLabel: fieldLabel,
              initialValue: initialValue as File?,
            );
            break;
          case FieldType.selection:
            fieldWidget = _SelectInputWidget(
              inputKey: inputKey,
              fieldLabel: fieldLabel,
              initialValue: initialValue,
              fieldOptions: fieldItem.extra?.selectionOptions ?? [],
            );
            break;
          case FieldType.radio:
            fieldWidget = _RadioInputWidget(
              inputKey: inputKey,
              fieldLabel: fieldLabel,
              initialValue: initialValue,
              fieldOptions: fieldItem.extra?.radioFieldOptions ?? [],
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
