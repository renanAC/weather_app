import 'package:flutter/material.dart';
import 'package:weather_app/design_system/tokens/tokens_provider.dart';
import 'package:weather_app/design_system/typography/typography_extension.dart';

class AppBarWheather extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWheather({
    super.key,
    required this.title,
    this.sizeBar = 80,
  });
  final String title;
  final double sizeBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.foreground.primary.dark,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.typography.title.h1.bold.white,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(sizeBar);
}
