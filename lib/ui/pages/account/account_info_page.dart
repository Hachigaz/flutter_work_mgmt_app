import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/providers/auth/auth_repo.dart';
import 'package:flutter_work_mgmt_app/providers/ui/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/account/_widgets/account_detail_widget.dart';
import 'package:flutter_work_mgmt_app/ui/pages/account/_widgets/option_menu_widget.dart';
import 'package:flutter_work_mgmt_app/ui/pages/account/_widgets/staff_detail_widget.dart';
import 'package:flutter_work_mgmt_app/ui/pages/account/_widgets/top_avatar_display.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/data/models/accounts.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
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
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;

    final presets = context.read<ThemeBloc>().state.presets;
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
                        color: context.theme.colorScheme.primary
                            .darker(20)
                            .withAlpha(60),
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
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 35,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: TopAvatarDisplay(),
                ),
                Column(
                  children: [
                    StaffDetailWidget(),
                    AccountDetailWidget(),
                    OptionMenuWidget(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          onClickLogoutButton(context);
                        },
                        style: presets.button_style_primary_rounded.copyWith(
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
                              color: Colors.white,
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
      ],
    );
  }
}

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
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
        child: Scaffold(
          backgroundColor: colorScheme.background,
          body: _AccountInfoPageContent(),
        ),
      ),
    );
  }
}
