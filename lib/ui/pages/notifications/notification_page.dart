import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_work_mgmt_app/data/models/notifications.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/list_view_widget.dart';
import 'package:forui/forui.dart';

class _NotificationPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Thông báo mới",
                  style: typography.xl.copyWith(fontWeight: FontWeight.w700),
                ),
                FTappable.animated(
                  onPress: () {},
                  child: Text(
                    "Tải lại",
                    style: typography.base.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _NotificationListWidget(),
        ],
      ),
    );
  }
}

class _NotificationListWidget extends StatefulWidget {
  final _listKey = GlobalKey<AnimatedListState>();
  final _scrollController = ScrollController();

  @override
  State<StatefulWidget> createState() {
    return _NotificationListWidgetState();
  }
}

class _NotificationListWidgetState extends State<_NotificationListWidget> {
  @override
  void initState() {
    super.initState();
  }

  // int _lastIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListViewWidget<NotificationRecord>(
        scrollController: widget._scrollController,
        listBloc: ListViewBloc(
          dataRepo: context.read<DataRepository<NotificationRecord>>(),
        ),
        listBuilder: (itemList) {
          // add callback at the end of the frame where page state is ready, load the list
          WidgetsBinding.instance.addPostFrameCallback((duration) {
            //   if (_lastIndex < itemList.length) {
            //     widget._listKey.currentState!.insertAllItems(
            //       _lastIndex,
            //       itemList.length - _lastIndex,
            //     );
            //     _lastIndex = itemList.length - 1;
            //   }
            widget._listKey.currentState!.insertAllItems(0, itemList.length);
          });

          return AnimatedList(
            controller: widget._scrollController,
            key: widget._listKey,
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            itemBuilder: (context, index, animation) {
              final offsetAnimation = Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubicEmphasized,
                ),
              );
              return SlideTransition(
                position: offsetAnimation,
                child: _NotificationListItem(record: itemList[index]),
              );
            },
          );
        },
      ),
    );
  }
}

class _NotificationListItem extends StatelessWidget {
  final NotificationRecord record;

  const _NotificationListItem({required this.record});
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    return Dismissible(
      key: ValueKey(record.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.green[300]!.withAlpha(150),
        child: Align(
          alignment: Alignment.center,
          child: Icon(Icons.check, size: 40, color: Colors.white),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colorScheme.background
                .mix(colorScheme.primary, 0.09)!
                .withAlpha(180),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: colorScheme.foreground.withAlpha(150),
                  ),
                  width: 20,
                  height: 20,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        "${record.title}",
                        style: typography.base.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "${record.message}",
                        style: typography.base.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  AppBar _pageAppBar(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;

    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        "Thông báo",
        style: typography.xl.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: _pageAppBar(context),
      body: _NotificationPageContent(),
    );
  }
}
