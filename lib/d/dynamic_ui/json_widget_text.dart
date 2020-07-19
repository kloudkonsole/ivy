import 'package:flutter/material.dart';

class JSONWidgetText extends StatelessWidget {
  final List<dynamic> schema;

  JSONWidgetText({@required this.schema});

  T cast<T>(x) => x is T ? x : null;

  @override
  Widget build(BuildContext ctx) {
    final attr = cast<Map<String, dynamic>>(schema[1]);

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        child: TextFormField(key: Key(cast<String>(attr['id']))));
  }
}
