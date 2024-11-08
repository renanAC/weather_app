import 'dart:ui';
import 'package:weather_app/design_system/colors/primitive_color_palette.dart';

class AlertColorGroup {
  const AlertColorGroup({
    this.error = PrimitiveColorPalette.red,
  });

  final Color error;
}
