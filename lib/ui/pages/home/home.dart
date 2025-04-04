import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/scrolling_background.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:forui/forui.dart';
import '_widgets/widgets.dart';

class _HomePageContent extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final sectionPadding = padding_3xl;
    return ScrollingBackgroundWidget(
      scrollController: _scrollController,
      background: Opacity(
        opacity: 0.3,
        child: Image.asset("assets/images/app-background.jpg"),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: status_bar_offset,
          left: padding_3xl,
          right: padding_3xl,
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              HomePageAppTitle(),
              SizedBox(height: spacing_4xl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding_md),
                child: HomePageSearchBar(),
              ),
              SizedBox(height: padding_6xl),
              HomePageRevenueGraph(),

              SizedBox(height: padding_4xl),
              SizedBox(height: sectionPadding),
              HomePageToolbar(),

              HomePageCalendarInfoSection(),
              SizedBox(height: sectionPadding),
              HomePageSwipableList(),
              SizedBox(height: padding_5xl),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: _HomePageContent(),
    );
  }
}
