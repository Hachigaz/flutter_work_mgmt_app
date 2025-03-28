library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import "_views/work_item_info_section.dart";
import "_views/_task_overview_section/task_overview_section.dart";

class _WorkItemDetailPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;

    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        WorkItemInfoSection(),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          padding: EdgeInsets.all(30),
          child: Column(children: [WorkDetailTaskOverviewSection()]),
        ),
      ],
    );
  }
}

class WorkItemDetailPage extends StatelessWidget {
  const WorkItemDetailPage({super.key});

  void onPressBackButton(BuildContext context) {
    context.pop();
  }

  AppBar _WorkItemDetailPageHeader(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    return AppBar(
      backgroundColor: colorScheme.primary.withAlpha(0),
      centerTitle: true,
      title: Text(
        "Chi tiết hạng mục",
        style: typography.lg.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => onPressBackButton(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final presets = context.read<ThemeBloc>().state.presets;
    return Scaffold(
      backgroundColor: presets.color_background_primary,
      appBar: _WorkItemDetailPageHeader(context),
      body: _WorkItemDetailPageContent(),
    );
  }
}
