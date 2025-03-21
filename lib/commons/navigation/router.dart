import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_work_mgmt_app/commons/models/model.dart';

import 'package:flutter_work_mgmt_app/ui/commons/components/menu_frame.dart';

import 'package:flutter_work_mgmt_app/ui/pages/home/home.dart';
import 'package:flutter_work_mgmt_app/ui/pages/login/login_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/bloc/project_root_repository.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/subpages/project_detail/bloc/project_detail_repo.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/subpages/project_detail/project_detail_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/subpages/project_detail/subpages/work_manage/project_work_manage_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/project_root/project_root_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/bloc/report_form_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/commons/form_builder/models/models.dart';
import 'package:flutter_work_mgmt_app/ui/pages/task/bloc/task_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/task/task_detail_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/account/account_info_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/bloc/work_item_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/subpages/task_manage/bloc/task_manage_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/subpages/task_manage/task_manage.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/work_item_detail_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/report_form_view_page.dart';

final routes = <RouteBase>[
  GoRoute(path: "/", redirect: (context, state) => "/login"),
  GoRoute(
    path: "/login",
    name: "login",
    builder: (context, state) {
      return const Scaffold(body: LoginPage());
    },
  ),
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return MainAppScaffold(navigationShell: navigationShell);
    },
    branches: <StatefulShellBranch>[
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            path: "/home",
            name: "home",
            pageBuilder: (context, state) {
              return MaterialPage(key: state.pageKey, child: HomePage());
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: "/projects",
            name: "projects",
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: RepositoryProvider(
                  create: (context) => ProjectRootRepository(),
                  child: ProjectRootPage(),
                ),
              );
            },
            routes: <RouteBase>[
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
                      final ID projectId = ID.parse(
                        state.pathParameters['id']!,
                      );

                      return MaterialPage(
                        key: state.pageKey,
                        child: RepositoryProvider<ProjectDetailPageRepository>(
                          create:
                              (context) => ProjectDetailPageRepository(
                                projectId: projectId,
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
              GoRoute(
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
                          final ID workId = ID.parse(
                            state.pathParameters['id']!,
                          );
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
                                  BlocProvider<TaskManageTaskListBloc>(
                                    create:
                                        (context) => TaskManageTaskListBloc(),
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
              ),
              GoRoute(
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
                          final ID taskId = ID.parse(
                            state.pathParameters['id']!,
                          );
                          return MaterialPage(
                            child: BlocProvider<TaskDetailBloc>(
                              create: (context) {
                                return TaskDetailBloc(taskId: taskId);
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
                          GoRoute(
                            path: "/task_manage",
                            builder: (context, state) {
                              return TaskDetailPage();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: "/contracts",
                name: "contracts",
                builder: (context, state) => Container(),
                routes: [
                  GoRoute(
                    path: "/detail/:id",
                    pageBuilder: (context, state) {
                      return MaterialPage(
                        key: state.pageKey,
                        child: BlocProvider<ReportFormBloc>(
                          create:
                              (context) => ReportFormBloc(
                                buildType: BuildType.type_default,
                                reportFormStructureId: 1,
                                reportFormId: 1,
                              ),
                          child: ReportFormViewPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
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
                          final ID taskId = ID.parse(
                            state.pathParameters['id']!,
                          );
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
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            path: "/payment",
            name: "payment",
            pageBuilder: (context, state) {
              return MaterialPage(key: state.pageKey, child: HomePage());
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            path: "/notification",
            name: "notification",
            pageBuilder: (context, state) {
              return MaterialPage(key: state.pageKey, child: HomePage());
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            path: "/mailbox",
            name: "mailbox",
            pageBuilder: (context, state) {
              return MaterialPage(key: state.pageKey, child: HomePage());
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            path: "/account",
            name: "account",
            pageBuilder: (context, state) {
              return MaterialPage(key: state.pageKey, child: AccountInfoPage());
            },
          ),
        ],
      ),
    ],
  ),
];

final router = GoRouter(routes: routes);
