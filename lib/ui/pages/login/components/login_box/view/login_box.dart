import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/ui/pages/login/components/login_box/view/login_components.dart';

class LoginBox extends StatelessWidget {
  LoginBox({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoginUsernameTextField(),
              const SizedBox(height: 16),
              LoginPasswordTextField(),
              const SizedBox(height: 32),
              SizedBox(width: double.infinity, child: LoginSubmitButton()),
            ],
          ),
        ),
      ),
    );
  }
}
