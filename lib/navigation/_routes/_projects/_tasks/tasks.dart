import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:flutter_work_mgmt_app/data/models/reports.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/pages/tasks/_bloc/task_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/tasks/task_detail_page.dart';
import 'package:go_router/go_router.dart';

final taskRoute = GoRoute(
  path: "/tasks",
  name: "tasks",
  builder: (context, state) => Container(),
  routes: [
    GoRoute(
      path: ":id",
      builder: (context, state) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   context.push("${state.uri}/detail");
        // });

        return Container();
      },
      routes: [
        ShellRoute(
          pageBuilder: (context, state, child) {
            final ID taskId = ID.parse(state.pathParameters['id']!);
            return MaterialPage(
              key: state.pageKey,
              child: BlocProvider<TaskDetailBloc>(
                create: (context) {
                  return TaskDetailBloc(
                    recordId: taskId,
                    dataRepo: context.read<DataRepository<TaskRecord>>(),
                    scheduleRepo:
                        context.read<DataRepository<ReportScheduleRecord>>(),
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
                return TaskDetailPage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
