import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/entity/goods_entity.dart';
import 'package:storetools/utils/toast_utils.dart';

import '../../base/base_page.dart';

///显示商品详情
void showGoodsDetailBottomSheet(BuildContext context, GoodsEntity goodsEntity) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) {
        return GoodsDetailPage(goodsEntity: goodsEntity);
      }
  );
}

///商品详情
class GoodsDetailPage extends BasePage {
  final GoodsEntity goodsEntity;

  const GoodsDetailPage({super.key, required this.goodsEntity});

  @override
  State<StatefulWidget> createState() {
    return GoodsDetailState();
  }
}

class GoodsDetailState extends BaseState<GoodsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 1,
        expand: false,
        builder: (context, controller) {
          return Container(
            color: Colors.white,
            child: CustomScrollView(
              controller: controller,
              slivers: [
                SliverAppBar(
                  title: Text(widget.goodsEntity.name),
                  floating: true,
                  pinned: true,
                  actions: [
                    TextButton(
                        onPressed: _saveGoods,
                        child: const Text('保存')
                    )
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(
                        height: 200,
                        child: Text("一个"),
                      ),
                      const SizedBox(
                        height: 200,
                        child: Text("一个"),
                      ),
                      const SizedBox(
                        height: 200,
                        child: Text("一个"),
                      ),
                      const SizedBox(
                        height: 200,
                        child: Text("一个"),
                      ),
                      const SizedBox(
                        height: 200,
                        child: Text("一个"),
                      ),
                      const SizedBox(
                        height: 200,
                        child: Text("一个"),
                      )
                    ]),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Text("我是你爹"),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _saveGoods() async {
    var goods = LCObject('Goods');
    var goodsEntity = widget.goodsEntity;
    goods['name'] = goodsEntity.name;
    goods['thirdPartyId'] = goodsEntity.thirdPartyId;
    goods['coverUrl'] = goodsEntity.coverUrl;
    goods['skuGroups'] = goodsEntity.skuGroups;
    await goods.save();
    showToast("保存成功");
    Navigator.pop(context);
  }
}