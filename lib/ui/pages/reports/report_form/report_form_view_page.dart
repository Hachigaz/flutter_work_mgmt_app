import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/report.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_text_display_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_models/models.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/bloc/report_detail_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_bloc/report_form_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/report_form/_view/report_form.dart';

class _ReportFormViewPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReportFormViewWidget();
  }
}

class ReportFormViewPage extends StatelessWidget {
  const ReportFormViewPage({super.key});

  AppBar _ReportFormViewPageHeader({required BuildContext context}) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;

    void onPressBackButton(BuildContext context) {
      context.pop();
    }

    void onPressSaveButton({required BuildContext context}) {
      final formBloc = context.read<ReportFormBloc>();
      formBloc.add(ReportFormSubmit());
    }

    return AppBar(
      centerTitle: true,
      backgroundColor: colorScheme.background,
      title: Text(
        "Chi tiết báo cáo",
        style: typography.lg.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.foreground,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colorScheme.foreground),
        onPressed: () => onPressBackButton(context),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onPressSaveButton(context: context);
          },
          child: Text("Lưu", style: typography.base),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colorScheme.background,
      child: BlocBuilder<ReportDetailBloc, PageDetailState>(
        builder: (context, state) {
          if (state is ReportDetailStateRecordReady) {
            return BlocProvider<ReportFormBloc>(
              create:
                  (context) => ReportFormBloc(
                    buildType: BuildType.type_default,
                    formTemplateRepo:
                        context
                            .read<DataRepository<ReportFormTemplateRecord>>(),
                    reportDetailBloc: context.read<ReportDetailBloc>(),
                  ),
              child: Builder(
                builder:
                    (context) => BlocBuilder<ReportFormBloc, ReportFormState>(
                      builder: (context, state) {
                        if (state is ReportFormStateReady) {
                          return Scaffold(
                            backgroundColor: colorScheme.background,
                            appBar: _ReportFormViewPageHeader(context: context),
                            body: _ReportFormViewPageContent(),
                          );
                        } else {
                          return LoadingTextDisplayWidget(
                            displayMessage: "Đang tải trang",
                            textStyle: typography.lg.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }
                      },
                      buildWhen: (previous, current) {
                        return previous is! ReportFormStateReady;
                      },
                    ),
              ),
            );
          } else {
            return LoadingTextDisplayWidget(
              displayMessage: "Đang tải thông tin",
              textStyle: typography.lg.copyWith(fontWeight: FontWeight.w600),
            );
          }
        },
      ),
    );
  }
}
