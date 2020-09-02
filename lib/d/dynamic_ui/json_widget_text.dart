import 'package:flutter/material.dart';
import 'package:ivy/d/dynamic_ui/json_stateful_widget.dart';

import 'package:ivy/d/dynamic_ui/json_widget_controller.dart';

import './util.dart';

class JSONWidgetText extends StatefulWidget
    implements JSONStatefulWidget<String> {
  final List<dynamic> schema;
  final Map<String, dynamic> attr;
  final String id;
  final String label;
  final String type;
  final bool mandatory;
  final JSONWidgetController controller;
  final TextEditingController _ctrl = TextEditingController();

  JSONWidgetText._(
      {@required this.schema, @required this.controller, @required this.attr})
      : id = Util.cast<String>(attr['id'], 'ID'),
        label = Util.cast<String>(attr['lbl'], 'LABEL'),
        type = Util.cast<String>(attr['type'], 'text'),
        mandatory = Util.cast<bool>(attr['required'], false) {
    if (controller != null) {
      controller.addWidget(id, this);
    }
  }

  JSONWidgetText(schema, controller)
      : this._(
            schema: schema,
            controller: controller,
            attr: Util.cast<Map<String, dynamic>>(schema[1]));

  @override
  _JSONWidgetTextState createState() => _JSONWidgetTextState();

  @override
  void setValue(String value) {
    _ctrl.text = value;
  }

  @override
  void clearValue() {
    _ctrl.text = '';
  }
}

class _JSONWidgetTextState extends State<JSONWidgetText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    widget._ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    widget._ctrl.text = widget.controller.readString(widget.id);

    return TextFormField(
      controller: widget._ctrl,
      decoration: InputDecoration(
          labelText: widget.label + (widget.mandatory ? '*' : '')),
      keyboardType:
          Util.str2enum<TextInputType>(TextInputType.values, widget.type),
      textInputAction: TextInputAction.done,
      validator: (String value) {
        if (widget.mandatory && value.isEmpty)
          return '${widget.label} is required';
        return null;
      },
      onSaved: (String value) {
        widget.controller.save(widget.id, value);
        return value;
      },
    );
  }
}
