import 'dart:convert';
import 'dart:developer';

import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/api/entity/api_result.dart';
import 'package:storetools/api/util/api_utils.dart';
import 'package:storetools/utils/log_utils.dart';

class Api {
  Api._();

  ///创建或更新数据模型
  static Future<ApiResult<T?>> createOrUpdate<T extends ApiEntity<T>>(T entity) async {
    final objectId = entity.objectId;
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
      _logRequest("createOrUpdate", entity.className, newLcObject.toString());
      ApiUtils.fillLcObjectToMap(newLcObject, entityMap);
      return Future(() => ApiResult.success(entity.fromJson(entityMap)));
    } on LCException catch (e) {
      log(e.message ?? '未知错误');
      return Future(() => ApiResult.error(e.message));
    }
  }

  ///删除数据模型
  static Future<ApiResult<T?>> delete<T extends ApiEntity<T>>(T entity) async {
    final objectId = entity.objectId;
    LCObject lcObject;
    if (objectId?.isNotEmpty == true) {
      lcObject = LCObject.createWithoutData(entity.className, objectId!);
    } else {
      return Future(() => ApiResult.error("objectId不存在"));
    }
    try {
      ///以服务器返回的值为准，将结果返回出去
      var newLcObject = await lcObject.delete();
      _logRequest("delete", entity.className, newLcObject.toString());
      return Future(() => ApiResult.success(entity));
    } on LCException catch (e) {
      log(e.message ?? '未知错误');
      return Future(() => ApiResult.error(e.message));
    }
  }

  ///根据条件查询
  static Future<ApiResult<List<T>?>> whereEqualTo<T extends ApiEntity<T>>(T t, String key, dynamic value) async {
    try {
      final list = await _ofLCQuery<T>(t).whereEqualTo(key, value).find();
      _logRequest("whereEqualTo::$key=$value", t.className, list?.toString());
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
      final list = await _ofLCQuery<T>(t).find();
      _logRequest("queryAll", t.className, list?.toString());
      List<T>? result = ApiUtils.lcObjectsToList(list, t);
      return Future(() => ApiResult.success(result));
    } on LCException catch (e) {
      log(e.message ?? '未知错误');
      return Future(() => ApiResult.error(e.message));
    }
  }

  ///生成查询类
  static LCQuery _ofLCQuery<T extends ApiEntity<T>>(T t) {
    final query = LCQuery(t.className);
    if (t.queryPart) {
      t.getQueryPartKeys()?.forEach((element) {
        query.select(element);
      });
    }
    return query;
  }

  static _logRequest(String method, String className, String? result) {
    logDebug("请求信息 >>> $className $method\n请求结果 >>> $result");
  }
}