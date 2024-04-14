import 'package:flutter/material.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/entity/goods_entity.dart';
import 'package:storetools/entity/goods_row_entity.dart';
import 'package:storetools/excel/converter/business/goods_coverter.dart';
import 'package:storetools/excel/excel_kit.dart';
import 'package:storetools/utils/route_arguments_utils.dart';
import 'package:storetools/utils/toast_utils.dart';

///商品审核
class GoodsPreviewPage extends BasePage {
  final String filePath = '';

  const GoodsPreviewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return GoodsState();
  }
}

class GoodsState extends BaseState<GoodsPreviewPage> {
  List<GoodsRowEntity>? _goodsList;

  @override
  void initBuildContext(BuildContext context) {
    decodeExcel(getArgument(context, 'filePath'));
  }

  void decodeExcel(String? path) async {
    if (path == null) {
      showToast('文件路径不存在');
      Navigator.pop(context);
      return;
    }
    var goodsRows = await ExcelKit.getInstance().encode(path, GoodsConverter());
    var goodsEntities = GoodsEntity.fromRows(goodsRows);
    if (goodsEntities?.isNotEmpty == true) {
      print("商品信息：${goodsEntities![0].skuGroups.first.name}");
    }
    // print("读取到的个数:${goodsRows?.length}");
    setState(() {
      _goodsList = goodsRows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('商品审核')),
      body: ListView.builder(
          itemCount: _goodsList?.length ?? 0,
          itemBuilder: (context, index) {
            var item = _goodsList?[index];
            // print(json.encoder.convert(item))
            return ListTile(
              title: Text('$index${item?.skuName}'),
              onTap: () async {

              },
            );
          })
    );
  }
}