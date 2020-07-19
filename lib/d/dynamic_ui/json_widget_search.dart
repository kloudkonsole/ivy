import 'package:flutter/material.dart';

import './json_widget.dart';

class JSONWidgetSearch extends StatelessWidget {
  final List<dynamic> schema;

  JSONWidgetSearch({@required this.schema});

  T cast<T>(x) => x is T ? x : null;

  @override
  Widget build(BuildContext ctx) {
    final attr = cast<Map<String, dynamic>>(schema[1]);
    final child = cast<List<dynamic>>(schema[2]);

    return new JSONWidget(schema: child);
  }
}
