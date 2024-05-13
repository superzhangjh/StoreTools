import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/entity/base/base_entity.dart';

import '../apis.dart';

class ApiUtils {
  ///将LcObject的列表转为指定的类型
  static List<T>? lcObjectsToList<T extends BaseEntity<T>>(List<LCObject>? list, T t) {
    List<T>? result;
    if (list?.isNotEmpty == true) {
      result = <T>[];
      for (var lcObject in list!) {
        var json = t.toJson();
        fillLcObjectToMap(lcObject, json);
        final entity = t.fromJson(json);
        result.add(entity);
      }
    }
    return result;
  }

  ///将lcObject的值填充到map
  ///注意: 只填充map中已有的字段，所有map必须是预设了属性的，一般是从BaseEntity的toJson中获取到的值
  static fillLcObjectToMap(LCObject object, Map<String, dynamic> map) {
    for (var key in map.keys) {
      switch (key) {
        //预设的字段无法用[key]的方式获取, 手动填充
        case Apis.lcFieldObjectId:
          map[key] = object.objectId;
          break;
        default:
          map[key] = object[key];
          break;
      }
    }
  }

  ///将map的值填充到LcObject，无法修改
  static fillMapToLcObject(Map<String, dynamic> map, LCObject object) {
    for (var key in map.keys) {
      //过滤不可修改的字段
      switch (key) {
        case Apis.lcFieldObjectId:
          continue;
        default:
          object[key] = map[key];
          break;
      }
    }
  }
}