import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/commons/providers/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:forui/forui.dart';

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
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    final presets = context.read<ThemeBloc>().state.presets;

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
                decoration: presets.input_dec_bordered.copyWith(
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
            if (state is LoadingState) LoadingCircleWidget(),
          ],
        );
      },
    );
  }
}
