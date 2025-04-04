import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/account/bloc/account_info_page_repository.dart';
import 'package:forui/forui.dart';

class TopAvatarDisplay extends StatelessWidget {
  const TopAvatarDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final pageRepo = context.read<AccountInfoPageRepository>();
    final staffRecord = pageRepo.staffRecord;

    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            "assets/images/cover.jpg",
            width: 130,
            height: 130,
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 32,
              right: -30.0,
              child: FButton.raw(
                onPress: () {},
                style: FButtonStyle.ghost,
                child: Icon(Icons.edit, size: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 33, left: 12),
              child: Text(
                staffRecord.fullName!,
                style: context.theme.typography.xl2.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
