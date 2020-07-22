import 'package:flutter/material.dart';

import './json_widget.dart';

class JSONWidgetCard extends StatelessWidget {
  final List<dynamic> schema;

  JSONWidgetCard({@required this.schema});

  T cast<T>(x) => x is T ? x : null;

  @override
  Widget build(BuildContext ctx) {
    final attr = cast<Map<String, dynamic>>(schema[1]);
    final child = cast<List<dynamic>>(schema[2]);

    return JSONWidget(schema: child);
  }
}
