import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:forui/forui.dart';

const double _fieldPadding = 20;

class WorkItemCreatePage extends StatelessWidget {
  const WorkItemCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;

    final textLabelStyle = typography.sm.copyWith(fontWeight: FontWeight.w600);

    return Container(
      color: colorScheme.background,
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: status_bar_offset, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Hạng mục mới",
                style: typography.xl2.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  FTextField(
                    label: Text("Tên hạng mục", style: textLabelStyle),
                  ),
                  SizedBox(height: _fieldPadding),
                  FTextField(label: Text("Tên đầy đủ", style: textLabelStyle)),
                  SizedBox(height: _fieldPadding),
                  FTextField.multiline(
                    minLines: 4,
                    label: Text("Mô tả", style: textLabelStyle),
                  ),
                  SizedBox(height: _fieldPadding),
                  FDatePicker(
                    label: Text("Ngày bắt đầu", style: textLabelStyle),
                  ),
                ],
              ),
            ),
            SizedBox(height: _fieldPadding * 2),
            FButton(
              onPress: () {},
              label: Text(
                "Tạo hạng mục",
                style: typography.base.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
