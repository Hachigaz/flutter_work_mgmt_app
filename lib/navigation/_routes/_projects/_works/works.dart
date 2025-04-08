import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/pages/works/work_create/_bloc/work_item_create_page_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/works/work_create/work_create_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/works/work_detail/_bloc/work_item_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/works/work_detail/_subpages/task_manage/task_manage.dart';
import 'package:flutter_work_mgmt_app/ui/pages/works/work_detail/work_item_detail_page.dart';
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
              key: state.pageKey,
              child: RepositoryProvider<WorkItemDetailBloc>(
                create: (context) {
                  return WorkItemDetailBloc(
                    recordId: workId,
                    dataRepo: context.read<DataRepository<WorkItemRecord>>(),
                    taskRepo: context.read<DataRepository<TaskRecord>>(),
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
                return WorkItemDetailPage();
              },
            ),
            GoRoute(
              path: "/task_manage",
              builder: (context, state) {
                return WorkItemTaskManagePage();
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/create/:project_id",
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: BlocProvider<WorkItemCreatePageBloc>(
            create: (context) {
              return WorkItemCreatePageBloc();
            },
            child: WorkItemCreatePage(),
          ),
        );
      },
    ),
  ],
);
