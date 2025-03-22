import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/input_style_presets.dart';

class SearchBarWidget<
  ListBloc extends Bloc<ListEvent, ListState>,
  ListState extends ListViewState,
  ListEvent extends ListViewEvent,
  LoadingState extends ListState,
  SearchCallEvent extends ListEvent
>
    extends StatelessWidget {
  final String hintText;
  final SearchCallEvent Function(String) searchCallCreator;

  const SearchBarWidget({
    super.key,
    required this.hintText,
    required this.searchCallCreator,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;
    return BlocBuilder<ListBloc, ListState>(
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
                decoration: input_dec_bordered.copyWith(
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
                    context.read<ListBloc>().add(searchCallCreator(value));
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            if (state is LoadingState)
              CircularProgressIndicator(color: colorScheme.secondaryForeground),
          ],
        );
      },
    );
  }
}
