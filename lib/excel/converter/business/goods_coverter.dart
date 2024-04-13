import 'package:excel/excel.dart';
import 'package:storetools/excel/converter/xlsx_converter.dart';
import 'package:storetools/excel/rowhelper/row_helper.dart';
import 'package:storetools/excel/utils/cell_value_utils.dart';

import '../../../entity/goods_row_entity.dart';

///商品转化
class GoodsConverter extends XlsxConverter<GoodsRowEntity> {
  @override
  GoodsRowEntity? covert(List<Data?> row, RowHelper helper) {
    var goodsEntity = GoodsRowEntity();
    for (var data in row) {
      if (data == null) continue;
      print("名称：${data}");
      switch (data.sheetName) {
        case '商品ID':
          goodsEntity.thirdPartyId = CellValueUtils.getString(data.value) ?? '';
          break;
        case '商品名称':
          goodsEntity.name = CellValueUtils.getString(data.value) ?? '';
          break;
        case '规格ID（SKUID）':
          goodsEntity.skuId = CellValueUtils.getString(data.value) ?? '';
          break;
        case '商品规格':
          goodsEntity.skuName = CellValueUtils.getString(data.value) ?? '';
          break;
        case '商品价格':
          goodsEntity.skuPrice = CellValueUtils.getDouble(data.value);
          break;
        case '商品链接':
          goodsEntity.skuCoverUrl = CellValueUtils.getString(data.value) ?? '';
          break;
      }
    }
    print("读取到行数据: ${row.toString()}");
    return goodsEntity;
  }

}