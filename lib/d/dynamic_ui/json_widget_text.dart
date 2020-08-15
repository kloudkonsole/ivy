import 'package:flutter/material.dart';

import 'package:ivy/d/dynamic_ui/json_widget_controller.dart';

import './util.dart';

class JSONWidgetText extends StatelessWidget {
  final List<dynamic> schema;
  final JSONWidgetController controller;

  JSONWidgetText({@required this.schema, @required this.controller});

  @override
  Widget build(BuildContext ctx) {
    final attr = Util.cast<Map<String, dynamic>>(schema[1]);
    final label = Util.cast<String>(attr['lbl'], 'LABEL');
    final type = Util.cast<String>(attr['type'], 'text');
    final mandatory = Util.cast<bool>(attr['required'], false);

    return TextFormField(
      decoration: InputDecoration(labelText: label + (mandatory ? '*' : '')),
      keyboardType: Util.str2enum<TextInputType>(TextInputType.values, type),
      textInputAction: TextInputAction.done,
      validator: (String value) {
        if (mandatory && value.isEmpty) return '$label is required';
        return null;
      },
      onSaved: (String value) {
        controller.save(attr['id'], value);
        return value;
      },
    );
  }
}
