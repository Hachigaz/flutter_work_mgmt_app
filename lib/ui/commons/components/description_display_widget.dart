import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

String _truncateString(String a, int maxLength) {
  return a.length > maxLength ? "${a.substring(0, maxLength)}..." : a;
}

class DescriptionDisplayWidget extends StatelessWidget {
  final int maxLines;
  late final String? descriptionShortened;
  final String? description;
  final TextStyle descriptionTextStyle;
  final isExpanded = ValueNotifier<bool>(false);

  DescriptionDisplayWidget({
    super.key,
    required this.description,
    required this.descriptionTextStyle,
    this.maxLines = 2,
  }) {
    if (description != null) {
      descriptionShortened = _truncateString(description!, 90);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (description == null || description!.isEmpty)
        ? Text("Chưa có mô tả", style: descriptionTextStyle)
        : ValueListenableBuilder<bool>(
          valueListenable: isExpanded,
          builder: (context, isExpanded, child) {
            if (isExpanded) {
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: description, style: descriptionTextStyle),
                    TextSpan(
                      text: " Thu nhỏ",
                      style: descriptionTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              this.isExpanded.value = false;
                            },
                    ),
                  ],
                ),
              );
            }
            return RichText(
              text: TextSpan(
                style: descriptionTextStyle,
                children: [
                  TextSpan(
                    text: descriptionShortened,
                    style: descriptionTextStyle,
                  ),
                  TextSpan(
                    text: " Xem thêm",
                    style: descriptionTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            this.isExpanded.value = true;
                          },
                  ),
                ],
              ),
            );
          },
        );
  }
}
