library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:forui/forui.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/input_fields/image_field.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_bloc/report_form_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_models/models.dart';

part "form_section.dart";
part "form_subsection.dart";
part "form_category.dart";
part "_form_inputs/text_field_input.dart";
part "_form_inputs/text_field_large_input.dart";
part "_form_inputs/number_input.dart";
part "_form_inputs/select_input.dart";
part "_form_inputs/radio_input.dart";
part "_form_inputs/image_input.dart";

class ReportFormViewWidget extends StatelessWidget {
  const ReportFormViewWidget({super.key});

  void onPressSaveForm(BuildContext context) {
    context.read<ReportFormBloc>().add(ReportFormSubmit());
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<ReportFormBloc>();

    // final List<Tab> tabLabels = [];
    // final List<Widget> tabs = [];
    final List<FTabEntry> tabSections = [];

    // final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;

    for (final section in formBloc.formStructure.sections.entries) {
      // tabLabels.add(Tab(child: Text(section.value.label)));
      // tabs.add(_FormSectionWidget(section: section.value));
      tabSections.add(
        FTabEntry(
          label: Text(
            section.value.label,
            style: typography.base.copyWith(fontWeight: FontWeight.w600),
          ),
          content: _FormSectionWidget(section: section.value),
        ),
      );
    }

    // final tabController = DefaultTabController(
    //   length: formBloc.formStructure.sections.length,
    // child: Scaffold(
    //   backgroundColor: colorScheme.background,
    //   appBar: TabBar(tabs: tabLabels),
    //   body: TabBarView(children: tabs),

    //   // ...formSections,
    //   // Padding(
    //   //   padding: EdgeInsets.only(
    //   //     bottom: padding_4xl,
    //   //     left: padding_lg,
    //   //     right: padding_lg,
    //   //   ),
    //   //   child: Row(
    //   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   //     children: [
    //   //       SizedBox(),

    //   //       if (formBloc.buildType != BuildType.type_read_only)
    //   //         Padding(
    //   //           padding: EdgeInsets.symmetric(horizontal: padding_lg),
    //   //           child: OutlinedButton(
    //   //             style: button_style_default_rounded,
    //   //             onPressed: () {
    //   //               onPressSaveForm(context);
    //   //             },
    //   //             child: Text("Lưu báo cáo"),
    //   //           ),
    //   //         ),
    //   //     ],
    //   //   ),
    //   // ),
    // ),
    // );

    return Form(
      key: formBloc.formKey,
      child: FTabs(scrollable: true, tabs: tabSections),
    );
  }
}
