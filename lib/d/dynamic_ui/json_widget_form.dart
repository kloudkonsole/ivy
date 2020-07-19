import 'package:flutter/material.dart';

import './json_widget.dart';

class JSONWidgetForm extends StatelessWidget {
  final List<dynamic> schema;

  JSONWidgetForm({@required this.schema});

  T cast<T>(x) => x is T ? x : null;

  @override
  Widget build(BuildContext ctx) {
    final attr = cast<Map<String, dynamic>>(schema[1]);
    final child = cast<List<dynamic>>(schema[2]);

    return Form(
        key: Key(cast<String>(attr['id'])),
        child: Column(children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: child.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return new JSONWidget(schema: child[index]);
                  }))
        ]));
  }
}
