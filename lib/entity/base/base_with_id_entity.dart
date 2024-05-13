import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/ext/map_ext.dart';
import 'package:storetools/ext/string_ext.dart';
import 'package:storetools/utils/log_utils.dart';
import 'package:storetools/utils/short_uuid_utils.dart';

///带有唯一id的对象
abstract class BaseWithIdEntity<E extends BaseWithIdEntity<dynamic>> extends BaseEntity<E> {
  String id = '';

  BaseWithIdEntity([String? id]) {
     this.id = id.isNullOrEmpty()? ShortUUidUtils.generateShortId(): (id ?? '');
  }

  @override
  Map<String, dynamic> toJson() {
    var json = { 'id': id };
    fillToJson(json);
    logDebug("${runtimeType.toString()}转json:$json");
    return json;
  }

  ///重写该方法，并且在json中追加数据
  void fillToJson(Map<String, dynamic> json);

  @override
  E fromJson(Map<String, dynamic> json) {
    final entity = createFromJson(json);
    entity.id = json.getString('id') ?? '';
    return entity;
  }

  ///重写该方法，并将json的数据填充的entity中
  E createFromJson(Map<String, dynamic> json);
}