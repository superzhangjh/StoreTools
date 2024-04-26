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
                  if (pop) Navigator.pop(context);
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
      FutureOr<bool> Function()? onNegativeClick,
      FutureOr<bool> Function()? onPositiveClick,
    }
) {
  onPressed(FutureOr<bool> Function()? onClick) async {
    var pop = true;
    if (onClick != null) pop = await onClick();
    if (pop) Get.back();
  }
  return Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(content),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
              onPressed: () => onPressed(onNegativeClick),
              child: Text(negativeText)
          ),
          TextButton(
              onPressed: () => onPressed(onPositiveClick),
              child: Text(positiveText)
          )
        ],
      )
  );
}