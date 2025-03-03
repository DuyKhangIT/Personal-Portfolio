import 'package:flutter/material.dart';
import 'package:personal_portfolio/ultils/text_style_utils.dart';

class TextViewUtils {
  static SelectableText descriptionsRegular({required String text}) {
    return SelectableText(
      text,
      style: TextStyleUtils.regular(16),
      textDirection: TextDirection.ltr,
    );
  }

  static Text titleBold({required String text, double? fontSize}) {
    return Text(
      text,
      style: TextStyleUtils.bold(fontSize ?? 50),
      textScaler: TextScaler.noScaling,
    );
  }

  static SelectableText selectTitleBold(
      {required String text, double? fontSize}) {
    return SelectableText(
      text,
      style: TextStyleUtils.bold(fontSize ?? 50),
      textScaler: TextScaler.noScaling,
    );
  }
}
