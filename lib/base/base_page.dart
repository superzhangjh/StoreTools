import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BaseState<T extends BasePage> extends State<BasePage> {
  var _isInitializedContext = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      if (_isInitializedContext) return;
      _isInitializedContext = true;
      initBuildContext(context);
    });
    super.initState();
  }

  void initBuildContext(BuildContext context) {}
}