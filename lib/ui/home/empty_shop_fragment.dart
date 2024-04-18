import 'package:flutter/material.dart';
import 'package:storetools/api/api.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/entity/shop_entity.dart';
import 'package:storetools/user/user_kit.dart';
import 'package:storetools/utils/toast_utils.dart';
import 'package:storetools/widget/text_input_widget.dart';

class EmptyShopFragment extends BasePage {
  const EmptyShopFragment({super.key});

  @override
  State<StatefulWidget> createState() {
    return EmptyShopState();
  }
}

class EmptyShopState extends BaseState<EmptyShopFragment> {
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                _inputController.clear();
                _showChooseDialog(
                    '创建店铺',
                    _inputController,
                    '店铺名称',
                    _createShop
                );
              },
              child: const Text("创建店铺")
          ),
          TextButton(
              onPressed: () {
                _inputController.clear();
                _showChooseDialog(
                    '加入店铺',
                    _inputController,
                    '店铺ID', () {
                      showToast("该功能未实现");
                    }
                );
              },
              child: const Text("加入店铺")
          ),
        ],
      ),
    );
  }

  _createShop() async {
    var name = _inputController.text.trim();
    if (name.isEmpty) {
      showToast('店铺名不能为空');
      return;
    }
    var shop = ShopEntity();
    shop.name = name;
    var newShop = await Api.createOrUpdate(shop);
    if (newShop != null && newShop.objectId?.isNotEmpty == true && await UserKit.setShopId(newShop.objectId!)) {
      showToast("创建成功");
      Navigator.pop(context);
    }
  }

  _showChooseDialog(String title, TextEditingController controller, String label, VoidCallback? onConfirm) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: TextInputWidget(
              controller: controller,
              label: label,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('取消')
              ),
              TextButton(
                  onPressed: onConfirm,
                  child: const Text('确定')
              )
            ],
          );
        }
    );
  }
}