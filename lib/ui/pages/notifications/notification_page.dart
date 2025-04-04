import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_work_mgmt_app/data/models/notifications.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_text_display_widget.dart';
import 'package:flutter_work_mgmt_app/ui/pages/notifications/_bloc/page_bloc/notification_page_bloc.dart';
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
            child: Text(
              "Thông báo mới",
              style: typography.xl.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          _NotificationListWidget(),
        ],
      ),
    );
  }
}

class _NotificationListWidget extends StatefulWidget {
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

  bool isFrameCalled = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<NotificationPageBloc, NotificationPageState>(
        builder: (context, state) {
          if (state is NotificationPageStateInitial) {
            return LoadingTextDisplayWidget();
          } else if (state is NotificationPageStateReady) {
            if (!isFrameCalled) {
              //add callback at the end of the frame where page state is ready, load the initial list
              WidgetsBinding.instance.addPostFrameCallback((duration) {
                final pageBloc = context.read<NotificationPageBloc>();
                final pageState = pageBloc.state;
                if (pageState is NotificationPageStateReady) {
                  pageBloc.updateList(0, pageState.notifications.length);
                }
              });
              isFrameCalled = true;
            }
            return AnimatedList(
              key: context.read<NotificationPageBloc>().listKey,
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
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: _NotificationListItem(
                      record: state.notifications[index],
                    ),
                  ),
                );
              },
            );
          } else {
            throw Exception("Unexpected Error");
          }
        },
        buildWhen: (previous, current) {
          return (previous is! NotificationPageStateReady);
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
    return Container(
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
