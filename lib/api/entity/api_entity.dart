import 'package:storetools/entity/base/base_entity.dart';

abstract class ApiEntity<E extends BaseEntity<dynamic>> extends BaseEntity<E> {
  ///LeanCloud的唯一id
  abstract String? objectId;
  //LeanCloud中的className
  abstract String className;
}