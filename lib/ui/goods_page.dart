import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/const/routes.dart';
import 'package:storetools/utils/file_pick_utils.dart';

///商品列表
class GoodsPage extends StatefulWidget {
  const GoodsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return GoodsState();
  }
}

class GoodsState extends State<GoodsPage> {
  static const menuAdd = 'Add';
  static const menuExcel = 'AddWithExcel';

  final List<String> items = List.generate(50, (index) => "Item $index");
  String? _filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("商品列表"),
          actions: [
            PopupMenuButton(
                onSelected: (value) async {
                  switch (value) {
                    case menuAdd:
                      Navigator.pushNamed(context, Routes.goodsEdit);
                      break;
                    case menuExcel:
                      var filePath = await pickExcel();
                      _filePath = filePath;
                      if (filePath != null) {
                        print("选择的文件: $filePath");
                        Navigator.pushNamed(context, Routes.goodsPreview, arguments: { 'filePath': filePath });
                      }
                      break;
                    case 'selectPre':
                      if (_filePath != null) {
                        Navigator.pushNamed(context, Routes.goodsPreview, arguments: { 'filePath': _filePath });
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
            )
          ],
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () async {
                  LCObject obj = LCObject('TestObject');
                  obj["words"] = 'Hello world! $index';
                  await obj.save();
                },
              );
            }));
  }
}
