import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/ext/map_ext.dart';

abstract class ApiEntity<E extends ApiEntity<dynamic>> extends BaseEntity<E> {
  ///LeanCloud的唯一id
  String? objectId;
  //LeanCloud中的className
  String className;

  ApiEntity(this.className);

  @override
  Map<String, dynamic> toJson() {
    final json = convertToJson();
    json['objectId'] = objectId;
    return json;
  }

  ///重写该方法，并且在json中追加数据
  Map<String, dynamic> convertToJson();

  @override
  E fromJson(Map<String, dynamic> json) {
    final entity = createFromJson(json);
    entity.objectId = json.getString('objectId');
    return entity;
  }

  ///重写该方法，并将json的数据填充的entity中
  E createFromJson(Map<String, dynamic> json);
}