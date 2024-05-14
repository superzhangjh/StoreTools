import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/api/api.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/route/route_arguments.dart';
import 'package:storetools/entity/producer/producer_detail_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/route/route_kit.dart';
import 'package:storetools/route/route_result.dart';
import 'package:storetools/ui/producer/list/producer_list_controller.dart';
import 'package:storetools/utils/log_utils.dart';
import 'package:storetools/utils/toast_utils.dart';

import '../../../route/route_paths.dart';

class ProducerListPage extends BasePage {
  const ProducerListPage({super.key});

  @override
  State<StatefulWidget> createState() => ProducerListState();
}

class ProducerListState extends State<ProducerListPage> {
  static const menuAdd = 'Add';

  late final _controller = Get.put(ProducerListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('货源管理'),
        actions: [
          _buildMenu(context)
        ],
      ),
      body: Obx(() => ListView.builder(
          itemCount: _controller.producers.length,
          itemBuilder: (context, index) => _buildProducer(_controller.producers[index], index)
      )),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) async {
          switch (value) {
            case menuAdd:
              _controller.createProducer();
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
    return Row(
      children: [
        Expanded(
            child: TextButton(
                onPressed: () => _controller.editProducer(index),
                child: Text(producer.name)
            )
        ),
        TextButton(
            onPressed: () => _controller.bindGoods(producer),
            child: const Text('绑定')
        )
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<ProducerListController>();
    super.dispose();
  }
}