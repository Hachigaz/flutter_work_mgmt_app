import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/models/project.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/presets/date_formats.dart';

void _onPressDetailButton({
  required BuildContext context,
  required ID projectId,
}) {
  context.push("${context.namedLocation("projects")}/$projectId/detail");
}

class ProjectListItem extends StatelessWidget {
  final ProjectRecord _projectRecord;
  const ProjectListItem({super.key, required ProjectRecord projectRecord})
    : _projectRecord = projectRecord;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    return GestureDetector(
      onTap:
          () => _onPressDetailButton(
            context: context,
            projectId: _projectRecord.id!,
          ),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.background,
          border: Border(
            top: BorderSide(color: colorScheme.border, width: 1),
            bottom: BorderSide(color: colorScheme.border, width: 1),
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: padding_xl,
            horizontal: padding_xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.my_library_books_rounded,
                      color: colorScheme.secondaryForeground,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Dự án",
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.typography.lg.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Text(
                  "${_projectRecord.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.typography.xl.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding_md),
                child: Text(
                  "Địa chỉ: ${_projectRecord.workAddress}",
                  style: typography.base,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding_sm),
                child: Text(
                  "Ngày khởi công: ${date_fmat_date.format(_projectRecord.startDate!)}",
                  style: typography.base,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectItemDisplayLarge extends StatelessWidget {
  final ProjectRecord _projectRecord;
  const ProjectItemDisplayLarge({
    super.key,
    required ProjectRecord projectRecord,
  }) : _projectRecord = projectRecord;

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    final presets = context.read<ThemeBloc>().state.presets;
    return GestureDetector(
      onTap:
          () => _onPressDetailButton(
            context: context,
            projectId: _projectRecord.id!,
          ),
      child: Container(
        decoration: BoxDecoration(
          color: presets.color_background_primary,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(padding_lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.my_library_books_rounded, color: Colors.white),
                const SizedBox(width: 6),
                Text(
                  "Dự án",
                  overflow: TextOverflow.ellipsis,
                  style: typography.lg.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding_md),
              child: Text(
                "${_projectRecord.name}\n",
                style: typography.xl.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Ngày khởi công: ${date_fmat_date.format(_projectRecord.startDate!)}",
                style: typography.sm.copyWith(
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
