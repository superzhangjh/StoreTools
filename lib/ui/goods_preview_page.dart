import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:storetools/asyncTask/async_owner.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/excel/converter/business/goods_coverter.dart';
import 'package:storetools/excel/excel_kit.dart';
import 'package:storetools/ui/goods/goods_detail_page.dart';
import 'package:storetools/ui/goods/view/goods_item_view.dart';
import 'package:storetools/user/user_kit.dart';
import 'package:storetools/utils/route_arguments_utils.dart';

import '../entity/goods/goods_entity.dart';

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
  AsyncOwner? _excelOwner;
  List<GoodsEntity>? _data;
  late StreamController<int> _streamController;
  
  @override
  void initState() {
    super.initState();
    _streamController = StreamController.broadcast();
  }

  @override
  void initBuildContext(BuildContext context) {
    super.initBuildContext(context);
    decodeExcel(getArgument('filePath'));
  }
  
  void decodeExcel(String? path) async {
    if (path == null) return null;
    _excelOwner?.close();
    _excelOwner = ExcelKit.getInstance().encode(
        path,
        GoodsConverter(),
        (data) async {
          var shopId = await  UserKit.getShopId();
          setState(() {
            _data = GoodsEntity.fromRows(data, shopId) ?? [];
          });
        },
        onProgress: (progress) {
          _streamController.sink.add(progress?.rowIndex ?? 0);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('商品审核')),
      body: _data == null? buildLoading(context): buildList(context)
    );
  }
  
  Widget buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  
  Widget buildList(BuildContext context) {
    return ListView.builder(
        itemCount: _data?.length ?? 0,
        itemBuilder: (context, index) {
          var item = _data![index];
          return ListTile(
            title: GoodsItemView(goodsEntity: item),
            onTap: () async {
              log("商品信息: ${jsonEncode(item)}");
              var result = await showGoodsDetailBottomSheet(context, item);
              log("商品结果: ${jsonEncode(result)}");
            },
          );
        }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _excelOwner?.close();
  }
}