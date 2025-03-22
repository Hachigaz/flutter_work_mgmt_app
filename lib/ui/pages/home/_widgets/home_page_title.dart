import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';

class HomePageAppTitle extends StatelessWidget {
  const HomePageAppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
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
                  style: typography.xl.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: "Á Châu",
                  style: typography.xl.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
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
                      text: "Á Châu",
                      style: typography.xl.copyWith(
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
