import 'dart:convert';
import 'dart:io';

import 'package:flutter_work_mgmt_app/commons/models/model.dart';

enum BuildType {
  // ignore: constant_identifier_names
  type_default(label: "Default"),
  // ignore: constant_identifier_names
  type_read_only(label: "Read Only");

  final String label;
  const BuildType({required this.label});
}

typedef DataField = (FieldType, dynamic);

class ReportFormData {
  //dynamic = stirng, list string
  final Map<String, DataField> _serialData;
  final Map<String, File?> images;

  ReportFormData({
    required Map<String, DataField> serialData,
    required this.images,
  }) : _serialData = serialData;

  Map<String, DataField> get serialData => _serialData;

  Map<String, dynamic> toJson() => {
    "serialData": [
      for (final data in _serialData.entries)
        {
          "key": data.key,
          "type": data.value.$1.toJson(),
          "value": data.value.$2,
        },
    ],
  };

  factory ReportFormData.fromJson(Map<String, dynamic> json) {
    final serialData = <String, DataField>{};
    for (final data in json["serialData"]) {
      serialData[data["key"]] = (
        FieldType.values.byName(data["type"]),
        jsonDecode(data["value"]),
      );
    }
    return ReportFormData(
      serialData: serialData,
      images: <String, File?>{}, //này tính sau
    );
  }
}

class SelectionFieldOption {
  final String label;
  final String name;

  SelectionFieldOption({required this.label, required this.name});

  Map<String, dynamic> toJson() => {'label': label, 'name': name};

  factory SelectionFieldOption.fromJson(Map<String, dynamic> json) {
    return SelectionFieldOption(label: json["label"], name: json["name"]);
  }
}

class RadioFieldOption {
  final String label;
  final String name;

  RadioFieldOption({required this.label, required this.name});

  Map<String, dynamic> toJson() => {'label': label, 'name': name};

  factory RadioFieldOption.fromJson(Map<String, dynamic> json) {
    return RadioFieldOption(label: json["label"], name: json["name"]);
  }
}

enum FieldType {
  textbox(label: "Textbox"),
  textboxLarge(label: "Textbox Large"),
  numberInput(label: "Number"),
  image(label: "Image"),
  selection(label: "Selection"),
  radio(label: "Radio");

  final String label;

  const FieldType({required this.label});

  String toJson() => name;
}

class FormFieldItemExtra {
  final List<SelectionFieldOption>? selectionOptions;
  final List<RadioFieldOption>? radioFieldOptions;
  final int? imageCount;

  FormFieldItemExtra({
    required this.selectionOptions,
    required this.radioFieldOptions,
    required this.imageCount,
  });

  Map<String, dynamic> toJson() => {
    "selectionOptions": selectionOptions,
    "radioFieldOptions": radioFieldOptions,
    "imageCount": imageCount,
  };

  factory FormFieldItemExtra.fromJson(Map<String, dynamic> json) {
    return FormFieldItemExtra(
      selectionOptions:
          (json["selectionOptions"] != null)
              ? [
                for (final option in json["selectionOptions"])
                  SelectionFieldOption.fromJson(option),
              ]
              : null,
      radioFieldOptions:
          (json["radioFieldOptions"] != null)
              ? [
                for (final option in json["radioFieldOptions"])
                  RadioFieldOption.fromJson(option),
              ]
              : null,
      imageCount: json["imageCount"],
    );
  }
}

class FormFieldItem {
  final int fieldItemIndex;
  final String label;
  final String name;
  final FieldType type;
  final FormFieldItemExtra? extra;
  final bool required;

  FormFieldItem({
    required this.fieldItemIndex,
    required this.label,
    required this.name,
    required this.type,
    required this.extra,
    required this.required,
  });

  Map<String, dynamic> toJson() => {
    "fieldItemIndex": fieldItemIndex,
    "label": label,
    "name": name,
    "type": type,
    "extra": extra,
    "required": required,
  };

