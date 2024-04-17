// import 'package:flutter/material.dart';
// import 'package:storetools/entity/goods_sku_group_entity.dart';
// import 'package:storetools/widget/text_input_widget.dart';
//
// ///sku组编辑
// class SkuGroupEditBottomSheet extends StatefulWidget {
//   final GoodsSkuGroupEntity? skuGroupEntity;
//
//   const SkuGroupEditBottomSheet({super.key, this.skuGroupEntity});
//
//   @override
//   State<StatefulWidget> createState() {
//     return SkuGroupEditState();
//   }
// }
//
// class SkuGroupEditState extends State<SkuGroupEditBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//         builder: (context, constraints) {
//           return SizedBox(
//             height: constraints.minHeight,
//             child: Column(
//               children: [
//                 const TextInputWidget(label: '分组信息'),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text('确定')
//                 )
//               ],
//             ),
//           );
//         }
//     );
//   }
// }