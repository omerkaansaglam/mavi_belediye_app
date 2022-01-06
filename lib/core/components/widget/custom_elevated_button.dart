//Custom bir button component oluşturuldu. İşlem bitene kadar beklemesi ve birden fazla kez basılması engellendi.

import 'package:flutter/material.dart';

import '../../extensions/context_extension.dart';

//typedef sayesinde constructor short duruma getirildi.
typedef FutureCallBack = Future<void> Function();

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.primaryColor,
    this.data,
    this.style,
  }) : super(key: key);
  final String title;
  final Color? primaryColor;
  final ThemeData? data;
  final FutureCallBack onPressed;
  final TextStyle? style;
  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool _isLoading = false;

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> _completeProcess() async {
    _changeLoading();
    await widget.onPressed();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: widget.primaryColor ?? Colors.white,
          fixedSize: Size(MediaQuery.of(context).size.width * 0.92, 40),
        ),
        onPressed: _isLoading ? null : _completeProcess,
        child: _isLoading
            ? const Center(
                child: SizedBox(height: 30, width: 30, child: CircularProgressIndicator()),
              )
            : Text(
                widget.title,
                style: widget.style ?? context.textTheme.button,
              ));
  }
}
