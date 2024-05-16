import 'package:storetools/ui/goods_producer_binding/entity/sku_bindable.dart';
import 'package:storetools/ui/goods_producer_binding/entity/sku_spec_bindable.dart';

class SkuCategoryBindable extends SkuBindable {
  String name;
  List<SkuSpecBindable> specs;

  SkuCategoryBindable({required super.isBound, required this.name, required this.specs});
}