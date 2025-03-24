import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repositories/task_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/_components/bloc/work_item_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/subpages/task_manage/bloc/task_manage_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/subpages/task_manage/task_manage.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/work_item_detail_page.dart';
import 'package:go_router/go_router.dart';

final workRoute = GoRoute(
  path: "/works",
  name: "works",
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
            final ID workId = ID.parse(state.pathParameters['id']!);
            return MaterialPage(
              child: RepositoryProvider<WorkItemDetailBloc>(
                create: (context) {
                  return WorkItemDetailBloc(workItemId: workId);
                },
                child: child,
              ),
            );
          },
          routes: [
            GoRoute(
              path: "/detail",
              builder: (context, state) {
                return WorkItemDetailPage();
              },
            ),
            GoRoute(
              path: "/task_manage",
              builder: (context, state) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<TaskManageBloc>(
                      create: (context) => TaskManageBloc(),
                    ),
                    BlocProvider<ListViewBloc<TaskRecord>>(
                      create:
                          (context) => ListViewBloc<TaskRecord>(
                            dataRepo: context.read<TaskRepository>(),
                          ),
                    ),
                  ],
                  child: WorkItemTaskManagePage(),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
