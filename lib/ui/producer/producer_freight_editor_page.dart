import 'package:flutter/material.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/entity/freight_entity.dart';
import 'package:storetools/entity/province_entity.dart';
import 'package:storetools/widget/text_input_widget.dart';

Future<FreightEntity?> showFreightEditor(
    BuildContext context,
    List<ProvinceEntity> enableProvinces,
    { FreightEntity? freightEntity }
) => showModalBottomSheet<FreightEntity>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    builder: (context) {
      return ProducerFreightEditorPage(freight: freightEntity ?? FreightEntity(), enableProvinces: enableProvinces);
    }
);

class ProducerFreightEditorPage extends BasePage {
  final FreightEntity freight;
  final List<ProvinceEntity> enableProvinces;

  const ProducerFreightEditorPage({super.key, required this.freight, required this.enableProvinces});

  @override
  State<StatefulWidget> createState() {
    return ProducerFreightEditorState();
  }
}

class ProducerFreightEditorState extends BaseState<ProducerFreightEditorPage> {
  late final _nameInputController = TextEditingController(text: widget.freight.name);
  late final _priceInputController = TextEditingController(text: widget.freight.price.toString());
  var provinceWrappers = <ProvinceWrapper>[];

  @override
  void initState() {
    _initProvinceWrappers();
    super.initState();
  }

  _initProvinceWrappers() {
    for (var value in widget.enableProvinces) {
      provinceWrappers.add(
        ProvinceWrapper(selected: false, provinceEntity: value)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 1,
        expand: false,
        builder: (context, controller) {
          return Container(
            color: Colors.white,
            child: CustomScrollView(
              controller: controller,
              slivers: [
                SliverAppBar(
                  title: const Text('阶梯运费'),
                  floating: true,
                  pinned: true,
                  actions: [
                    TextButton(
                        onPressed: _save,
                        child: const Text('保存')
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: TextInputWidget(
                      controller: _nameInputController,
                      label: '名称(选填)'
                  ),
                ),
                SliverToBoxAdapter(
                  child: TextInputWidget(
                      controller: _priceInputController,
                      keyboardType: TextInputType.number,
                      label: '价格'
                  ),
                ),
                SliverToBoxAdapter(
                  child: Wrap(
                    children: [
                      ...provinceWrappers.map(_buildProvince)
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProvince(ProvinceWrapper provinceWrapper) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: TextButton(
        onPressed: () => setState(() {
          provinceWrapper.selected = !provinceWrapper.selected;
        }),
        style: TextButton.styleFrom(
          backgroundColor: provinceWrapper.selected? Colors.amber: Colors.transparent,
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          textStyle: TextStyle(
            color: provinceWrapper.selected? Colors.white: Colors.black54,
          )
        ),
        child: Text(provinceWrapper.provinceEntity.name),
      ),
    );
  }

  _save() {
    var name = _nameInputController.text.trim();
    if (name.isEmpty) name = '默认运费${DateTime.now().millisecondsSinceEpoch}';
    var freight = FreightEntity();
    freight.name = name;
    freight.price = double.parse(_priceInputController.text.trim());
    freight.provinces = provinceWrappers.map((e) => e.provinceEntity).toList();
    Navigator.pop(context, freight);
  }
}

class ProvinceWrapper {
  bool selected;
  ProvinceEntity provinceEntity;

  ProvinceWrapper({ required this.selected, required this.provinceEntity });
}