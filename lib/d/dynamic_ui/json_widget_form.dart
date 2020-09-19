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
  @override
  Widget build(BuildContext ctx) {
    final child = Util.cast<List<dynamic>>(widget.schema[2]);

    return Form(
        key: widget.controller.formKey,
        child: Column(children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: child.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return JSONWidget(
                        schema: child[index], controller: widget.controller);
                  }))
        ]));
  }
}
