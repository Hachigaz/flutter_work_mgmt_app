import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:flutter_work_mgmt_app/data/models/reports.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/bloc/report_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/report_form_view_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/schedule_create/_bloc/schedule_create_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/schedule_create/schedule_create_page.dart';
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
            final ID scheduleId = ID.parse(state.pathParameters['id']!);
            return MaterialPage(
              key: state.pageKey,
              child: BlocProvider<ReportDetailBloc>(
                create: (context) {
                  return ReportDetailBloc(
                    recordId: scheduleId,
                    dataRepo:
                        context.read<DataRepository<ReportScheduleRecord>>(),
                    taskReportRepo:
                        context.read<DataRepository<TaskReportRecord>>(),
                  );
                },
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
    GoRoute(
      path: "/templates/:id",
      pageBuilder: (context, state) {
        final ID taskId = ID.parse(state.pathParameters["id"]!);
        final queryParams = state.uri.queryParameters;
        return MaterialPage(
          key: state.pageKey,
          child: BlocProvider<ScheduleCreateBloc>(
            create:
                (context) => ScheduleCreateBloc(
                  taskRepo: context.read<DataRepository<TaskRecord>>(),
                  taskId: taskId,
                  queryParams: queryParams,
                ),
            child: ScheduleCreatePage(),
          ),
        );
      },
    ),
    GoRoute(
      path: "/schedule_create/:task_id",
      pageBuilder: (context, state) {
        final ID taskId = ID.parse(state.pathParameters["task_id"]!);
        final queryParams = state.uri.queryParameters;
        return MaterialPage(
          key: state.pageKey,
          child: BlocProvider<ScheduleCreateBloc>(
            create:
                (context) => ScheduleCreateBloc(
                  taskRepo: context.read<DataRepository<TaskRecord>>(),
                  taskId: taskId,
                  queryParams: queryParams,
                ),
            child: ScheduleCreatePage(),
          ),
        );
      },
    ),
  ],
);
