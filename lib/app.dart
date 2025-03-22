import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/report_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/report_schedule_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/task_repository.dart';
import 'package:forui/forui.dart';
import 'package:flutter_work_mgmt_app/commons/navigation/router.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_providers/auth_repo.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';

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
        return MaterialApp.router(
          title: 'QLDA',
          routerConfig: router,
          builder:
              (context, child) => MultiRepositoryProvider(
                providers: [
                  RepositoryProvider<AuthRepository>(
                    create: (_) => AuthRepository(),
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
                child: FTheme(data: appThemeData, child: child!),
              ),
        );
      },
    );
  }
}
