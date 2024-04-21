import 'dart:async';

import 'package:flutter/material.dart';
import 'package:storetools/api/api.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/entity/shop_entity.dart';
import 'package:storetools/user/user_kit.dart';
import 'package:storetools/utils/dialog_utils.dart';
import 'package:storetools/utils/toast_utils.dart';

class EmptyShopFragment extends BasePage {
  final ValueChanged<String?> onShopChanged;

  const EmptyShopFragment({super.key, required this.onShopChanged});

  @override
  State<StatefulWidget> createState() {
    return EmptyShopState();
  }
}

class EmptyShopState extends BaseState<EmptyShopFragment> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
              onPressed: () async {
                var shopId = await showInputDialog(context, '创建店铺', '店铺名称', _createShop);
                widget.onShopChanged(shopId);
              },
              child: const Text("创建店铺")
          ),
          TextButton(
              onPressed: () {
                // _inputController = TextEditingController();
                // _showChooseDialog(
                //     '加入店铺',
                //     _inputController!,
                //     '店铺ID', () {
                //       showToast("该功能未实现");
                //     }
                // );
              },
              child: const Text("加入店铺")
          ),
        ],
      ),
    );
  }

  FutureOr<bool> _createShop(String name) async {
    if (name.isEmpty) {
      showToast('店铺名不能为空');
      return false;
    }
    var shop = ShopEntity();
    shop.name = name;
    var result = await Api.createOrUpdate(shop);
    if (result.isSuccess()) {
      var newShop = result.data;
      if (newShop != null && newShop.objectId?.isNotEmpty == true && await UserKit.setShopId(newShop.objectId!)) {
        showToast("创建成功");
        Navigator.pop(context, newShop.objectId);
        return true;
      }
    } else {
      showToast(result.msg);
    }
    return false;
  }
}