  factory FormFieldItem.fromJson(Map<String, dynamic> json) {
    return FormFieldItem(
      fieldItemIndex: json["fieldItemIndex"],
      label: json["label"],
      name: json["name"],
      type: FieldType.values.byName(json["type"] as String),
      extra:
          (json["extra"] != null)
              ? FormFieldItemExtra.fromJson(
                json["extra"] as Map<String, dynamic>,
              )
              : null,
      required: json["required"],
    );
  }
}

class InputInstance {
  final int instanceIndex;
  final String label;
  final String name;

  InputInstance({
    required this.instanceIndex,
    required this.label,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    "instanceIndex": instanceIndex,
    "label": label,
    "name": name,
  };

  factory InputInstance.fromJson(Map<String, dynamic> json) {
    return InputInstance(
      instanceIndex: json["instanceIndex"],
      label: json["label"],
      name: json["name"],
    );
  }
}

class FormCategory {
  final int categoryIndex;
  final String label;
  // list of fields and count of inputs for these field
  final List<FormFieldItem> fields;
  final List<InputInstance> inputInstances;

  FormCategory({
    required this.categoryIndex,
    required this.label,
    required this.fields,
    required this.inputInstances,
  });

  Map<String, dynamic> toJson() => {
    "categoryIndex": categoryIndex,
    "label": label,
    "fields": fields,
    "inputInstances": inputInstances,
  };

  factory FormCategory.fromJson(Map<String, dynamic> json) {
    return FormCategory(
      categoryIndex: json["categoryIndex"],
      label: json["label"],
      fields: [
        for (final input in json["fields"]) FormFieldItem.fromJson(input),
      ],
      inputInstances: [
        for (final input in json["inputInstances"])
          InputInstance.fromJson(input),
      ],
    );
  }
}

class FormSubsection {
  final int subsectionIndex;
  final String label;
  final Map<String, FormCategory> categories;

  FormSubsection({
    required this.subsectionIndex,
    required this.label,
    required this.categories,
  });

  Map<String, dynamic> toJson() => {
    "subsectionIndex": subsectionIndex,
    "label": label,
    "categories": categories,
  };

  factory FormSubsection.fromJson(Map<String, dynamic> json) {
    return FormSubsection(
      subsectionIndex: json["subsectionIndex"],
      label: json["label"],
      categories: (json["categories"] as Map<String, dynamic>)
          .map<String, FormCategory>(
            (name, section) => MapEntry(name, FormCategory.fromJson(section)),
          ),
    );
  }
}

class FormSection {
  final int sectionIndex;
  final String label;
  final Map<String, FormSubsection> subsections;

  FormSection({
    required this.sectionIndex,
    required this.label,
    required this.subsections,
  });

  Map<String, dynamic> toJson() => {
    "sectionIndex": sectionIndex,
    "label": label,
    "subsections": subsections,
  };

  factory FormSection.fromJson(Map<String, dynamic> json) {
    return FormSection(
      sectionIndex: json["sectionIndex"],
      label: json["label"],
      subsections: (json["subsections"] as Map<String, dynamic>)
          .map<String, FormSubsection>(
            (name, section) => MapEntry(name, FormSubsection.fromJson(section)),
          ),
    );
  }
}

class ReportFormStructure {
  final ID structureId;
  final String label;
  final Map<String, FormSection> sections;

  ReportFormStructure({
    required this.structureId,
    required this.label,
    required this.sections,
  });

  Map<String, dynamic> toJson() => {
    "structureId": structureId,
    "label": label,
    "sections": sections,
  };

  factory ReportFormStructure.fromJson(Map<String, dynamic> json) {
    return ReportFormStructure(
      structureId: json["structureId"],
      label: json["label"],
      sections: (json["sections"] as Map<String, dynamic>)
          .map<String, FormSection>(
            (name, section) => MapEntry(name, FormSection.fromJson(section)),
          ),
    );
  }
}
