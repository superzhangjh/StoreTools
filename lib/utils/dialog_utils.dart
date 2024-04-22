import 'dart:async';

import 'package:flutter/material.dart';

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
  ).then((value) {
    try {
      controller.dispose();
    } on Exception catch(e) {}
    return Future.value(value);
  });
}