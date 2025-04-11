import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/ui/pages/current_work/current_work_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/notifications/notification_page.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_work_mgmt_app/ui/commons/components/menu_frame.dart';

import 'package:flutter_work_mgmt_app/ui/pages/home/home.dart';
import 'package:flutter_work_mgmt_app/ui/pages/login/login_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/project_root_page.dart';
import 'package:flutter_work_mgmt_app/ui/pages/account/account_info_page.dart';

import "_routes/export.dart";

final routes = <RouteBase>[
  // GoRoute(path: "/", redirect: (context, state) => "/debug"),
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
          GoRoute(
            path: "/debug",
            redirect: (context, state) => "/notification",
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: "/projects",
            name: "projects",
            pageBuilder: (context, state) {
              return MaterialPage(key: state.pageKey, child: ProjectRootPage());
            },
            routes: projectRoutes,
          ),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            path: "/current_work",
            name: "current_work",
            pageBuilder: (context, state) {
              return MaterialPage(key: state.pageKey, child: CurrentWorkPage());
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
              return MaterialPage(
                key: state.pageKey,
                child: NotificationPage(),
              );
            },
          ),
        ],
      ),
      // StatefulShellBranch(
      //   routes: <RouteBase>[
      //     GoRoute(
      //       path: "/mailbox",
      //       name: "mailbox",
      //       pageBuilder: (context, state) {
      //         return MaterialPage(key: state.pageKey, child: HomePage());
      //       },
      //     ),
      //   ],
      // ),
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
