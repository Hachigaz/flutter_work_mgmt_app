import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/auth_repo.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repositories/project_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repositories/report_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repositories/report_schedule_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repositories/task_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repositories/work_item_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/blocs/theme/theme_bloc.dart';
import 'package:forui/forui.dart';
import 'package:flutter_work_mgmt_app/commons/navigation/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      // designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        // set color theme
        return MultiBlocListener(
          listeners: [
            BlocProvider(
              create:
                  (_) => ThemeBloc(
                    initialTheme: FThemes.green,
                    isModeLight: false,
                  ),
            ),
          ],
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthRepository>(
                create: (_) => AuthRepository(),
              ),
              RepositoryProvider<ProjectRepository>(
                create: (_) => ProjectRepository(),
              ),
              RepositoryProvider<WorkItemRepository>(
                create: (_) => WorkItemRepository(),
              ),
              RepositoryProvider<TaskRepository>(
                create: (_) => TaskRepository(),
              ),
              RepositoryProvider<ReportScheduleRepository>(
                create: (_) => ReportScheduleRepository(),
              ),
              RepositoryProvider<ReportRepository>(
                create: (_) => ReportRepository(),
              ),
            ],
            child: MaterialApp.router(
              title: 'QLDA',
              routerConfig: router,
              builder:
                  (context, child) => BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return FTheme(
                        data:
                            state.isModeLight
                                ? state.currentThemeSet.light
                                : state.currentThemeSet.dark,
                        child: child!,
                      );
                    },
                  ),
            ),
          ),
        );
      },
    );
  }
}
