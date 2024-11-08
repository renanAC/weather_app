import 'package:flutter/material.dart';
import 'package:weather_app/design_system/colors/alert_color_group.dart';
import 'package:weather_app/design_system/colors/foreground_color_group.dart';

abstract interface class MovieAppColorScheme {
  ForegroundColorGroup get foreground;
  AlertColorGroup get alert;
}

class RegularColorScheme implements MovieAppColorScheme {
  RegularColorScheme({required this.mode});
  final Brightness mode;
  @override
  ForegroundColorGroup get foreground => mode == Brightness.dark
      ? const ForegroundColorGroup.dark()
      : const ForegroundColorGroup.light();

  @override
  AlertColorGroup get alert => const AlertColorGroup();
}
