import 'package:flutter/material.dart';
import '../../../core/extensions/context_extension.dart';

class CustomCoverImageContainer extends StatelessWidget {
  final String assetName;
  final Widget? child;
  const CustomCoverImageContainer({Key? key, required this.assetName, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height / 3,
      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage(assetName))),
      child: child,
    );
  }
}
