import 'package:flutter/material.dart';

class AppTextsTheme extends ThemeExtension<AppTextsTheme> {
  static const _baseFamily = "Roboto";

  final TextStyle labelH1;
  final TextStyle labelH2;
  final TextStyle labelTextDefault;

  const AppTextsTheme._internal({
    required this.labelH1,
    required this.labelH2,
    required this.labelTextDefault,
  });

  factory AppTextsTheme.main() {
    return const AppTextsTheme._internal(
      labelH1: TextStyle(
        fontFamily: _baseFamily,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      labelH2: TextStyle(
        fontFamily: _baseFamily,
        fontSize: 16,
        fontWeight: FontWeight.w300,
        height: 1.4,
      ),
      labelTextDefault: TextStyle(
          fontFamily: _baseFamily, fontSize: 16, fontWeight: FontWeight.w400, height: 1.2),
    );
  }

  @override
  ThemeExtension<AppTextsTheme> copyWith() {
    return AppTextsTheme._internal(
      labelH1: labelH1,
      labelH2: labelH2,
      labelTextDefault: labelTextDefault,
    );
  }

  @override
  ThemeExtension<AppTextsTheme> lerp(covariant ThemeExtension<AppTextsTheme>? other, double t) {
    return this;
  }
}
