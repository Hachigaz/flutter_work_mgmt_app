import 'dart:convert';
import 'dart:math';

import 'package:flutter_work_mgmt_app/commons/misc/random.dart';
import 'package:flutter_work_mgmt_app/data/models/report.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_models/models.dart';

class ReportFormTemplateRepository
    extends DataRepository<ReportFormTemplateRecord> {
  @override
  ReportFormTemplateRecord getOne() {
    return _generateItems(count: 1)[0];
  }

  @override
  ListReturnResult<ReportFormTemplateRecord> search(String searchValue) {
    return (itemList: _generateItems(count: 8), isLast: true);
  }

  List<ReportFormTemplateRecord> _generateItems({int count = 3}) {
    final List<ReportFormTemplateRecord> recs = [];
    for (var i = 0; i < count; i++) {
      final stringName = generateRandomString(5);
      final stringDesc = generateRandomString(20);

      recs.add(
        ReportFormTemplateRecord(
          id: 1,
          formName: "Template $stringName",
          description: "Template $stringDesc",
          formStructureData: _generateTemplate(),
        ),
      );
    }
    return recs;
  }

  String _generateTemplate() {
    final sections = <String, FormSection>{};
    for (int z = 0; z < Random().nextInt(2) + 1; z++) {
      final subsections = <String, FormSubsection>{};
      for (int j = 0; j < Random().nextInt(2) + 1; j++) {
        final categories = <String, FormCategory>{};
        for (int i = 0; i < Random().nextInt(2) + 1; i++) {
          categories["cat_$i"] = FormCategory(
            categoryIndex: i,
            label: "Mục ${i + 1}",
            fields: _mockFieldsList[Random().nextInt(_mockFieldsList.length)],
            inputInstances:
                _mockInstancesList[Random().nextInt(_mockInstancesList.length)],
          );
        }
        subsections["subsect_$j"] = FormSubsection(
          subsectionIndex: j,
          label: "Nhóm mục B${j + 1}",
          categories: categories,
        );
      }
      sections["sect_$z"] = FormSection(
        sectionIndex: z,
        label: "Khu vực C${z + 1}",
        subsections: subsections,
      );
    }

    final form = ReportFormStructure(
      structureId: 1,
      label: "",
      sections: sections,
    );

    final templateData = jsonEncode(form);

    print(templateData);

    return templateData;
  }
}

