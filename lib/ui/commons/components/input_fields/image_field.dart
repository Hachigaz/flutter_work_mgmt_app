import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/input_style_presets.dart';

class ImagePickerField extends StatefulWidget {
  final Widget? label;
  final _imagePicker = ImagePicker();
  final FormFieldState<File?>? state;
  final File? _initValue;
  final ValueChanged<File?>? onChanged; // Accept onChanged

  ImagePickerField({
    super.key,
    this.label,
    this.state,
    File? initValue,
    this.onChanged,
  }) : _initValue = initValue;

  // Inside build method:
  @override
  State<StatefulWidget> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImagePickerField> {
  ValueNotifier<File?> inputImage = ValueNotifier(null);

  @override
  void initState() {
    inputImage.value = widget._initValue;
    super.initState();
  }

  void _onPressPickImage() {
    final imageResult = widget._imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    imageResult.then((image) {
      if (image != null) _updateSelectedImage(image);
    });
  }

  void _onPressCamera() {
    final imageResult = widget._imagePicker.pickImage(
      source: ImageSource.camera,
    );
    imageResult.then((image) {
      if (image != null) {
        _updateSelectedImage(image);
      }
    });
  }

  void _updateSelectedImage(XFile image) {
    inputImage.value = File(image.path);
    widget.state?.didChange(inputImage.value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: padding_sm),
          child: widget.label,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: padding_lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              OutlinedButton(
                style: button_style_default,
                onPressed: _onPressPickImage,
                child: Text("Ảnh từ thư viện"),
              ),
              OutlinedButton(
                style: button_style_default,
                onPressed: _onPressCamera,
                child: Text("Camera"),
              ),
            ],
          ),
        ),
        ValueListenableBuilder<File?>(
          valueListenable: inputImage,
          builder: (_, value, __) {
            if (value != null) {
              return Image.file(value);
            } else {
              return SizedBox();
            }
          },
        ),
        if (widget.state?.errorText != null)
          Padding(
            padding: EdgeInsets.symmetric(vertical: padding_md),
            child: Text(
              style: appThemeData.typography.sm.copyWith(
                color: appThemeData.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
              widget.state!.errorText!,
            ),
          ),
      ],
    );
  }
}

class ImagePickerFormField extends FormField<File> {
  ImagePickerFormField({
    super.key,
    Widget? label,
    super.validator,
    onChanged,
    File? initValue,
  }) : super(
         builder: (FormFieldState<File> state) {
           return ImagePickerField(
             label: label,
             state: state,
             initValue: initValue,
             onChanged: (file) {
               state.didChange(file);
               onChanged(file);
             },
           );
         },
       );
}
