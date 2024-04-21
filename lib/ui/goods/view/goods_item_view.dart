import 'package:flutter/material.dart';
import 'package:storetools/entity/goods_entity.dart';

///商品itemView
class GoodsItemView extends StatefulWidget {
  final GoodsEntity? goodsEntity;

  const GoodsItemView({super.key, required this.goodsEntity});

  @override
  State<StatefulWidget> createState() {
    return GoodsItemState();
  }
}

class GoodsItemState extends State<GoodsItemView> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.goodsEntity?.name ?? "");
  }
}