import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:storetools/api/api.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/const/arguments.dart';
import 'package:storetools/entity/producer/producer_detail_entity.dart';
import 'package:storetools/utils/toast_utils.dart';

import '../../const/routes.dart';

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
          itemBuilder: (context, index) => _buildProducer(_producers![index])
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) async {
          switch (value) {
            case menuAdd:
              _createProducer(context);
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

  Widget _buildProducer(ProducerDetailEntity producer) {
    return TextButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.producerEditor, arguments: { Arguments.producer: producer });
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

  _createProducer(BuildContext context) async {
    var producer = await Navigator.pushNamed(context, Routes.producerEditor);
    if (producer != null && producer is ProducerDetailEntity) {
      _requestProducers();
    }
  }
}