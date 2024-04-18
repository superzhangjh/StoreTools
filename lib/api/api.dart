import 'dart:developer';

import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/api/api_entity.dart';

class Api {
  ///创建或更新数据模型
  static Future<T?> createOrUpdate<T extends ApiEntity<T>>(T entity) async {
    var objectId = entity.objectId;
    LCObject lcObject;
    if (objectId?.isNotEmpty == true) {
      lcObject = LCObject(entity.className);
    } else {
      lcObject = LCObject.createWithoutData(entity.className, objectId!);
    }
    var entityMap = entity.toJson();
    for (var key in entityMap.keys) {
      lcObject[key] = entityMap[key];
    }
    try {
      var newLcObject = await lcObject.save();
      for (var key in entityMap.keys) {
        entityMap[key] = newLcObject[key];
      }
      return Future(() => entity.fromJson(entityMap));
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }
}