
        // // add form data value if formdata is available
        // dynamic fieldInitValue = formBloc.state.formData.serialData[fieldKey];

        // // add the field
        // Widget fieldWidget;
        // switch (fieldItem.type) {
        //   case FieldType.textbox ||
        //       FieldType.textboxLarge ||
        //       FieldType.numberInput:

        //     // final fieldValidator = fieldValidatorBuilder.build();
        //     switch (fieldItem.type) {
        //       case FieldType.textbox:
        //         fieldWidget = TextFormField(
        //           style: typography.base,
        //           cursorColor: colorScheme.primary,
        //           cursorErrorColor: colorScheme.error,
        //           keyboardType: TextInputType.text,
        //           decoration: input_dec_bordered.copyWith(
        //             label: fieldLabel,
        //             hintText: "Tên đăng nhập",
        //             errorText: displayError?.message,
        //           ),
        //           initialValue: fieldInitValue,
        //           // validator: fieldValidator,
        //         );
        //         break;
        //       case FieldType.textboxLarge:
        //         fieldWidget = TextFormField(
        //           initialValue: fieldInitValue,
        //           // validator: fieldValidator,
        //           label: fieldLabel,
        //           minLines: 3,
        //           onSaved: onSavedCallback,
        //           keyboardType: TextInputType.multiline,
        //         );
        //         break;
        //       case FieldType.numberInput:
        //         fieldWidget = FTextField(
        //           initialValue: fieldInitValue,
        //           // validator: fieldValidator,
        //           label: fieldLabel,
        //           onSaved: onSavedCallback,
        //           keyboardType: TextInputType.numberWithOptions(),
        //           // prefixBuilder: (context, value, child) {
        //           //   return Padding(
        //           //     padding: EdgeInsets.only(left: padding_xl),
        //           //     child: Text("Mức nước", style: typography.sm),
        //           //   );
        //           // },
        //           suffixBuilder: (context, value, child) {
        //             return Padding(
        //               padding: EdgeInsets.only(right: padding_lg),
        //               child: Text("m3", style: typography.sm),
        //             );
        //           },
        //         );
        //         break;
        //       default:
        //         throw ArgumentError("Unexpected field type.");
        //     }
        //     break;
        //   case FieldType.image:
        //     print(fieldInitValue);
        //     fieldWidget = ImagePickerFormField(
        //       label: fieldLabel,
        //       initValue: fieldInitValue,
        //       onSaved: (file) {
        //         if (file != null) {
        //           formBloc.state.formData.serialData[fieldKey] = file;
        //         }
        //       },
        //       validator:
        //           (nullValidationEnabled)
        //               ? fieldItem.required
        //                   ? (file) {
        //                     if (file == null) {
        //                       return "Trường này là bắt buộc";
        //                     }
        //                     return null;
        //                   }
        //                   : null
        //               : null,
        //     );
        //   case FieldType.selection:
        //     break;
        //   case FieldType.radio:
        //     fieldWidget = FSelectGroup<String>(
        //       label: fieldLabel,
        //       onSaved: (newValue) {
        //         formBloc.state.formData.serialData[fieldKey] =
        //             (newValue != null) ? newValue.toList() : null;
        //       },
        //       validator:
        //           (nullValidationEnabled)
        //               ? (value) {
        //                 if (value == null) {
        //                   return ("Trường này là bất buộc");
        //                 }
        //                 return null;
        //               }
        //               : null,
        //       items: [
        //         for (final radioItem in fieldItem.extra!.radioFieldOptions!)
        //           FSelectGroupItem<String>.radio(
        //             value: radioItem.name,
        //             label: Text(radioItem.label),
        //           ),
        //       ],
        //       controller: FRadioSelectGroupController(),
        //     );
        //     break;
        // }