import 'package:flutter/material.dart';

class SecureIcon extends Icon {
  const SecureIcon({required bool isSecure})
      : super(isSecure ? Icons.visibility_off : Icons.visibility, color: Colors.black);
}
