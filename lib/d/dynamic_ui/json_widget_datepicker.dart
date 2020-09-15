import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './json_widget_controller.dart';
import './util.dart';

class JSONWidgetDatePicker extends StatefulWidget {
  final List<dynamic> schema;
  final Map<String, dynamic> attr;
  final String id;
  final String label;
  final bool mandatory;

  JSONWidgetDatePicker._({@required this.schema, @required this.attr})
      : id = Util.cast<String>(attr['id'], 'ID'),
        label = Util.cast<String>(attr['lbl'], 'LABEL'),
        mandatory = Util.cast<bool>(attr['required'], false);

  JSONWidgetDatePicker(schema)
      : this._(
            schema: schema, attr: Util.cast<Map<String, dynamic>>(schema[1]));

  @override
  _JSONWidgetDatePickerState createState() => _JSONWidgetDatePickerState();
}

class _JSONWidgetDatePickerState extends State<JSONWidgetDatePicker> {
  ValueNotifier<String> notifier;
  JSONWidgetController ctrl;

  @override
  void initState() {
    super.initState();

    ctrl = Provider.of<JSONWidgetController>(context, listen: false);
    notifier = ctrl.setValue<String>(widget.id, widget.attr['value']);
  }

  @override
  Widget build(BuildContext ctx) {
    return ValueListenableBuilder<String>(
        valueListenable: notifier,
        builder: (BuildContext context, String value, Widget child) {
          return InputDatePickerFormField(
            key: Key(value),
            fieldLabelText: widget.label + (widget.mandatory ? '*' : ''),
            initialDate: DateTime.tryParse(value),
            firstDate: DateTime.parse(widget.attr['gt'] ?? '1975-11-15'),
            lastDate: DateTime(2054),
            onDateSubmitted: (value) {
              ctrl.setValue<String>(widget.id, value.toIso8601String());
            },
            onDateSaved: (DateTime value) {
              ctrl.setValue<String>(widget.id, value.toIso8601String());
              return value;
            },
            selectableDayPredicate: (DateTime value) {
              return true;
            },
          );
        });
  }
}
