import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/data/models/reports.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/list_view_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/search_bar_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/pages/reports/schedule_create/_bloc/schedule_create_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

const double _formPadding = 20;

class ScheduleCreatePage extends StatelessWidget {
  const ScheduleCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    final presets = context.read<ThemeBloc>().state.presets;

    final formLabelStyle = typography.sm.copyWith(fontWeight: FontWeight.w600);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colorScheme.background,
      child: BlocBuilder<ScheduleCreateBloc, ScheduleCreateState>(
        builder: (context, state) {
          if (state is ScheduleCreateStateReady) {
            return Padding(
              padding: EdgeInsets.only(
                top: status_bar_offset,
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: padding_2xl),
                      child: Text(
                        "Tạo lịch báo cáo",
                        style: typography.xl2.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      FTextField(
                        label: Text("Tiêu đề báo cáo", style: formLabelStyle),
                      ),
                      const SizedBox(height: _formPadding),
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: FDatePicker(
                              label: Text(
                                "Ngày báo cáo",
                                style: formLabelStyle,
                              ),
                            ),
                          ),
                          const SizedBox(width: _formPadding),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Định kỳ", style: formLabelStyle),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: BlocSelector<
                                    ScheduleCreateBloc,
                                    ScheduleCreateState,
                                    bool
                                  >(
                                    builder: (context, isRecursive) {
                                      return FSwitch(
                                        value: isRecursive,
                                        onChange: (value) {
                                          context.read<ScheduleCreateBloc>().add(
                                            ScheduleCreateEventChangeScheduleType(
                                              isRecursive: value,
                                            ),
                                          );
                                        },
                                        style: context.theme.switchStyle
                                            .copyWith(
                                              labelLayoutStyle:
                                                  FLabelLayoutStyle(),
                                            ),
                                      );
                                    },
                                    selector: (state) {
                                      if (state is! ScheduleCreateStateReady) {
                                        throw Exception("Unexpected Error");
                                      } else {
                                        return state.isRecursive;
                                      }
                                    },
                                    // buildWhen: (previous, current) {
                                    //   return (previous
                                    //               as ScheduleCreateStateReady)
                                    //           .isRecursive !=
                                    //       (current as ScheduleCreateStateReady)
                                    //           .isRecursive;
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: _formPadding),
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: BlocSelector<
                              ScheduleCreateBloc,
                              ScheduleCreateState,
                              bool
                            >(
                              selector: (state) {
                                if (state is! ScheduleCreateStateReady) {
                                  throw Exception("Unexpected Error");
                                } else {
                                  return state.isRecursive;
                                }
                              },
                              builder: (context, isRecursive) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Chu kỳ",
                                      style: formLabelStyle.copyWith(
                                        color:
                                            isRecursive
                                                ? formLabelStyle.color
                                                : formLabelStyle.color!
                                                    .withAlpha(150),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    SizedBox(
                                      width: double.infinity,
                                      child: DropdownButtonFormField(
                                        style: typography.base,
                                        focusColor: colorScheme.primary
                                            .withAlpha(80),
                                        dropdownColor: colorScheme.muted,
                                        iconEnabledColor: colorScheme.primary,
                                        iconDisabledColor:
                                            colorScheme.mutedForeground,
                                        decoration:
                                            presets.input_dec_default_border,
                                        items: [
                                          DropdownMenuItem(
                                            value: "daily",
                                            child: Text(
                                              "Mỗi ngày",
                                              style: formLabelStyle,
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: "weekly",
                                            child: Text(
                                              "Hàng tuần",
                                              style: formLabelStyle,
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: "monthly",
                                            child: Text(
                                              "Hàng tháng",
                                              style: formLabelStyle,
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: "quarterly",
                                            child: Text(
                                              "Theo quý",
                                              style: formLabelStyle,
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: "yearly",
                                            child: Text(
                                              "Theo năm",
                                              style: formLabelStyle,
                                            ),
                                          ),
                                        ],
                                        onChanged:
                                            isRecursive ? (value) {} : null,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(width: _formPadding),

                          Expanded(
                            flex: 3,
                            child: BlocSelector<
                              ScheduleCreateBloc,
                              ScheduleCreateState,
                              bool
                            >(
                              selector: (state) {
                                if (state is! ScheduleCreateStateReady) {
                                  throw Exception("Unexpected Error");
                                } else {
                                  return state.isRecursive;
                                }
                              },
                              builder: (context, isRecursive) {
                                return FTextField(
                                  enabled: isRecursive,
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  label: Text(
                                    "Số lần báo cáo",
                                    style: formLabelStyle.copyWith(
                                      color:
                                          isRecursive
                                              ? formLabelStyle.color
                                              : formLabelStyle.color!.withAlpha(
                                                150,
                                              ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: _formPadding),
                      _FormTemplateSelectButton(formLabelStyle: formLabelStyle),
                      const SizedBox(height: _formPadding * 2),
                      FButton(
                        onPress: () {},
                        label: Text(
                          "Tạo lịch báo cáo",
                          style: formLabelStyle.copyWith(
                            color: colorScheme.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
        buildWhen: (previous, current) => previous is! ScheduleCreateStateReady,
      ),
    );
  }
}

class _FormTemplateSelectButton extends StatelessWidget {
  final TextStyle _formLabelStyle;

  const _FormTemplateSelectButton({required TextStyle formLabelStyle})
    : _formLabelStyle = formLabelStyle;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Mẫu báo cáo", style: _formLabelStyle),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              flex: 7,
              child: BlocSelector<
                ScheduleCreateBloc,
                ScheduleCreateState,
                ReportFormTemplateRecord?
              >(
                selector: (state) {
                  if (state is! ScheduleCreateStateReady) {
                    throw Exception("Unexpected Error");
                  }
                  return state.templateRecord;
                },
                builder: (context, templateRecord) {
                  return FTextField(
                    controller: TextEditingController.fromValue(
                      TextEditingValue(text: templateRecord?.formName ?? ""),
                    ),
                    readOnly: true,
                  );
                },
              ),
            ),
            const SizedBox(width: _formPadding),
            Expanded(
              flex: 3,
              child: FButton(
                onPress: () {
                  onClickSelectTemplateButton(context: context);
                },
                label: Text(
                  "Chọn mẫu",
                  style: _formLabelStyle.copyWith(
                    color: colorScheme.background,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> onClickSelectTemplateButton({
    required BuildContext context,
  }) async {
    final result = await showAdaptiveDialog<ReportFormTemplateRecord?>(
      context: context,
      builder: (context) {
        return _FormTemplateSelectDialogWidget();
      },
      barrierDismissible: false,
    );
    if (result != null) {
      if (context.mounted) {
        context.read<ScheduleCreateBloc>().add(
          ScheduleCreateEventSelectTemplate(templateRecord: result),
        );
      }
    }
  }
}

class _FormTemplateSelectItem extends StatelessWidget {
  final ReportFormTemplateRecord formTemplate;

  const _FormTemplateSelectItem({required this.formTemplate});
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorScheme.primary.darker(10).withAlpha(50),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formTemplate.formName,
            style: typography.base.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FButton.raw(
                onPress: () {
                  onClickViewTemplate(context: context);
                },
                style: FButtonStyle.secondary,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Text("Xem mẫu", style: typography.sm),
                ),
              ),
              const SizedBox(width: 8),
              FButton.raw(
                style: FButtonStyle.primary,
                onPress: () {
                  onClickSelectTemplate(context: context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Text("Chọn", style: typography.sm),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onClickViewTemplate({required BuildContext context}) {
    context.push(
      "${context.namedLocation("reports")}/templates/${formTemplate.id}/view",
    );
  }

  void onClickSelectTemplate({required BuildContext context}) {
    Navigator.of(context).pop<ReportFormTemplateRecord>(formTemplate);
  }
}

class _FormTemplateSelectDialogWidget extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final templateListBloc = ListViewBloc<ReportFormTemplateRecord>(
      dataRepo: context.read<DataRepository<ReportFormTemplateRecord>>(),
    );
    return FDialog(
      style: context.theme.dialogStyle.copyWith(
        decoration: context.theme.dialogStyle.decoration.copyWith(
          color: colorScheme.background.mix(colorScheme.muted, 0.4),
        ),
      ),
      direction: Axis.horizontal,
      title: const Text('Chọn mẫu báo cáo'),
      body: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 400.w,
          height: 400.h,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: SearchBarWidget<
                  ReportFormTemplateRecord,
                  ListViewStateLoading<ReportFormTemplateRecord>,
                  ListViewEventSearchCall<ReportFormTemplateRecord>
                >(
                  hintText: "Nhập mẫu báo cáo",
                  searchCallCreator:
                      (searchValue) =>
                          ListViewEventSearchCall(searchValue: searchValue),
                  listBloc: templateListBloc,
                ),
              ),
              Expanded(
                flex: 9,
                child: ListViewWidget<ReportFormTemplateRecord>(
                  listBloc: templateListBloc,
                  scrollController: _scrollController,
                  listBuilder: (itemList) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: _FormTemplateSelectItem(
                            formTemplate: itemList[index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FButton(
          style: FButtonStyle.outline,
          label: const Text('Hủy'),
          onPress: () => Navigator.of(context).pop(),
        ),
        // FButton(
        //   label: const Text('Chọn'),
        //   onPress: () => Navigator.of(context).pop(),
        // ),
      ],
    );
  }
}
