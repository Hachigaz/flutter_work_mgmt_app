import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:forui/forui.dart';

class SearchBarWidget<
  T extends DataRecord,
  LoadingState extends ListViewStateLoading<T>,
  SearchCallEvent extends ListViewEventSearchCall<T>
>
    extends StatelessWidget {
  final String hintText;
  final SearchCallEvent Function(String) searchCallCreator;
  final ListViewBloc<T> listBloc;

  const SearchBarWidget({
    super.key,
    required this.hintText,
    required this.searchCallCreator,
    required this.listBloc,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    final presets = context.read<ThemeBloc>().state.presets;

    return BlocBuilder<ListViewBloc<T>, ListViewState<T>>(
      bloc: this.listBloc,
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: 200.w,
              child: TextField(
                enabled: state is! LoadingState,
                style: typography.base,
                cursorColor: colorScheme.primary,
                cursorErrorColor: colorScheme.error,
                keyboardType: TextInputType.text,
                decoration: presets.input_dec_rounded_border.copyWith(
                  hintText: hintText,
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme.secondaryForeground,
                    size: 30,
                  ),
                ),
                maxLines: 1,
                onSubmitted: (value) {
                  if (state is! LoadingState) {
                    listBloc.add(searchCallCreator(value));
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
