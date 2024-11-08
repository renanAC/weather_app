import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/design_system/colors/color_scheme.dart';
import 'package:weather_app/design_system/dimensions/dimessions_scheme.dart';
import 'package:weather_app/design_system/typography/typography_scheme.dart';

extension BuildContextTokenExtensions on BuildContext {
  TypographyScheme get typography => read<TypographyScheme>();
  DimessionsScheme get dimessions => read<DimessionsScheme>();
  RegularColorScheme get colors => read<RegularColorScheme>();
}

class TokensProvider extends StatelessWidget {
  final Widget child;

  const TokensProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(create: (_) => const TypographyScheme()),
        RepositoryProvider(create: (_) => const DimessionsScheme()),
        RepositoryProvider(
          create: (_) => RegularColorScheme(
              mode: MediaQuery.of(context).platformBrightness),
        ),
      ],
      child: child,
    );
  }
}
