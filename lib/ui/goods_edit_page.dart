import 'package:flutter/material.dart';
import 'package:storetools/ui/sku_group_edit_bottom_sheet.dart';
import 'package:storetools/widget/text_input_widget.dart';

///商品编辑
class GoodsEditPage extends StatefulWidget {
  const GoodsEditPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return GoodsEditState();
  }

}

class GoodsEditState extends State<GoodsEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新增商品'),
      ),
      body: Center(
        child: Column(
          children: [
            // const TextInputWidget(label: '名称'),
            // TextButton(
            //   child: const Text("新增SKU组"),
            //   onPressed: () => {
            //       showModalBottomSheet(
            //           context: context,
            //           builder: (context) {
            //             return SkuGroupEditBottomSheet();
            //           }
            //       )
            //   },
            // )
          ],
        ),
      ),
    );
  }

}