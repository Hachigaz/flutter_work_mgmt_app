import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/providers/auth/auth_repo.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:forui/forui.dart';

class HomePageAppTitle extends StatelessWidget {
  const HomePageAppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Môi trường ",
                  style: typography.xl2.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: "Á Châu",
                  style: typography.xl2.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: padding_lg),
        Align(
          alignment: Alignment(-0.8, 0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Xin chào, \n",
                      style: typography.xl.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text:
                          context
                              .read<AuthRepository>()
                              .currentStaffInfo!
                              .fullName,
                      style: typography.xl2.copyWith(
                        fontWeight: FontWeight.w700,
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
