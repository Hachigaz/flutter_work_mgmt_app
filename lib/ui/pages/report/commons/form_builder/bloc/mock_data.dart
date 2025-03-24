import 'dart:io';

import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/commons/form_builder/models/models.dart';

final List<List<FormFieldItem>> mockFieldsList = [
  [
    FormFieldItem(
      fieldItemIndex: 0,
      label: "label abc1",
      name: "name abc1",
      type: FieldType.textbox,
      extra: null,
      required: false,
    ),
    FormFieldItem(
      fieldItemIndex: 1,
      label: "label abc2",
      name: "name abc2",
      type: FieldType.numberInput,
      extra: null,
      required: true,
    ),
    FormFieldItem(
      fieldItemIndex: 2,
      label: "label abc3",
      name: "name abc3",
      type: FieldType.radio,
      extra: FormFieldItemExtra(
        radioFieldOptions: [
          RadioFieldOption(label: "opt1 lb 1", name: "opt_1_name 1"),
          RadioFieldOption(label: "opt2 lb 1", name: "opt_2_name 1"),
          RadioFieldOption(label: "opt3 lb 1", name: "opt_3_name 1"),
        ],
        selectionOptions: null,
        imageCount: null,
      ),
      required: false,
    ),
    FormFieldItem(
      fieldItemIndex: 3,
      label: "label abc4",
      name: "name abc4",
      type: FieldType.selection,
      extra: FormFieldItemExtra(
        radioFieldOptions: null,
        selectionOptions: [
          SelectionFieldOption(label: "opt1 lb 1", name: "opt_1_name 1"),
          SelectionFieldOption(label: "opt2 lb 1", name: "opt_2_name 1"),
          SelectionFieldOption(label: "opt3 lb 1", name: "opt_3_name 1"),
        ],
        imageCount: null,
      ),
      required: true,
    ),
  ],
  [
    FormFieldItem(
      fieldItemIndex: 4,
      label: "label def1",
      name: "name def1",
      type: FieldType.textboxLarge,
      extra: null,
      required: false,
    ),
    FormFieldItem(
      fieldItemIndex: 5,
      label: "label def2",
      name: "name def2",
      type: FieldType.radio,
      extra: FormFieldItemExtra(
        radioFieldOptions: [
          RadioFieldOption(label: "opt1 lb 2", name: "opt1 name 2"),
          RadioFieldOption(label: "opt2 lb 2", name: "opt2 name 2"),
          RadioFieldOption(label: "opt3 lb 2", name: "opt3 name 2"),
        ],
        selectionOptions: null,
        imageCount: null,
      ),
      required: false,
    ),
  ],
  [
    FormFieldItem(
      fieldItemIndex: 6,
      label: "label ghi1",
      name: "name ghi1",
      type: FieldType.numberInput,
      extra: null,
      required: false,
    ),
    FormFieldItem(
      fieldItemIndex: 7,
      label: "label ghi2",
      name: "name ghi2",
      type: FieldType.image,
      extra: null,
      required: false,
    ),
    FormFieldItem(
      fieldItemIndex: 8,
      label: "label ghi3",
      name: "name ghi3",
      type: FieldType.radio,
      extra: FormFieldItemExtra(
        radioFieldOptions: [
          RadioFieldOption(label: "opt1 lb 3", name: "opt1 name 3"),
          RadioFieldOption(label: "opt2 lb 3", name: "opt2 name 3"),
          RadioFieldOption(label: "opt3 lb 3", name: "opt3 name 3"),
        ],
        selectionOptions: null,
        imageCount: null,
      ),
      required: false,
    ),
  ],
];

final List<List<InputInstance>> mockInstancesList = [
  [
    InputInstance(
      instanceIndex: 0,
      label: "instance a1 label",
      name: "instance a1 name",
    ),
    InputInstance(
      instanceIndex: 1,
      label: "instance a2 label",
      name: "instance a2 name",
    ),
    InputInstance(
      instanceIndex: 2,
      label: "instance a3 label",
      name: "instance a3 name",
    ),
  ],
  [
    InputInstance(
      instanceIndex: 0,
      label: "instance b1 label",
      name: "instance b1 name",
    ),
    InputInstance(
      instanceIndex: 1,
      label: "instance b2 label",
      name: "instance b2 name",
    ),
    InputInstance(
      instanceIndex: 2,
      label: "instance b3 label",
      name: "instance b3 name",
    ),
    InputInstance(
      instanceIndex: 3,
      label: "instance b3 label",
      name: "instance b3 name",
    ),
  ],
  [
    InputInstance(
      instanceIndex: 0,
      label: "instance c1 label",
      name: "instance c1 name",
    ),
    InputInstance(
      instanceIndex: 1,
      label: "instance c2 label",
      name: "instance c2 name",
    ),
    InputInstance(
      instanceIndex: 2,
      label: "instance c3 label",
      name: "instance c3 name",
    ),
    InputInstance(
      instanceIndex: 3,
      label: "instance c4 label",
      name: "instance c4 name",
    ),
    InputInstance(
      instanceIndex: 4,
      label: "instance c5 label",
      name: "instance c5 name",
    ),
  ],
];

