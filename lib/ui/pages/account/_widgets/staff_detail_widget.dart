import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/accounts.dart';
import 'package:flutter_work_mgmt_app/providers/ui/theme/presets/date_formats.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/helpers/color_helpers.dart';
import 'package:flutter_work_mgmt_app/ui/pages/account/bloc/account_info_page_repository.dart';
import 'package:forui/forui.dart';

class StaffDetailWidget extends StatelessWidget {
  const StaffDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;

    final StaffRecord staffRecord =
        context.read<AccountInfoPageRepository>().staffRecord;

    return ExpansionTile(
      backgroundColor: colorScheme.background,
      collapsedBackgroundColor: colorScheme.background,
      textColor: colorShift(color: colorScheme.foreground, r: 10, g: 10, b: 10),
      collapsedTextColor: colorScheme.foreground,
      title: Text(
        style: typography.base.copyWith(fontWeight: FontWeight.w600),
        "Thông tin cá nhân",
      ),
      children: [
        ListTile(
          title: Text(
            style: typography.base.copyWith(),
            "Họ và tên: ${staffRecord.fullName}",
          ),
        ),
        ListTile(
          title: Text(
            style: typography.base.copyWith(),
            "Ngày sinh: ${date_fmat_date.format(staffRecord.dob!)}",
          ),
        ),
        ListTile(
          title: Text(
            style: typography.base.copyWith(),
            "Giới tính: ${staffRecord.gender!.label}",
          ),
        ),
        ListTile(
          title: Text(
            style: typography.base.copyWith(),
            "Ngày bắt đầu làm việc:  ${date_fmat_date.format(staffRecord.dateEmployed!)}",
          ),
        ),
      ],
    );
  }
}
