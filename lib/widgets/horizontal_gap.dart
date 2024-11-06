import 'package:flutter/material.dart';

class HorizontalGap extends StatelessWidget {
  final double height;

  const HorizontalGap._internal({
    super.key,
    required this.height,
  });

  factory HorizontalGap.formHuge({Key? key}) =>
      HorizontalGap._internal(key: key, height: 32);

  factory HorizontalGap.formBig({Key? key}) =>
      HorizontalGap._internal(key: key, height: 24);

  factory HorizontalGap.formMedium({Key? key}) =>
      HorizontalGap._internal(key: key, height: 16);

  factory HorizontalGap.formSmall({Key? key}) =>
      HorizontalGap._internal(key: key, height: 8);

  factory HorizontalGap.formTiny({Key? key}) =>
      HorizontalGap._internal(key: key, height: 4);

  // 有时候需要将 height 传入
  factory HorizontalGap.custom(double height, {Key? key}) =>
      HorizontalGap._internal(key: key, height: height);

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}