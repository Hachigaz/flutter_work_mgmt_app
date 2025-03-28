import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/data_repository.dart';
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
                        context.read<DataRepository<ReportSchedule>>(),
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
