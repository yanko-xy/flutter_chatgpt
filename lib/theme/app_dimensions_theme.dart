import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/theme/flutter_view_extension.dart';

class AppDimensionsTheme extends ThemeExtension<AppDimensionsTheme> {
  final double rediusCommitButton;
  final EdgeInsets paddingOrderList;

  const AppDimensionsTheme._internal({
    required this.paddingOrderList,
    required this.rediusCommitButton,
  });

  factory AppDimensionsTheme.main(FlutterView flutterView) {
    return AppDimensionsTheme._internal(
      paddingOrderList: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      rediusCommitButton: flutterView.isSmallSmartphone ? 8 : 16,
    );
  }

  @override
  ThemeExtension<AppDimensionsTheme> copyWith() {
    return AppDimensionsTheme._internal(
      paddingOrderList: paddingOrderList,
      rediusCommitButton: rediusCommitButton,
    );
  }

  @override
  ThemeExtension<AppDimensionsTheme> lerp(
      covariant ThemeExtension<AppDimensionsTheme>? other, double t) {
    return this;
  }
}
