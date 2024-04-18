import 'package:flutter/cupertino.dart';

class OnceFutureBuilder<T> extends StatefulWidget {
  final Future<T>? future;
  final T? initialData;
  final AsyncWidgetBuilder<T> builder;

  const OnceFutureBuilder({
    super.key,
    required this.future,
    this.initialData,
    required this.builder,
  });

  @override
  State<StatefulWidget> createState() {
    return OnceFutureState<T>();
  }
}

class OnceFutureState<T> extends State<OnceFutureBuilder<T>> {
  var hasLoaded = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: hasLoaded? null: widget.future?.then<T>((value) {
          hasLoaded = true;
          return value;
        }),
        initialData: widget.initialData,
        builder: widget.builder
    );
  }
}