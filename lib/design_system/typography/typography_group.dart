import 'package:flutter/material.dart';

const _bebasFontFamily = 'Bebas';

class BodyStyleGroup extends TextStyle {
  const BodyStyleGroup() : super(fontFamily: _bebasFontFamily);

  TextStyle get large {
    const mediumFontSize = 20.0;
    return copyWith(
      fontSize: mediumFontSize,
    );
  }

  TextStyle get intermediate {
    const mediumFontSize = 16.0;
    return copyWith(
      fontSize: mediumFontSize,
    );
  }
}

class TitleStyleGroup extends TextStyle {
  const TitleStyleGroup() : super(fontFamily: _bebasFontFamily);

  TextStyle get h1 {
    const largeFontSize = 36.0;
    return copyWith(
      fontSize: largeFontSize,
    );
  }

  TextStyle get h2 {
    const mediumFontSize = 24.0;
    return copyWith(
      fontSize: mediumFontSize,
    );
  }

  TextStyle get h3 {
    const smallFontSize = 18.0;
    return copyWith(
      fontSize: smallFontSize,
    );
  }
}
