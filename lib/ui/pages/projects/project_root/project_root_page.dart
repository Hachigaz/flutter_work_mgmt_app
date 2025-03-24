library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/commons/providers/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/swipable_list_view.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/bloc/project_root_repository.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/project_root/components/project_display_item.dart';
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
          "Danh sách dự án",
          style: typography.lg.copyWith(
            fontWeight: FontWeight.w500,
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
    final projRepo = context.read<ProjectRootRepository>();
    final presets = context.read<ThemeBloc>().state.presets;

    return Padding(
      padding: EdgeInsets.only(
        top: status_bar_offset,
        left: padding_2xl,
        right: padding_2xl,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          _PageTitleDisplay(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding_md),
            child: PageListSection(
              child: SizedBox(
                height: 120.h,
                child: SwipableListView(
                  viewportFraction: 0.6,
                  children: [
                    ProjectItemDisplayLarge(
                      projectRecord: projRepo.projectRecord,
                    ),
                    ProjectItemDisplayLarge(
                      projectRecord: projRepo.projectRecord,
                    ),
                    ProjectItemDisplayLarge(
                      projectRecord: projRepo.projectRecord,
                    ),
                    ProjectItemDisplayLarge(
                      projectRecord: projRepo.projectRecord,
                    ),
                    ProjectItemDisplayLarge(
                      projectRecord: projRepo.projectRecord,
                    ),
                  ],
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
                    "Dự án đang hoạt động",
                    style: typography.lg.copyWith(fontWeight: FontWeight.w600),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: presets.button_style_default,
                    child: Text("Xem tất cả", style: typography.sm),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  children: [
                    ProjectListItem(projectRecord: projRepo.projectRecord),
                    ProjectListItem(projectRecord: projRepo.projectRecord),
                    ProjectListItem(projectRecord: projRepo.projectRecord),
                    ProjectListItem(projectRecord: projRepo.projectRecord),
                  ],
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
                    style: typography.lg.copyWith(fontWeight: FontWeight.w600),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: presets.button_style_default,
                    child: Text("Xem tất cả", style: typography.sm),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  children: [
                    ProjectListItem(projectRecord: projRepo.projectRecord),
                    ProjectListItem(projectRecord: projRepo.projectRecord),
                    ProjectListItem(projectRecord: projRepo.projectRecord),
                    ProjectListItem(projectRecord: projRepo.projectRecord),
                  ],
                ),
              ),
            ),
          ),
        ],
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
