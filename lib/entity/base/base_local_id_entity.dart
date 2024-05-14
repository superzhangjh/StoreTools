import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/ext/map_ext.dart';
import 'package:storetools/ext/string_ext.dart';
import 'package:storetools/utils/log_utils.dart';
import 'package:storetools/utils/short_uuid_utils.dart';

///带有本地id的对象
abstract class BaseLocalIdEntity<E extends BaseLocalIdEntity<dynamic>> extends BaseEntity<E> {
  String id = '';

  BaseLocalIdEntity([String? id]) {
     this.id = id.isNullOrEmpty()? ShortUUidUtils.generateShortId(): (id ?? '');
  }

  @override
  Map<String, dynamic> toJson() {
    final json = convertToJson();
    json['id'] = id;
    return json;
  }

  ///重写该方法，并且在json中追加数据
  Map<String, dynamic> convertToJson();

  @override
  E fromJson(Map<String, dynamic> json) {
    final entity = createFromJson(json);
    entity.id = json.getString('id') ?? '';
    return entity;
  }

  ///重写该方法，并将json的数据填充的entity中
  E createFromJson(Map<String, dynamic> json);
}