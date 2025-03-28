import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_bloc/report_form_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_models/models.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/report_form_view_page.dart';
import 'package:go_router/go_router.dart';

final contractRoute = GoRoute(
  path: "/contracts",
  name: "contracts",
  builder: (context, state) => Container(),
  routes: [
    // GoRoute(
    //   path: "/detail/:id",
    //   pageBuilder: (context, state) {
    //     return MaterialPage(
    //       key: state.pageKey,
    //       child: BlocProvider<ReportFormBloc>(
    //         create:
    //             (context) => ReportFormBloc(
    //               buildType: BuildType.type_default,
    //               reportFormStructureId: 1,
    //               reportFormId: 1,
    //             ),
    //         child: ReportFormViewPage(),
    //       ),
    //     );
    //   },
    // ),
  ],
);
