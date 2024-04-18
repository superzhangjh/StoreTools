import 'dart:developer';

import 'package:leancloud_storage/leancloud.dart';

///用户信息
class UserKit {
  static Future<bool> isLoggedIn() async {
    return (await LCUser.getCurrent()) != null;
  }

  static Future<String?> getShopId() async {
    return (await LCUser.getCurrent())?['shopId']?.toString();
  }

  static Future<bool> setShopId(String shopId) async {
    var user = await LCUser.getCurrent();
    if (user != null) {
      user['shopId'] = shopId;
    }
    try {
      await user?.save();
      return true;
    } on Exception catch (e) {
      log(e.toString());
    }
    return false;
  }
}