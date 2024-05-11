import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/ext/map_ext.dart';

class RouteResult<T> extends BaseEntity<RouteResult<T>> {
  ///通用code
  ///成功
  static const resultOk = 1;
  ///失败
  static const resultFail = -1;

  ///自定义code
  ///删除
  static const resultDelete = 2;

  int? code;
  T? data;

  RouteResult({ this.code, this.data });

  @override
  RouteResult<T> fromJson(Map<String, dynamic> json) => RouteResult<T>(
    code: json.getInt('code'),
    data: json.getObject('data')
  );

  @override
  Map<String, dynamic> toJson() => {
    'code': code,
    'data': data
  };
}