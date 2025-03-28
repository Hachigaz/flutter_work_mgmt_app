import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/auth/auth_repo.dart';
import 'package:forui/forui.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
// import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';
import 'package:flutter_work_mgmt_app/ui/pages/login/components/login_box/bloc/login_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/login/components/login_box/view/login_box.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //perform prelogin
    final colorScheme = context.theme.colorScheme;
    return BlocProvider(
      create: (context) => LoginBloc(authRepo: context.read<AuthRepository>()),
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: Stack(
          children: [
            //image layers
            Transform.translate(
              offset: Offset(0, 40.h),
              // child: SizedBox(height: 120.h, child: Placeholder()),
            ),
            //ui layer
            Center(
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Đăng nhập",
                      style: context.theme.typography.xl3.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: padding_xl),
                      child: LoginBox(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
