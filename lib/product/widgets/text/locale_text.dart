import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/language_extension.dart';

class LocaleText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const LocaleText({Key? key, required this.text, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text.locale,
      textAlign: TextAlign.center,
      style: style,
    );
  }
}
