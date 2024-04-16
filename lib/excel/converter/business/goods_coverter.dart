import 'package:excel/excel.dart';
import 'package:storetools/excel/converter/xlsx_converter.dart';
import 'package:storetools/excel/rowhelper/row_helper.dart';
import 'package:storetools/excel/utils/cell_value_utils.dart';
import 'package:storetools/ext/list_ext.dart';

import '../../../entity/goods_row_entity.dart';

///商品转化
class GoodsConverter extends XlsxConverter<GoodsRowEntity> {
  @override
  GoodsRowEntity? covert(List<Data?> row, RowHelper? helper) {
    var goodsEntity = GoodsRowEntity();
    goodsEntity.thirdPartyId = CellValueUtils.getString(row.getSafeOfNull(helper?.getIndex('商品ID'))?.value) ?? '';
    goodsEntity.name = CellValueUtils.getString(row.getSafeOfNull(helper?.getIndex('商品名称'))?.value) ?? '';
    goodsEntity.skuId = CellValueUtils.getString(row.getSafeOfNull(helper?.getIndex('规格ID（SKUID）'))?.value) ?? '';
    goodsEntity.skuName = CellValueUtils.getString(row.getSafeOfNull(helper?.getIndex('商品规格'))?.value) ?? '';
    // goodsEntity.skuPrice = CellValueUtils.getDouble(row.getSafeOfNull(helper?.getIndex('商品价格'))?.value);
    goodsEntity.skuCoverUrl = CellValueUtils.getString(row.getSafeOfNull(helper?.getIndex('商品链接'))?.value);
    return goodsEntity;
  }

}