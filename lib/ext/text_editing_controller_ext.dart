import 'package:flutter/material.dart';

extension TextEditingControllerExt on TextEditingController {
  ///从输入框上读取double的值，如果不是double值则返回null
  double? doubleValue() {
    try {
      return double.parse(text.trim());
    } catch (e) {
      return null;
    }
  }

  ///获取有效的string值
  String stringValue() {
    return text.trim();
  }
}