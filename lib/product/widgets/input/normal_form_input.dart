import 'package:flutter/material.dart';

class NormalInputFormField extends TextFormField {
  NormalInputFormField(
      {Key? key,
      String? title,
      bool isSecure = false,
      required ThemeData data,
      Widget? suffixIcon,
      String? Function(String?)? validator,
      bool? filled,
      Color? filledColor,
      TextEditingController? controller,
      void Function(String?)? onSaved})
      : super(
          key: key,
          controller: controller,
          validator: validator,
          onSaved: onSaved,
          obscureText: isSecure,
          style: TextStyle(color: Colors.black),
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            fillColor: filledColor ?? data.colorScheme.onBackground,
            filled: filled ?? false,
            labelText: '$title',
            labelStyle: TextStyle(color: Colors.black, fontSize: 13),
            suffixIcon: suffixIcon,
          ),
        );
}
