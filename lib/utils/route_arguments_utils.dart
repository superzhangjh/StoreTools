import 'package:flutter/material.dart';

///获取指定的参数
T? getArgument<T>(BuildContext context, String key) {
  final arguments = ModalRoute.of(context)?.settings.arguments;
  if (arguments is Map<String, dynamic>) {
    return arguments[key];
  }
  return null;
}