import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:flutter_work_mgmt_app/navigations/_routes/_projects/_contracts/contracts.dart';
import 'package:flutter_work_mgmt_app/navigations/_routes/_projects/_reports/reports.dart';
import 'package:flutter_work_mgmt_app/navigations/_routes/_projects/_tasks/tasks.dart';
import 'package:flutter_work_mgmt_app/navigations/_routes/_projects/_works/works.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/subpages/project_detail/bloc/project_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/subpages/project_detail/project_detail_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/subpages/project_detail/subpages/work_manage/project_work_manage_page.dart';
import 'package:go_router/go_router.dart';

final projectRoutes = <RouteBase>[
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
          final ID projectId = ID.parse(state.pathParameters['id']!);

          return MaterialPage(
            key: state.pageKey,
            child: RepositoryProvider<ProjectDetailBloc>(
              create:
                  (context) => ProjectDetailBloc(
                    recordId: projectId,
                    dataRepo: context.read<DataRepository<ProjectRecord>>(),
                    workItemRepo:
                        context.read<DataRepository<WorkItemRecord>>(),
                  ),
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            path: "/detail",
            builder: (context, state) {
              return ProjectDetailPage();
            },
          ),
          GoRoute(
            path: "/work_manage",
            builder: (context, state) {
              return ProjectWorkManagePage();
            },
          ),
        ],
      ),
    ],
  ),
  workRoute,
  taskRoute,
  contractRoute,
  reportRoute,
];
