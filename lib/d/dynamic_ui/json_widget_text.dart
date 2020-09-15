import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './json_widget_controller.dart';
import './util.dart';

class JSONWidgetText extends StatefulWidget {
  final List<dynamic> schema;
  final Map<String, dynamic> attr;
  final String id;
  final String label;
  final String type;
  final bool mandatory;

  JSONWidgetText._({@required this.schema, @required this.attr})
      : id = Util.cast<String>(attr['id'], 'ID'),
        label = Util.cast<String>(attr['lbl'], 'LABEL'),
        type = Util.cast<String>(attr['type'], 'text'),
        mandatory = Util.cast<bool>(attr['required'], false);

  JSONWidgetText(schema)
      : this._(
            schema: schema, attr: Util.cast<Map<String, dynamic>>(schema[1]));

  @override
  _JSONWidgetTextState createState() => _JSONWidgetTextState();
}

class _JSONWidgetTextState extends State<JSONWidgetText> {
  ValueNotifier<String> notifier;
  JSONWidgetController ctrl;

  @override
  void initState() {
    super.initState();

    ctrl = Provider.of<JSONWidgetController>(context, listen: false);
    notifier = ctrl.setValue(widget.id, widget.attr['value']);
  }

  @override
  Widget build(BuildContext ctx) {
    return ValueListenableBuilder<String>(
        valueListenable: notifier,
        builder: (BuildContext context, String value, Widget child) {
          return TextFormField(
            key: Key(value),
            initialValue: value,
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
              ctrl.setValue(widget.id, value);
              return value;
            },
          );
        });
  }
}
