import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/accounts.dart';
import 'package:flutter_work_mgmt_app/providers/ui/theme/presets/date_formats.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/helpers/color_helpers.dart';
import 'package:flutter_work_mgmt_app/ui/pages/account/bloc/account_info_page_repository.dart';
import 'package:forui/forui.dart';

class AccountDetailWidget extends StatelessWidget {
  const AccountDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    final AccountRecord accountRecord =
        context.read<AccountInfoPageRepository>().accountRecord;

    return ExpansionTile(
      backgroundColor: colorScheme.background,
      collapsedBackgroundColor: colorScheme.background,
      textColor: colorShift(color: colorScheme.foreground, r: 10, g: 10, b: 10),
      collapsedTextColor: colorScheme.foreground,
      title: Text(
        style: typography.base.copyWith(fontWeight: FontWeight.w600),
        "Thông tin tài khoản",
      ),
      children: [
        ListTile(
          title: Text(
            style: typography.base.copyWith(),
            "Tên đăng nhập: ${accountRecord.loginName}",
          ),
        ),
        ListTile(
          title: Text(
            style: typography.base.copyWith(),
            "Ngày cuối đăng nhập: ${date_fmat_date.format(accountRecord.lastLogin!)}",
          ),
        ),
        ListTile(
          title: Text(
            style: typography.base.copyWith(),
            "Ngày tạo tài khoản: ${date_fmat_date.format(accountRecord.dateCreated!)}",
          ),
        ),
      ],
    );
  }
}
