import 'package:flutter/material.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../core/extensions/language_extension.dart';
import '../icon/secure_icon.dart';
import 'normal_form_input.dart';

class PasswordInputField extends StatefulWidget {
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool? filled;
  final Color? filledColor;
  final bool? forgotPassoword;
  final TextEditingController? controller;

  const PasswordInputField(
      {Key? key, this.onSaved, this.validator, this.filled, this.filledColor, this.forgotPassoword, this.controller})
      : super(key: key);

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  final String _title = LocaleKeys.login_password.locale;
  bool _isSecureText = false;

  void _changeSecure() {
    setState(() {
      _isSecureText = !_isSecureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NormalInputFormField(
          data: Theme.of(context),
          title: _title,
          isSecure: _isSecureText,
          onSaved: widget.onSaved,
          validator: widget.validator,
          filled: widget.filled ?? false,
          filledColor: widget.filledColor ?? Colors.white,
          controller: widget.controller,
          suffixIcon: IconButton(
              onPressed: () {
                _changeSecure();
              },
              icon: SecureIcon(isSecure: _isSecureText)),
        ),
        widget.forgotPassoword != null
            ? Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      NavigationService.instance.navigateToPage(path: '/forgot-your-password');
                    },
                    child: Text(
                      LocaleKeys.login_password.locale,
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )),
              )
            : Container()
      ],
    );
  }
}
