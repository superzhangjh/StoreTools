import 'package:flutter/material.dart';

///获取指定的参数
T? getArgument<T>(BuildContext context, String key) {
  return (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>)[key];
}