import 'package:flutter/material.dart';

import 'package:ivy/d/dynamic_ui/json_widget_controller.dart';

import './util.dart';

class JSONWidgetText extends StatefulWidget {
  final List<dynamic> schema;
  final JSONWidgetController controller;

  JSONWidgetText({@required this.schema, @required this.controller});

  @override
  _JSONWidgetTextState createState() => _JSONWidgetTextState();
}

class _JSONWidgetTextState extends State<JSONWidgetText> {
  final TextEditingController _ctrl = TextEditingController();
  Map<String, dynamic> attr = {};
  String id = '';
  String label = '';
  String type = '';
  bool mandatory = true;

  @override
  void initState() {
    super.initState();

    attr = Util.cast<Map<String, dynamic>>(widget.schema[1]);
    id = Util.cast<String>(attr['id'], 'ID');
    label = Util.cast<String>(attr['lbl'], 'LABEL');
    type = Util.cast<String>(attr['type'], 'text');
    mandatory = Util.cast<bool>(attr['required'], false);

    if (widget.controller != null) {
      widget.controller.addField(id, _ctrl);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    _ctrl.text = widget.controller.readString(id);

    return TextFormField(
      controller: _ctrl,
      decoration: InputDecoration(labelText: label + (mandatory ? '*' : '')),
      keyboardType: Util.str2enum<TextInputType>(TextInputType.values, type),
      textInputAction: TextInputAction.done,
      validator: (String value) {
        if (mandatory && value.isEmpty) return '$label is required';
        return null;
      },
      onSaved: (String value) {
        widget.controller.save(id, value);
        return value;
      },
    );
  }
}
