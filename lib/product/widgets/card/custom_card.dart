import 'package:flutter/material.dart';

import '../../../core/extensions/context_extension.dart';
import '../text/locale_text.dart';

class CustomCard extends StatelessWidget {
  final Widget? widget;
  final String? subTitle;
  final GestureTapCallback? onTap;
  const CustomCard({Key? key, this.widget, this.onTap, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            color: context.theme.primaryColorDark,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: context.paddingHighVerticalAndHorizontal,
              child: widget,
            ),
          ),
          LocaleText(
            text: subTitle ?? "",
            style: context.textTheme.headline4,
          )
        ],
      ),
    );
  }
}
