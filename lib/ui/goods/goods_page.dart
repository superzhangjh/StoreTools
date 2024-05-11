import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/api/api.dart';
import 'package:storetools/api/apis.dart';
import 'package:storetools/route/route_kit.dart';
import 'package:storetools/route/route_paths.dart';
import 'package:storetools/entity/goods_entity.dart';
import 'package:storetools/ui/goods/view/goods_item_view.dart';
import 'package:storetools/user/user_kit.dart';
import 'package:storetools/utils/file_pick_utils.dart';
import 'package:storetools/utils/toast_utils.dart';

import '../../base/base_page.dart';

///商品列表
class GoodsPage extends BasePage {
  const GoodsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return GoodsState();
  }
}

class GoodsState extends BaseState<GoodsPage> {
  static const menuAdd = 'Add';
  static const menuExcel = 'AddWithExcel';

  String? _filePath;
  List<GoodsEntity>? _goodsEntities;

  @override
  void initBuildContext(BuildContext context) {
    super.initBuildContext(context);
    _getGoodsList();
  }

  _getGoodsList() async {
    var shopId = await UserKit.getShopId();
    var result = await Api.whereEqualTo(GoodsEntity(), Apis.lcFieldShopId, shopId);
    showToast(result.msg);
    setState(() {
      _goodsEntities = result.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("商品列表"),
          actions: [
            _buildMenu(context)
          ],
        ),
        body: _buildGoodsList(context)
    );
  }

  Widget _buildMenu(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) async {
          switch (value) {
            case menuAdd:
              Navigator.pushNamed(context, RoutePaths.goodsEdit);
              break;
            case menuExcel:
              var filePath = await pickExcel();
              _filePath = filePath;
              if (filePath != null) {
                print("选择的文件: $filePath");
                Navigator.pushNamed(context, RoutePaths.goodsPreview, arguments: { 'filePath': filePath });
              }
              break;
            case 'selectPre':
              if (_filePath != null) {
                Navigator.pushNamed(context, RoutePaths.goodsPreview, arguments: { 'filePath': _filePath });
              }
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
              value: menuAdd,
              child: Text('新增')
          ),
          const PopupMenuItem(
              value: menuExcel,
              child: Text('导入商品表格')
          ),
          const PopupMenuItem(
              value: 'selectPre',
              child: Text('固定地址')
          ),
        ]
    );
  }

  Widget _buildGoodsList(BuildContext context) {
    return ListView.builder(
        itemCount: _goodsEntities?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                GoodsItemView(goodsEntity: _goodsEntities?[index]),
                TextButton(
                    onPressed: () {

                    },
                    child: const Text("新增代发订单")
                )
              ],
            ),
            onTap: () async {

            },
          );
        });
  }
}
