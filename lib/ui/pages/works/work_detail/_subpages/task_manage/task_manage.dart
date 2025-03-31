import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/list_view_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/search_bar_widget.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/data/models/project.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/presets/date_formats.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

part "views/task_manage_task_list_section.dart";

class _WorkItemTaskManagePageContent extends StatelessWidget {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   controller: scrollController,
    //   padding: EdgeInsets.all(0),
    //   children: [
    //     _WorkItemTaskListViewSection(scrollController: scrollController),
    //   ],
    // );
    final colorScheme = context.theme.colorScheme;
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 8,
                child: GNav(
                  rippleColor: Colors.grey.withAlpha(
                    150,
                  ), // tab button ripple color when pressed
                  hoverColor: Colors.grey.withAlpha(
                    180,
                  ), // tab button hover color
                  haptic: true, // haptic feedback
                  tabBorderRadius: 15,
                  tabActiveBorder: Border.all(
                    color: Colors.black,
                    width: 1,
                  ), // tab button border
                  tabBorder: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1),
                  ), // tab button border
                  tabShadow: [], // tab button shadow
                  curve: Curves.easeInOutCubic, // tab animation curves
                  duration: Duration(
                    milliseconds: 200,
                  ), // tab animation duration
                  gap: 8, // the tab button gap between icon and text
                  color: colorScheme.foreground.withAlpha(
                    180,
                  ), // unselected icon color
                  activeColor:
                      colorScheme.foreground, // selected icon and text color
                  iconSize: 24, // tab button icon size
                  tabBackgroundColor: colorScheme.primary.withAlpha(120),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  tabs: [
                    GButton(icon: Icons.home, text: 'Home'),
                    GButton(icon: Icons.group, text: 'Likes'),
                    GButton(icon: Icons.search, text: 'Search'),
                    GButton(icon: Icons.access_time_sharp, text: 'Profile'),
                  ],
                ),
              ),
              Expanded(flex: 2, child: Container()),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(
                  color: Colors.blue.withAlpha(150),
                  child: Column(children: []),
                ),
                Container(
                  color: Colors.red.withAlpha(20),
                  child: Column(children: []),
                ),
                Container(
                  color: Colors.green.withAlpha(70),
                  child: Column(children: []),
                ),
                Container(
                  color: Colors.yellow.withAlpha(120),
                  child: Column(children: []),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WorkItemTaskManagePage extends StatelessWidget {
  const WorkItemTaskManagePage({super.key});

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
        "Quản lý công việc",
        style: typography.lg.copyWith(fontWeight: FontWeight.w600),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colorScheme.secondaryForeground),
        onPressed: () => onPressBackButton(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return Scaffold(
      appBar: _WorkItemDetailPageHeader(context),
      backgroundColor: colorScheme.background,
      body: _WorkItemTaskManagePageContent(),
    );
  }
}
