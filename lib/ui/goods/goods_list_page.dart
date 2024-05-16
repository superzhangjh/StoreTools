import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/api/api.dart';
import 'package:storetools/api/apis.dart';
import 'package:storetools/route/route_kit.dart';
import 'package:storetools/route/route_paths.dart';
import 'package:storetools/entity/goods/goods_entity.dart';
import 'package:storetools/ui/goods/view/goods_item_view.dart';
import 'package:storetools/user/user_kit.dart';
import 'package:storetools/utils/file_pick_utils.dart';
import 'package:storetools/utils/toast_utils.dart';

import '../../base/base_page.dart';
import 'goods_list_controller.dart';

///商品列表
class GoodsListPage extends BasePage {
  const GoodsListPage({super.key});

  @override
  State<StatefulWidget> createState() => GoodsListState();
}

class GoodsListState extends BaseState<GoodsListPage> {
  static const menuAdd = 'Add';
  static const menuExcel = 'AddWithExcel';

  late final _controller = Get.put(GoodsListController());
  String? _filePath;

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

  Widget _buildGoodsList(BuildContext context) => Obx(() => ListView.builder(
      itemCount: _controller.goodsEntities.length,
      itemBuilder: (context, index) {
        final goodsEntity = _controller.goodsEntities[index];
        return ListTile(
          title: Row(
            children: [
              Expanded(
                  child: GoodsItemView(goodsEntity: goodsEntity)
              ),
              TextButton(
                  onPressed: () {
                    if (goodsEntity.producerBindingIds.isEmpty) {
                      _controller.toBindProducer(goodsEntity);
                    } else {
                    }
                  },
                  child: Text(goodsEntity.producerBindingIds.isEmpty? '绑定货源': '代发订单')
              )
            ],
          ),
          onTap: () async {

          },
        );
      })
  );

  @override
  void dispose() {
    Get.delete<GoodsListController>();
    super.dispose();
  }
}
