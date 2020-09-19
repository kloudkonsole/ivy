// possible enhancement https://medium.com/enappd/building-a-flutter-datetime-picker-in-just-15-minutes-6a4b13d6a6d1
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
    String hint;
    switch (widget.attr['type']) {
      case 'date':
        hint = 'mm/dd/yyyy';
        break;
      case 'time':
        hint = 'hh:mm:ss';
        break;
      case 'datetime':
        hint = 'mm/dd/yyyy hh:mm:ss';
        break;
    }
    return ValueListenableBuilder<String>(
        valueListenable: notifier,
        builder: (BuildContext context, String value, Widget child) {
          return InputDatePickerFormField(
            key: Key(value),
            fieldLabelText: widget.label + (widget.mandatory ? '*' : ''),
            fieldHintText: hint,
            initialDate: (value == null ? null : DateTime.tryParse(value)),
            firstDate: DateTime.now()
                .subtract(new Duration(days: widget.attr['plus'] ?? 365)),
            lastDate: DateTime.now()
                .add(new Duration(days: widget.attr['minus'] ?? 365)),
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
