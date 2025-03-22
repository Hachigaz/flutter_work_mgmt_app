import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/report_schedule_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/task_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/task/bloc/task_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/task/task_detail_page.dart';
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
              child: BlocProvider<TaskDetailBloc>(
                create: (context) {
                  return TaskDetailBloc(
                    taskId: taskId,
                    taskRepo: context.read<TaskRepository>(),
                    scheduleRepo: context.read<ReportScheduleRepository>(),
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
                return BlocProvider<ListViewBloc<ReportSchedule>>(
                  create: (context) {
                    return ListViewBloc<ReportSchedule>(
                      dataRepo: context.read<ReportScheduleRepository>(),
                    );
                  },
                  child: TaskDetailPage(),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
