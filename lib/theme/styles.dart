import 'package:flutter/material.dart';

class StyleUtils {
  static ButtonStyle commonButtonStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevation: WidgetStateProperty.all(0),
    // backgroundColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.disabled)?Colors.red:null),
    minimumSize: WidgetStateProperty.all(const Size(230, 0)),
  );
  static InputBorder commonInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  );
  static InputBorder commonEnabledInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  );
}
