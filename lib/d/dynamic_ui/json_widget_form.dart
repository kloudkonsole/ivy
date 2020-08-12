import 'package:flutter/material.dart';

import './json_widget.dart';
import './json_widget_controller.dart';
import './util.dart';

class JSONWidgetForm extends StatefulWidget {
  final List<dynamic> schema;
  final JSONWidgetController controller;

  JSONWidgetForm({@required this.schema, this.controller});

  @override
  _JSONWidgetFormState createState() => _JSONWidgetFormState();
}

class _JSONWidgetFormState extends State<JSONWidgetForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller.formKey = _formKey;
    }
  }

  @override
  Widget build(BuildContext ctx) {
    final attr = Util.cast<Map<String, dynamic>>(widget.schema[1]);
    final child = Util.cast<List<dynamic>>(widget.schema[2]);

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
