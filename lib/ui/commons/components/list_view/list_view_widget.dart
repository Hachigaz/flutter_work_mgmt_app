import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_text_display_widget.dart';
import 'package:forui/forui.dart';

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
          final blocState = taskListBloc.state;
          if (blocState is ListViewStateLoading<T>) {
            taskListBloc.add(ListViewEventLoadMoreCall<T>());
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
    final typography = context.theme.typography;
    final childWidget = BlocBuilder<ListViewBloc<T>, ListViewState<T>>(
      bloc: widget.listBloc,
      builder: (context, state) {
        if (state is ListViewStateInitial<T>) {
          return LoadingCircleWidget();
        } else if (state is ListViewStateReadyBase<T>) {
          return BlocBuilder<ListViewBloc<T>, ListViewState<T>>(
            builder: (context, readyState) {
              readyState = readyState as ListViewStateReadyBase<T>;
              if (readyState.itemList.isEmpty) {
                if (readyState is ListViewStateLoading) {
                  return LoadingCircleWidget();
                } else {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Chưa có dữ liệu",
                      style: typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
              } else {
                return widget.listBuilder(readyState.itemList);
              }
            },
          );
        } else {
          throw Exception("Unexpected Error");
        }
      },
      buildWhen: (previous, current) {
        return previous is! ListViewStateReadyBase<T>;
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
