import 'package:flutter/material.dart';

import './json_widget.dart';

class JSONWidgetRoot extends StatelessWidget {
  final List<dynamic> schema;

  JSONWidgetRoot({@required this.schema});

  T cast<T>(x) => x is T ? x : null;

  @override
  Widget build(BuildContext ctx) {
    final attr = cast<Map<String, dynamic>>(schema[1]);
    final child = cast<List<dynamic>>(schema[2]);

    return SafeArea(
        child: GestureDetector(
            onTap: () => FocusScope.of(ctx).requestFocus(FocusNode()),
            child: new JSONWidget(schema: child)));
  }
}