final List<List<FormFieldItem>> _mockFieldsList = [
  [
    FormFieldItem(
      fieldItemIndex: 0,
      label: "Thông số x",
      name: "x_value",
      type: FieldType.textbox,
      extra: null,
      required: false,
    ),
    FormFieldItem(
      fieldItemIndex: 1,
      label: "Thông số y",
      name: "y_value",
      type: FieldType.numberInput,
      extra: null,
      required: true,
    ),
    FormFieldItem(
      fieldItemIndex: 2,
      label: "Trạng thái z",
      name: "z_value",
      type: FieldType.radio,
      extra: FormFieldItemExtra(
        radioFieldOptions: [
          RadioFieldOption(label: "Tốt", name: "opt_good"),
          RadioFieldOption(label: "Bình thường", name: "good_norm"),
          RadioFieldOption(label: "Cần sửa chữa", name: "opt_needs_fixed"),
        ],
        selectionOptions: null,
        imageCount: null,
      ),
      required: false,
    ),
    FormFieldItem(
      fieldItemIndex: 3,
      label: "Các thành phần",
      name: "select_opt",
      type: FieldType.selection,
      extra: FormFieldItemExtra(
        radioFieldOptions: null,
        selectionOptions: [
          SelectionFieldOption(label: "Thành phần a", name: "opt_1_name_a"),
          SelectionFieldOption(label: "Thành phần b", name: "opt_2_name_b"),
          SelectionFieldOption(label: "Thành phần c", name: "opt_3_name_c"),
        ],
        imageCount: null,
      ),
      required: true,
    ),
  ],
  [
    FormFieldItem(
      fieldItemIndex: 4,
      label: "Thông tin A",
      name: "name_desc",
      type: FieldType.textboxLarge,
      extra: null,
      required: false,
    ),
    FormFieldItem(
      fieldItemIndex: 5,
      label: "Trạng thái",
      name: "name_status",
      type: FieldType.radio,
      extra: FormFieldItemExtra(
        radioFieldOptions: [
          RadioFieldOption(label: "Trạng thái A", name: "opt_status_a"),
          RadioFieldOption(label: "Trạng thái B", name: "opt_status_b"),
          RadioFieldOption(label: "Trạng thái C", name: "opt_status_c"),
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
      label: "Thông tin B",
      name: "name_info_b",
      type: FieldType.textbox,
      extra: null,
      required: false,
    ),
    FormFieldItem(
      fieldItemIndex: 7,
      label: "Hình ảnh máy",
      name: "name_image",
      type: FieldType.image,
      extra: null,
      required: false,
    ),
  ],
  [
    FormFieldItem(
      fieldItemIndex: 6,
      label: "Thông số A",
      name: "name_info_a",
      type: FieldType.numberInput,
      extra: null,
      required: false,
    ),
    FormFieldItem(
      fieldItemIndex: 6,
      label: "Thông số B",
      name: "name_info_b",
      type: FieldType.numberInput,
      extra: null,
      required: false,
    ),
    FormFieldItem(
      fieldItemIndex: 6,
      label: "Thông số C",
      name: "name_info_c",
      type: FieldType.numberInput,
      extra: null,
      required: false,
    ),
  ],
];

final List<List<InputInstance>> _mockInstancesList = [
  [
    InputInstance(instanceIndex: 0, label: "Máy A", name: "machine_a"),
    InputInstance(instanceIndex: 1, label: "Máy B", name: "machine_b"),
    InputInstance(instanceIndex: 2, label: "Máy C", name: "machine_c"),
  ],
  [
    InputInstance(instanceIndex: 0, label: "Máy A1", name: "a1_machine"),
    InputInstance(instanceIndex: 1, label: "Máy A2", name: "a2_machine"),
    InputInstance(instanceIndex: 2, label: "Máy A3", name: "a3_machine"),
    InputInstance(instanceIndex: 3, label: "Máy A4", name: "a4_machine"),
  ],
];

// final List<FormCategory> _mockCategories = [
//   FormCategory(
//     categoryIndex: 0,
//     label: "Mục A1",
//     fields: _mockFieldsList[0],
//     inputInstances: _mockInstancesList[0],
//   ),
//   FormCategory(
//     categoryIndex: 1,
//     label: "Mục A2",
//     fields: _mockFieldsList[1],
//     inputInstances: _mockInstancesList[1],
//   ),
//   FormCategory(
//     categoryIndex: 2,
//     label: "Mục A3",
//     fields: _mockFieldsList[2],
//     inputInstances: _mockInstancesList[1],
//   ),
//   FormCategory(
//     categoryIndex: 3,
//     label: "Mục A4",
//     fields: _mockFieldsList[2],
//     inputInstances: _mockInstancesList[0],
//   ),
//   FormCategory(
//     categoryIndex: 4,
//     label: "Mục A5",
//     fields: _mockFieldsList[0],
//     inputInstances: _mockInstancesList[1],
//   ),
// ];

// final List<FormSubsection> _mockSubsections = [
//   FormSubsection(
//     subsectionIndex: 0,
//     label: "Khu vực B1",
//     categories: {
//       "cat 1": _mockCategories[0],
//       // "cat 2": mockCategories[2],
//       // "cat 3": mockCategories[4],
//     },
//   ),
//   FormSubsection(
//     subsectionIndex: 1,
//     label: "Khu vực B2",
//     categories: {
//       // "cat 1": mockCategories[0],
//       // "cat 2": mockCategories[1],
//       "cat 3": _mockCategories[2],
//       "cat 4": _mockCategories[3],
//     },
//   ),
//   FormSubsection(
//     subsectionIndex: 2,
//     label: "Khu vực B3",
//     categories: {
//       "cat 1": _mockCategories[1],
//       // "cat 2": mockCategories[3],
//       // "cat 3": mockCategories[4],
//     },
//   ),
// ];

// final List<FormSection> _sections = [
//   FormSection(
//     sectionIndex: 0,
//     label: "sect 1",
//     subsections: {
//       "sub 1": _mockSubsections[0],
//       // "sub 2": mockSubsections[1],
//     },
//   ),
//   FormSection(
//     sectionIndex: 1,
//     label: "sect 2",
//     subsections: {
//       "sub 1": _mockSubsections[1],
//       // "sub 2": mockSubsections[1],
//       // "sub 3": mockSubsections[2],
//     },
//   ),
//   FormSection(
//     sectionIndex: 2,
//     label: "sect 3",
//     subsections: {"sub 1": _mockSubsections[2], "sub 2": _mockSubsections[1]},
//   ),
// ];

// final ReportFormStructure mockFormStructure = ReportFormStructure(
//   structureId: 0,
//   label: "struct 1",
//   sections: {
//     "sect 1": _sections[0],
//     "sect 2": _sections[1],
//     "sect 3": _sections[2],
//   },
// );
