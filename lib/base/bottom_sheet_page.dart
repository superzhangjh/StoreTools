import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_page.dart';

Future<T?> bottomSheetPage<T>(BottomSheetPage widget) => Get.bottomSheet(
  widget,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
);

abstract class BottomSheetPage extends BasePage {
  const BottomSheetPage({super.key});

  BottomSheetState createBottomSheetState();

  @override
  State<StatefulWidget> createState() {
    return createBottomSheetState();
  }
}

abstract class BottomSheetState<T extends BasePage> extends BaseState<T> {
   CustomScrollView buildScroll(BuildContext context, ScrollController controller);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: DraggableScrollableSheet(
            initialChildSize: 0.75,
            maxChildSize: 1,
            expand: false,
            builder: (context, controller) {
              return Container(
                  color: Colors.white,
                  child: buildScroll(context, controller)
              );
            },
          ),
        )
    );
  }
}