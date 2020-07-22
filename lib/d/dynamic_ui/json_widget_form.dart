import 'package:flutter/material.dart';

import './json_widget.dart';
import './util.dart';

class JSONWidgetForm extends StatelessWidget {
  final List<dynamic> schema;

  JSONWidgetForm({@required this.schema});

  @override
  Widget build(BuildContext ctx) {
    final attr = Util.cast<Map<String, dynamic>>(schema[1]);
    final child = Util.cast<List<dynamic>>(schema[2]);

    return Form(
        key: Key(Util.cast<String>(attr['id'])),
        child: Column(children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: child.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return JSONWidget(schema: child[index]);
                  }))
        ]));
  }
}
