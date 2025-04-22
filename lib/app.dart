import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/data/data_layer.dart';
import 'package:flutter_work_mgmt_app/providers/auth/auth_repo.dart';
import 'package:flutter_work_mgmt_app/providers/backend_socket/bloc/backend_socket_bloc.dart';
import 'package:flutter_work_mgmt_app/providers/base_loader/base_loader_bloc.dart';
import 'package:flutter_work_mgmt_app/providers/base_loader/repos/storage_repo.dart';
import 'package:flutter_work_mgmt_app/providers/ui/theme/theme_bloc.dart';
import 'package:forui/forui.dart';
import 'package:flutter_work_mgmt_app/navigations/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        //base loader level
        return BlocProvider<BaseLoaderBloc>(
          create: (context) {
            return BaseLoaderBloc();
          },
          //repositories loaded from app loader
          child: Builder(
            builder: (context) {
              return BlocBuilder<BaseLoaderBloc, BaseLoaderState>(
                builder: (context, state) {
                  if (state is BaseLoaderStateReady) {
                    return MultiRepositoryProvider(
                      providers: [
                        RepositoryProvider(
                          create: (context) => state.storageRepo,
                        ),
                      ],
                      child: Builder(
                        builder: (context) {
                          //data level providers
                          return _AppDataProvidersWidget(
                            child: MultiBlocProvider(
                              providers: [
                                BlocProvider<BackendSocketBloc>(
                                  lazy: false,
                                  create: (context) {
                                    return BackendSocketBloc();
                                  },
                                ),
                                BlocProvider<ThemeBloc>(
                                  create: (context) {
                                    return ThemeBloc(
                                      storageRepo:
                                          context.read<StorageRepository>(),
                                    );
                                  },
                                ),
                              ],
                              child: MaterialApp.router(
                                title: 'QLDA',
                                routerConfig: router,
                                debugShowCheckedModeBanner: false,
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
                                          child: _GlobalAppListenersWidget(
                                            child: child!,
                                          ),
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

class _GlobalAppListenersWidget extends StatelessWidget {
  final Widget child;

  const _GlobalAppListenersWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BackendSocketBloc, BackendSocketState>(
          listener: (context, state) {},
        ),
      ],
      child: child,
    );
  }
}

class _AppDataProvidersWidget extends StatelessWidget {
  final Widget child;

  const _AppDataProvidersWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create:
              (context) => AuthRepository(context.read<StorageRepository>()),
        ),
        RepositoryProvider.value(value: dataLayer.projectRepository),
        RepositoryProvider.value(value: dataLayer.workItemRepository),
        RepositoryProvider.value(value: dataLayer.taskRepository),
        RepositoryProvider.value(value: dataLayer.reportScheduleRepository),
        RepositoryProvider.value(value: dataLayer.taskReportRepository),
        RepositoryProvider.value(value: dataLayer.reportFormTemplateRepository),
        RepositoryProvider.value(value: dataLayer.notificationRepository),
      ],

      // ui level providers
      child: child,
    );
  }
}

class _AppBaseProviderWidget extends StatelessWidget {
  final Widget child;

  const _AppBaseProviderWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
