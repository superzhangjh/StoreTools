import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:storetools/api/api.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/const/arguments.dart';
import 'package:storetools/entity/producer/producer_detail_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/route/route_kit.dart';
import 'package:storetools/route/route_result.dart';
import 'package:storetools/utils/log_utils.dart';
import 'package:storetools/utils/toast_utils.dart';

import '../../route/route_paths.dart';

class ProducerHomePage extends BasePage {
  const ProducerHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProducerHomeState();
  }

}

class ProducerHomeState extends State<ProducerHomePage> {
  static const menuAdd = 'Add';

  List<ProducerDetailEntity>? _producers;

  @override
  void initState() {
    _requestProducers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('货源管理'),
        actions: [
          _buildMenu(context)
        ],
      ),
      body: ListView.builder(
        itemCount: _producers?.length ?? 0,
          itemBuilder: (context, index) => _buildProducer(_producers![index], index)
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) async {
          switch (value) {
            case menuAdd:
              _createProducer();
              break;
          }
        },
        itemBuilder: (context) =>
        [
          const PopupMenuItem(
              value: menuAdd,
              child: Text('新增货源')
          )
        ]
    );
  }

  Widget _buildProducer(ProducerDetailEntity producer, int index) {
    return TextButton(
        onPressed: () async {
          final result = await RouteKit.toProducerEditor(producer: producer);
          switch (result.code) {
            case RouteResult.resultOk:
              setState(() => _producers?.setSafe(index, result.data));
              break;
            case RouteResult.resultDelete:
              setState(() => _producers?.removeAtSafe(index));
              break;
          }
        },
        child: Text(producer.name)
    );
  }

  _requestProducers() async {
    var result = await Api.queryAll(ProducerDetailEntity());
    if (result.isSuccess()) {
      setState(() {
        log(jsonEncode(result.data));
        _producers = result.data;
      });
    } else {
      showToast(result.msg);
    }
  }

  _createProducer() async {
    final result = await RouteKit.toProducerEditor();
    logDebug("跳转结果: ${jsonEncode(result)}");
    if (result.code == RouteResult.resultOk) {
      setState(() {
        _producers ??= [];
        _producers?.addOrIgnore(result.data);
      });
    }
  }
}