final List<FormCategory> mockCategories = [
  FormCategory(
    categoryIndex: 0,
    label: "cat a1",
    fields: mockFieldsList[0],
    inputInstances: mockInstancesList[0],
  ),
  FormCategory(
    categoryIndex: 1,
    label: "cat a2",
    fields: mockFieldsList[1],
    inputInstances: mockInstancesList[2],
  ),
  FormCategory(
    categoryIndex: 2,
    label: "cat a3",
    fields: mockFieldsList[2],
    inputInstances: mockInstancesList[1],
  ),
  FormCategory(
    categoryIndex: 3,
    label: "cat b1",
    fields: mockFieldsList[2],
    inputInstances: mockInstancesList[0],
  ),
  FormCategory(
    categoryIndex: 4,
    label: "cat b2",
    fields: mockFieldsList[0],
    inputInstances: mockInstancesList[1],
  ),
];

final List<FormSubsection> mockSubsections = [
  FormSubsection(
    subsectionIndex: 0,
    label: "sub 1",
    categories: {
      "cat 1": mockCategories[0],
      // "cat 2": mockCategories[2],
      // "cat 3": mockCategories[4],
    },
  ),
  FormSubsection(
    subsectionIndex: 1,
    label: "sub 2",
    categories: {
      // "cat 1": mockCategories[0],
      // "cat 2": mockCategories[1],
      "cat 3": mockCategories[2],
      "cat 4": mockCategories[3],
    },
  ),
  FormSubsection(
    subsectionIndex: 2,
    label: "sub 3",
    categories: {
      "cat 1": mockCategories[1],
      // "cat 2": mockCategories[3],
      // "cat 3": mockCategories[4],
    },
  ),
];

final List<FormSection> sections = [
  FormSection(
    sectionIndex: 0,
    label: "sect 1",
    subsections: {
      "sub 1": mockSubsections[0],
      // "sub 2": mockSubsections[1],
    },
  ),
  FormSection(
    sectionIndex: 1,
    label: "sect 2",
    subsections: {
      "sub 1": mockSubsections[1],
      // "sub 2": mockSubsections[1],
      // "sub 3": mockSubsections[2],
    },
  ),
  FormSection(
    sectionIndex: 2,
    label: "sect 3",
    subsections: {"sub 1": mockSubsections[2], "sub 2": mockSubsections[1]},
  ),
];

final ReportFormStructure mockFormStructure = ReportFormStructure(
  structureId: 0,
  label: "struct 1",
  sections: {
    "sect 1": sections[0],
    "sect 2": sections[1],
    "sect 3": sections[2],
  },
);
TaskReportRecord mockReportRecord = TaskReportRecord(
  id: 1,
  scheduleId: 1,
  dateCreated: DateTime.now(),
  createdBy: 1,
  lastUpdated: DateTime.now(),
  lastUpdatedBy: 1,
  isSubmitted: false,
  verifiedBy: 1,
  reportData: ReportFormData(
    serialData: <String, (FieldType, dynamic)>{
      "0_0_0_0_0": (FieldType.textbox, "abcabc"),
      "2_2_1_0_4": (FieldType.textbox, "ok123123"),
      // "2_1_2_2_8": ["opt2 name 3"],
      // "2_1_2_3_8": ["opt2 name 3"],
      "2_1_3_0_6": (FieldType.textbox, "123213"),
      // "2_1_3_1_8": ["opt3 name 3"],
      "2_1_3_2_6": (FieldType.textbox, "123"),
      // "2_1_3_2_8": ["opt2 name 3"],
    },
    images: <String, File?>{"": File("assets/mock/image.jpg")},
  ),
  isActive: true,
);
