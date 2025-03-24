import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:forui/forui.dart';

class ListViewWidget<T> extends StatefulWidget {
  final ScrollController? scrollController;
  final Widget Function(T) listItemBuilder;

  const ListViewWidget({
    super.key,
    required this.listItemBuilder,
    this.scrollController,
  });

  @override
  State<StatefulWidget> createState() => ListViewWidgetState<T>();
}

class ListViewWidgetState<T> extends State<ListViewWidget<T>> {
  @override
  void initState() {
    if (widget.scrollController != null) {
      final scrollController = widget.scrollController as ScrollController;
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent) {
          final taskListBloc = context.read<ListViewBloc<T>>();
          if (!taskListBloc.state.isLast &&
              taskListBloc.state is ListViewStateReady) {
            taskListBloc.add(ListViewEventLoadMoreCall());
          }
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.scrollController != null) {
      final scrollController = widget.scrollController as ScrollController;
      scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return BlocBuilder<ListViewBloc<T>, ListViewState<T>>(
      builder: (context, state) {
        if (state.itemList.isEmpty) {
          return Align(
            alignment: Alignment.center,
            child: Text("Chưa có dữ liệu"),
          );
        } else {
          return Column(
            children: [
              for (final item in state.itemList) widget.listItemBuilder(item),
              if (state is ListViewStateLoading)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: LoadingCircleWidget(),
                ),
            ],
          );
        }
      },
    );
  }
}
