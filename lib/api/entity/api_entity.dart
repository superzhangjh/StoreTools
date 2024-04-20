import 'package:storetools/entity/base_entity.dart';

abstract class ApiEntity<E extends BaseEntity<dynamic>> implements BaseEntity<E> {
  ///LeanCloud的唯一id
  abstract String? objectId;
  //LeanCloud中的className
  abstract String className;
}