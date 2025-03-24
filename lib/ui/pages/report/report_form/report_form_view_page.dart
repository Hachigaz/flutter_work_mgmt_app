import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/commons/form_builder/bloc/report_form_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/report/commons/form_builder/views/report_form.dart';

class _ReportFormViewPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReportForm();
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

    // final typography = context.theme.typography;
    return BlocBuilder<ReportFormBloc, ReportFormState>(
      builder: (context, state) {
        if (state is ReportFormStateLoading) {
          return Scaffold(
            backgroundColor: colorScheme.background,
            body: Center(child: LoadingCircleWidget()),
          );
        } else if (state is ReportFormStateReady) {
          return Scaffold(
            backgroundColor: colorScheme.background,
            appBar: _ReportFormViewPageHeader(context: context),
            body: _ReportFormViewPageContent(),
          );
        }
        return Container();
      },
      buildWhen: (previous, current) {
        return previous is! ReportFormStateReady;
      },
    );
  }
}
