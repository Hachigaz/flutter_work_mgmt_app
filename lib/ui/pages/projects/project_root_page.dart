library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:flutter_work_mgmt_app/providers/ui/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/list_view_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/swipable_list_view.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/_widgets/project_display_item.dart';
import 'package:forui/forui.dart';

// class _ProjectRootPageHeader extends StatelessWidget {
//   const _ProjectRootPageHeader();

//   @override
//   Widget build(BuildContext context) {
//     return FHeader.nested(title: Text("Dự án"), suffixActions: [
//       ],
//     );
//   }
// }

class _PageTitleDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Dự án công trình",
          style: typography.xl3.copyWith(
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Danh sách dự án được phân công",
          style: typography.lg.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.foreground.withAlpha(200),
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class _ProjectRootPageContent extends StatelessWidget {
  const _ProjectRootPageContent();

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;

    return Padding(
      padding: EdgeInsets.only(
        top: status_bar_offset,
        left: padding_2xl,
        right: padding_2xl,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PageTitleDisplay(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding_md),
              child: PageListSection(
                child: ListViewWidget<ProjectRecord>(
                  listBuilder: (itemList) {
                    return SizedBox(
                      height: 200,
                      child: SwipableListView(
                        viewportFraction: 0.85,
                        children: [
                          for (final item in itemList)
                            ProjectItemDisplayLarge(projectRecord: item),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding_md),
              child: PageListSection(
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dự án đang hoạt động",
                      style: typography.lg.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: presets.button_style_default_rounded,
                      child: Text("Xem tất cả", style: typography.sm),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: ListViewWidget<ProjectRecord>(
                    listBuilder: (itemList) {
                      return Column(
                        children: [
                          for (final item in itemList)
                            ProjectListItem(projectRecord: item),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding_md),
              child: PageListSection(
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Đã hoàn thành",
                      style: typography.lg.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: presets.button_style_default_rounded,
                      child: Text("Xem tất cả", style: typography.sm),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: ListViewWidget<ProjectRecord>(
                    listBuilder: (itemList) {
                      return Column(
                        children: [
                          for (final item in itemList)
                            ProjectListItem(projectRecord: item),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectRootPage extends StatelessWidget {
  const ProjectRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: _ProjectRootPageContent(),
    );
  }
}
