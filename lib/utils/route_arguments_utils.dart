import 'package:get/get.dart';

///获取指定的参数
T? getArgument<T>(String key) {
  final arguments = Get.arguments;
  if (arguments is Map<String, dynamic>) {
    return arguments[key];
  }
  return null;
}