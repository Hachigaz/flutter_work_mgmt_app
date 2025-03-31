import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';

class ListViewWidget<T extends DataRecord> extends StatefulWidget {
  final ScrollController? scrollController;
  final Widget Function(List<T>) listBuilder;
  final ListViewBloc<T>? listBloc;

  const ListViewWidget({
    super.key,
    this.scrollController,
    required this.listBuilder,
    this.listBloc,
  });

  @override
  State<StatefulWidget> createState() => _ListViewWidgetState<T>();
}

class _ListViewWidgetState<T extends DataRecord>
    extends State<ListViewWidget<T>> {
  @override
  void initState() {
    if (widget.scrollController != null) {
      final scrollController = widget.scrollController as ScrollController;
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent) {
          final taskListBloc =
              widget.listBloc ?? context.read<ListViewBloc<T>>();
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
    final childWidget = BlocBuilder<ListViewBloc<T>, ListViewState<T>>(
      bloc: widget.listBloc,
      builder: (context, state) {
        if (state.itemList.isEmpty) {
          return Align(
            alignment: Alignment.center,
            child: Text("Chưa có dữ liệu"),
          );
        } else {
          return widget.listBuilder(state.itemList);
        }
      },
    );

    return widget.listBloc != null
        ? BlocProvider<ListViewBloc<T>>.value(
          value: widget.listBloc!,
          child: childWidget,
        )
        : BlocProvider<ListViewBloc<T>>(
          create: (context) {
            return ListViewBloc<T>(dataRepo: context.read<DataRepository<T>>());
          },
          child: childWidget,
        );
  }
}
