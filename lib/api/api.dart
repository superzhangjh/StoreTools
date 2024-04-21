import 'dart:developer';

import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/api/entity/api_result.dart';
import 'package:storetools/api/util/api_utils.dart';
import 'package:storetools/const/apis.dart';

class Api {
  ///创建或更新数据模型
  static Future<ApiResult<T?>> createOrUpdate<T extends ApiEntity<T>>(T entity) async {
    var objectId = entity.objectId;
    LCObject lcObject;
    if (objectId?.isNotEmpty == true) {
      lcObject = LCObject.createWithoutData(entity.className, objectId!);
    } else {
      lcObject = LCObject(entity.className);
    }
    var entityMap = entity.toJson();
    ApiUtils.fillMapToLcObject(entityMap, lcObject);
    try {
      ///以服务器返回的值为准，将结果返回出去
      var newLcObject = await lcObject.save();
      ApiUtils.fillLcObjectToMap(newLcObject, entityMap);
      return Future(() => ApiResult.success(entity.fromJson(entityMap)));
    } on LCException catch (e) {
      log(e.message ?? '未知错误');
      return Future(() => ApiResult.error(e.message));
    }
  }

  ///根据条件查询
  static Future<ApiResult<List<T>?>> whereEqualTo<T extends ApiEntity<T>>(T t, String key, dynamic value) async {
    try {
      var list = await LCQuery(t.className).whereEqualTo(key, value).find();
      List<T>? result = ApiUtils.lcObjectsToList(list, t);
      return Future(() => ApiResult.success(result));
    } on LCException catch (e) {
      log(e.message ?? '未知错误');
      return Future(() => ApiResult.error(e.message));
    }
  }

  ///查询全部
  static Future<ApiResult<List<T>?>> queryAll<T extends ApiEntity<T>>(T t) async {
    try {
      var list = await LCQuery(t.className).find();
      List<T>? result = ApiUtils.lcObjectsToList(list, t);
      return Future(() => ApiResult.success(result));
    } on LCException catch (e) {
      log(e.message ?? '未知错误');
      return Future(() => ApiResult.error(e.message));
    }
  }
}