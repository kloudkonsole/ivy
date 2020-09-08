import 'package:flutter/material.dart';

import 'package:ivy/d/dynamic_ui/json_stateful_widget.dart';
import 'package:ivy/d/dynamic_ui/json_widget_controller.dart';

import './util.dart';

class JSONWidgetDatePicker extends StatefulWidget
    implements JSONStatefulWidget<String> {
  final List<dynamic> schema;
  final Map<String, dynamic> attr;
  final String id;
  final String label;
  final bool mandatory;
  final JSONWidgetController controller;
  final _valueNotifier = ValueNotifier<DateTime>(null);

  JSONWidgetDatePicker._(
      {@required this.schema, @required this.controller, @required this.attr})
      : id = Util.cast<String>(attr['id'], 'ID'),
        label = Util.cast<String>(attr['lbl'], 'LABEL'),
        mandatory = Util.cast<bool>(attr['required'], false) {
    if (controller != null) {
      controller.addWidget(id, this);
    }
  }

  JSONWidgetDatePicker(schema, controller)
      : this._(
            schema: schema,
            controller: controller,
            attr: Util.cast<Map<String, dynamic>>(schema[1]));

  @override
  _JSONWidgetDatePickerState createState() => _JSONWidgetDatePickerState();

  @override
  void setValue(String json) {
    _valueNotifier.value = DateTime.parse(json);
  }

  @override
  void clearValue() {
    _valueNotifier.value = null;
  }
}

class _JSONWidgetDatePickerState extends State<JSONWidgetDatePicker> {
  DateTime _selection;

  @override
  void initState() {
    super.initState();

    final def = widget.attr['def'];
    if (def != null) {
      if ('NOW' == def)
        _selection = DateTime.now();
      else
        _selection = DateTime.parse(def);
    }

    widget._valueNotifier.addListener(() {
      setState(() {
        _selection = widget._valueNotifier.value;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return InputDatePickerFormField(
      key: GlobalKey(),
      fieldLabelText: widget.label + (widget.mandatory ? '*' : ''),
      initialDate: _selection,
      firstDate: DateTime.parse(widget.attr['gt'] ?? '1975-11-15'),
      lastDate: DateTime(2054),
      onDateSubmitted: (value) {
        setState(() {
          _selection = value;
        });
      },
      onDateSaved: (DateTime value) {
        widget.controller.save(widget.id, value);
        return value;
      },
      selectableDayPredicate: (DateTime value) {
        widget._valueNotifier.value = value;
        return true;
      },
    );
  }
}
