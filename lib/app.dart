import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/auth/auth_repo.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/project_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/report_form_template_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/report_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/report_schedule_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/task_report_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/task_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/work_item_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_loader_bloc/app_loader_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_loader_bloc/repos/storage_repo.dart';
import 'package:flutter_work_mgmt_app/commons/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:forui/forui.dart';
import 'package:flutter_work_mgmt_app/commons/navigation/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        //main app loader level
        return BlocProvider<AppLoaderBloc>(
          create: (context) {
            return AppLoaderBloc();
          },
          //repositories loaded from app loader
          child: Builder(
            builder: (context) {
              return BlocBuilder<AppLoaderBloc, AppLoaderState>(
                builder: (context, state) {
                  if (state is AppLoaderStateReady) {
                    return MultiRepositoryProvider(
                      providers: [
                        RepositoryProvider(
                          create: (context) => state.storageRepo,
                        ),
                      ],
                      //data level providers
                      child: Builder(
                        builder: (context) {
                          return MultiRepositoryProvider(
                            providers: [
                              RepositoryProvider<AuthRepository>(
                                create:
                                    (context) => AuthRepository(
                                      context.read<StorageRepository>(),
                                    ),
                              ),
                              RepositoryProvider<DataRepository<ProjectRecord>>(
                                create: (context) => ProjectRepository(),
                              ),
                              RepositoryProvider<
                                DataRepository<WorkItemRecord>
                              >(create: (context) => WorkItemRepository()),
                              RepositoryProvider<DataRepository<TaskRecord>>(
                                create: (context) => TaskRepository(),
                              ),
                              RepositoryProvider<
                                DataRepository<ReportSchedule>
                              >(
                                create: (context) => ReportScheduleRepository(),
                              ),
                              RepositoryProvider<
                                DataRepository<TaskReportRecord>
                              >(create: (context) => ReportRepository()),
                              RepositoryProvider<
                                DataRepository<TaskReportRecord>
                              >(create: (context) => TaskReportRepository()),
                              RepositoryProvider<
                                DataRepository<ReportFormTemplateRecord>
                              >(
                                create:
                                    (context) => ReportFormTemplateRepository(),
                              ),
                            ],

                            // ui level providers
                            child: MultiBlocListener(
                              listeners: [
                                BlocProvider(
                                  create:
                                      (context) => ThemeBloc(
                                        storageRepo:
                                            context.read<StorageRepository>(),
                                      ),
                                ),
                              ],
                              child: MaterialApp.router(
                                title: 'QLDA',
                                routerConfig: router,
                                builder:
                                    (
                                      context,
                                      child,
                                    ) => BlocBuilder<ThemeBloc, ThemeState>(
                                      builder: (context, state) {
                                        return FTheme(
                                          data:
                                              state.appThemeMode
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
                      ),
                    );
                  } else {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                    );
                  }
                },
              );
            },
          ),
        );
        // data manage level providers
      },
    );
  }
}
