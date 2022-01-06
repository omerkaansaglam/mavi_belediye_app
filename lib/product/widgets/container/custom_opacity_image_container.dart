import 'package:flutter/material.dart';

import '../../../core/extensions/context_extension.dart';

class CustomOpacityImageContainer extends StatelessWidget {
  final String assetName;
  final Widget? child;
  const CustomOpacityImageContainer({Key? key, required this.assetName, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
              fit: BoxFit.cover,
              image: AssetImage(assetName))),
      child: child,
    );
  }
}
