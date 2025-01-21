import 'package:flutter/material.dart';
import 'package:personal_portfolio/ultils/text_style_utils.dart';

class TextViewUtils {
  static SelectableText descriptionsRegular({required String text}) {
    return SelectableText(
      text,
      style: TextStyleUtils.regular(12),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.justify,
    );
  }

  static SelectableText titleBold({required String text}) {
    return SelectableText(
      text,
      style: TextStyleUtils.bold(30),
    );
  }
}
