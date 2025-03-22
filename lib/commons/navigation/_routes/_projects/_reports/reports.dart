import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/bloc/report_form_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/commons/form_builder/models/models.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/report_form_view_page.dart';
import 'package:go_router/go_router.dart';

final reportRoute = GoRoute(
  path: "/reports",
  name: "reports",
  builder: (context, state) => Container(),
  routes: [
    GoRoute(
      path: "/:id",
      builder: (context, state) {
        return Container();
      },
      routes: [
        ShellRoute(
          pageBuilder: (context, state, child) {
            final ID reportId = ID.parse(state.pathParameters['id']!);
            return MaterialPage(
              child: BlocProvider<ReportFormBloc>(
                create:
                    (context) => ReportFormBloc(
                      buildType: BuildType.type_default,
                      reportFormStructureId: 1,
                      reportFormId: 1,
                    ),
                child: child,
              ),
            );
          },
          routes: [
            GoRoute(
              path: "/detail",
              builder: (context, state) {
                return ReportFormViewPage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
