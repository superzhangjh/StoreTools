import 'dart:developer';

import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/api/api_entity.dart';
import 'package:storetools/const/apis.dart';

class Api {
  ///创建或更新数据模型
  static Future<T?> createOrUpdate<T extends ApiEntity<T>>(T entity) async {
    var objectId = entity.objectId;
    LCObject lcObject;
    if (objectId?.isNotEmpty == true) {
      lcObject = LCObject.createWithoutData(entity.className, objectId!);
    } else {
      lcObject = LCObject(entity.className);
    }
    var entityMap = entity.toJson();
    for (var key in entityMap.keys) {
      //过滤不可修改的字段
      switch (key) {
        case Apis.lcFieldObjectId:
          continue;
        default:
          lcObject[key] = entityMap[key];
          break;
      }
    }
    try {
      var newLcObject = await lcObject.save();
      for (var key in entityMap.keys) {
        switch (key) {
          //预设的字段无法用[key]的方式获取
          case Apis.lcFieldObjectId:
            entityMap[key] = newLcObject.objectId;
            break;
          default:
            entityMap[key] = newLcObject[key];
            break;
        }
      }
      return Future(() => entity.fromJson(entityMap));
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  ///根据条件查询
  static Future<List<T>?> whereEqualTo<T extends ApiEntity<T>>(T t, String key, dynamic value) async {
    var list = await LCQuery(t.className).whereEqualTo(key, value).find();
    if (list?.isNotEmpty == true) {
      var result = <T>[];
      for (var lcObject in list!) {
        var json = <String, dynamic>{};
        for (var key in t.toJson().keys) {
          switch (key) {
          //预设的字段无法用[key]的方式获取
            case Apis.lcFieldObjectId:
              json[key] = lcObject.objectId;
              break;
            default:
              json[key] = lcObject[key];
              break;
          }
        }
        result.add(t.fromJson(json));
      }
      return result;
    }
    return Future(() => null);
  }
}