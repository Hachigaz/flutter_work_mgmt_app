import 'dart:ui';

Color colorShift({required Color color, int r = 0, int g = 0, int b = 0}) {
  var returnColor = color;

  final colorRed = (color.r * 255).toInt();
  final colorGreen = (color.g * 255).toInt();
  final colorBlue = (color.b * 255).toInt();

  if (r > 0) {
    if (colorRed <= 125) {
      returnColor = returnColor.withRed(colorRed + r);
    } else {
      // red = (red / 2).toInt();
      returnColor = returnColor.withGreen(colorGreen - r);
      returnColor = returnColor.withBlue(colorBlue - r);
    }
  }
  if (g > 0) {
    if (colorGreen <= 125) {
      returnColor = returnColor.withGreen(colorGreen + g);
    } else {
      // green = (green / 2).toInt();
      returnColor = returnColor.withRed(colorRed - g);
      returnColor = returnColor.withBlue(colorBlue - g);
    }
  }
  if (b > 0) {
    if (colorBlue <= 125) {
      returnColor = returnColor.withBlue(colorBlue + b);
    } else {
      // blue = (blue / 2).toInt();
      returnColor = returnColor.withRed(colorRed - b);
      returnColor = returnColor.withGreen(colorGreen - b);
    }
  }
  return returnColor;
}
