import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final contractRoute = GoRoute(
  path: "/contracts",
  name: "contracts",
  builder: (context, state) => Container(),
  routes: [
    GoRoute(
      path: "/detail/:id",
      pageBuilder: (context, state) {
        return MaterialPage(key: state.pageKey, child: Container());
      },
    ),
    GoRoute(
      path: "create/:project_id",
      pageBuilder: (context, state) {
        return MaterialPage(key: state.pageKey, child: Container());
      },
    ),
  ],
);
