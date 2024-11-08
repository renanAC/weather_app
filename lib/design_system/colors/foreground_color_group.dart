import 'dart:ui';

import 'package:weather_app/design_system/colors/primitive_color_palette.dart';

class ForegroundColorGroup {
  const ForegroundColorGroup.light({
    this.primary = const ForegroundColorAspectPrimaryLight(),
  });

  const ForegroundColorGroup.dark({
    this.primary = const ForegroundColorAspectPrimaryDark(),
  });

  final ForegroundColorAspectPrimary primary;
}

class ForegroundColorAspectPrimary {
  const ForegroundColorAspectPrimary({
    this.dark = PrimitiveColorPalette.blue900,
    this.medium = PrimitiveColorPalette.blue500,
    this.light = PrimitiveColorPalette.blue300,
    this.white = PrimitiveColorPalette.blue100,
  });
  final Color dark;
  final Color medium;
  final Color light;
  final Color white;
}

class ForegroundColorAspectPrimaryLight extends ForegroundColorAspectPrimary {
  const ForegroundColorAspectPrimaryLight({
    super.dark = PrimitiveColorPalette.blue900,
    super.medium = PrimitiveColorPalette.blue500,
    super.light = PrimitiveColorPalette.blue300,
    super.white = PrimitiveColorPalette.blue100,
  });
}

class ForegroundColorAspectPrimaryDark extends ForegroundColorAspectPrimary {
  const ForegroundColorAspectPrimaryDark({
    super.dark = PrimitiveColorPalette.blue900,
    super.medium = PrimitiveColorPalette.blue500,
    super.light = PrimitiveColorPalette.blue300,
    super.white = PrimitiveColorPalette.blue100,
  });
}
