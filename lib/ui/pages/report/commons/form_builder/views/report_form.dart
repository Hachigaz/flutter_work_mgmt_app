library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/input_fields/image_field.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/input_style_presets.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/bloc/report_form_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/commons/form_builder/models/models.dart';

part "form_section.dart";
part "form_subsection.dart";
part "form_category.dart";

class ReportForm extends StatelessWidget {
  const ReportForm({super.key});

  void onPressSaveForm(BuildContext context) {
    context.read<ReportFormBloc>().add(ReportFormSubmit());
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<ReportFormBloc>();

    final List<Tab> tabLabels = [];
    final List<Widget> tabs = [];

    final colorScheme = appThemeData.colorScheme;
    // final typography = appThemeData.typography;

    for (final section in formBloc.formStructure.sections.entries) {
      tabLabels.add(Tab(child: Text(section.value.label)));
      tabs.add(_FormSectionWidget(section: section.value));
    }

    final tabController = DefaultTabController(
      length: formBloc.formStructure.sections.length,
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: TabBar(tabs: tabLabels),
        body: TabBarView(children: tabs),

        // ...formSections,
        // Padding(
        //   padding: EdgeInsets.only(
        //     bottom: padding_4xl,
        //     left: padding_lg,
        //     right: padding_lg,
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       SizedBox(),

        //       if (formBloc.buildType != BuildType.type_read_only)
        //         Padding(
        //           padding: EdgeInsets.symmetric(horizontal: padding_lg),
        //           child: OutlinedButton(
        //             style: button_style_default,
        //             onPressed: () {
        //               onPressSaveForm(context);
        //             },
        //             child: Text("Lưu báo cáo"),
        //           ),
        //         ),
        //     ],
        //   ),
        // ),
      ),
    );

    return Form(key: formBloc.formKey, child: tabController);
  }
}
