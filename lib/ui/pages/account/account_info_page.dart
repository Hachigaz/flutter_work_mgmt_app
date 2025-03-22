import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/commons/models/account.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_providers/auth_repo.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/color/color_helpers.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/date_formats.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/input_style_presets.dart';
import 'package:flutter_work_mgmt_app/ui/pages/account/bloc/account_info_page_repository.dart';

final double _background_y_offset = -420.r;

class _AccountInfoPageContent extends StatelessWidget {
  final ValueNotifier<double> backgroundOffset = ValueNotifier(
    _background_y_offset,
  );

  void onClickLogoutButton(BuildContext context) {
    final auth = context.read<AuthRepository>();
    auth.logout();
    context.goNamed("login");
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;

    final accountRecord =
        context.read<AccountInfoPageRepository>().accountRecord;
    final staffRecord = context.read<AccountInfoPageRepository>().staffRecord;

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ValueListenableBuilder<double>(
            valueListenable: backgroundOffset,
            builder: (context, offset, child) {
              return Transform.translate(
                offset: Offset(0, offset), // Move shape based on scroll
                child: ClipPath(
                  clipper: WaveClipperTwo(),
                  child: SizedBox(
                    width: 400.r,
                    height: 400.r,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: appThemeData.colorScheme.primary.withAlpha(120),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            backgroundOffset.value =
                _background_y_offset - scrollInfo.metrics.pixels;
            return true;
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: status_bar_offset,
              // left: padding_2xl,
              // right: padding_2xl,
            ),
            child: Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 35.h,
                      left: 10.w,
                      right: 10.w,
                      bottom: 10.h,
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/images/cover.jpg",
                            width: 100.r,
                            height: 100.r,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.r, left: 10.w),
                          child: Text(
                            staffRecord.fullName!,
                            style: appThemeData.typography.xl2.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ExpansionTile(
                        backgroundColor: colorScheme.background,
                        collapsedBackgroundColor: colorScheme.background,
                        textColor: colorShift(
                          color: colorScheme.foreground,
                          r: 10,
                          g: 10,
                          b: 10,
                        ),
                        collapsedTextColor: colorScheme.foreground,
                        title: Text(
                          style: typography.base.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
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
                      ),
                      ExpansionTile(
                        backgroundColor: colorScheme.background,
                        collapsedBackgroundColor: colorScheme.background,
                        textColor: colorShift(
                          color: colorScheme.foreground,
                          r: 10,
                          g: 10,
                          b: 10,
                        ),
                        collapsedTextColor: colorScheme.foreground,
                        title: Text(
                          style: typography.base.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
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
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            onClickLogoutButton(context);
                          },
                          style: button_style_primary.copyWith(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              colorScheme.primary.darker(30).withAlpha(180),
                            ),
                            shape: WidgetStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "Đăng xuất",
                              style: typography.base.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.secondaryForeground,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: RepositoryProvider<AccountInfoPageRepository>(
        create: (BuildContext context) {
          final authRepo = context.read<AuthRepository>();
          AccountRecord? accountRecord = authRepo.currentAccount;
          StaffRecord? staffRecord = authRepo.currentStaffInfo;
          return AccountInfoPageRepository(
            accountRecord: accountRecord!,
            staffRecord: staffRecord!,
          );
        },
        child: FScaffold(
          contentPad: false,
          style: style_scaffold_root_page,
          content: _AccountInfoPageContent(),
        ),
      ),
    );
  }
}
