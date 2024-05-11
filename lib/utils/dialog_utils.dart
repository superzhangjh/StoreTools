import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/text_input_widget.dart';

Future<String?> showInputDialog<T>(
    BuildContext context,
    String title,
    String label,
    ///点击回调: 返回点击后是否关闭
    FutureOr<bool> Function(String text) onConfirm,
  ) {
  var controller = TextEditingController();
  return showDialog<String>(
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
                onPressed: () => Navigator.pop(context),
                child: const Text('取消')
            ),
            TextButton(
                onPressed: () async {
                  var text = controller.text.toString().trim();
                  var pop = await onConfirm(text);
                  if (pop) Get.back();
                },
                child: const Text('确定')
            )
          ],
        );
      }
  );
}

showConfirmDialog(
    String content, {
      String title = '提示',
      String negativeText = '取消',
      String positiveText = '确定',
      bool popWhenNegativeClick = true,
      bool popWhenPositiveClick = true,
      void Function()? onNegativeClick,
      void Function()? onPositiveClick,
    }
) {
  return Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(content),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
              onPressed: () {
                if (popWhenNegativeClick) Get.back();
                if (onNegativeClick != null) onNegativeClick();
              },
              child: Text(negativeText)
          ),
          TextButton(
              onPressed: () {
                if (popWhenPositiveClick) Get.back();
                if (onPositiveClick != null) onPositiveClick();
              },
              child: Text(positiveText)
          )
        ],
      )
  );
}