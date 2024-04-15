import 'dart:async';

import 'package:flutter/material.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/entity/goods_entity.dart';
import 'package:storetools/excel/converter/business/goods_coverter.dart';
import 'package:storetools/excel/excel_kit.dart';
import 'package:storetools/utils/route_arguments_utils.dart';

///商品审核
class GoodsPreviewPage extends BasePage {
  final String filePath = '';

  const GoodsPreviewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return GoodsState();
  }
}

class GoodsState extends BaseState<GoodsPreviewPage> {
  @override
  void initState() {
    super.initState();
    _streamController = StreamController.broadcast();
  }

  @override
  void initBuildContext(BuildContext context) {
    super.initBuildContext(context);
    decodeExcel(getArgument(context, 'filePath'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('商品审核')),
      // body: FutureBuilder(
      //     future: decodeExcel(getArgument(context, 'filePath')),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         var data = snapshot.data;
      //         return ListView.builder(
      //             itemCount: data?.length ?? 0,
      //             itemBuilder: (context, index) {
      //               var item = data?[index];
      //               return ListTile(
      //                 title: Text('$index${item?.name}'),
      //                 onTap: () async {
      //
      //                 },
      //               );
      //             }
      //         );
      //       }
      //       return StreamBuilder(
      //           stream: _streamController.stream,
      //           builder: (context, snapshot) {
      //             print("当前进度:${snapshot.data}");
      //             return Text("当前进度:${snapshot.data}");
      //           }
      //       );
      //     }
      // )
      body: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            print("当前进度:${snapshot.data}");
            return Text("当前进度:${snapshot.data}");
          }
      )
    );
  }

  late StreamController<int> _streamController;

  void decodeExcel(String? path) async {
    if (path == null) return null;
    var isolate = await ExcelKit.getInstance().encode(
        path,
        GoodsConverter(),
        (data) => {

        },
        onProgress: (progress) {
          _streamController.sink.add(progress?.rowIndex ?? 0);
        }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }
}