import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'package:ivy/d/dynamic_ui/json_stateful_widget.dart';
import 'package:ivy/d/dynamic_ui/json_widget_controller.dart';

import './util.dart';

class JSONWidgetDropdown<T> extends StatefulWidget
    implements JSONStatefulWidget<T> {
  final List<dynamic> schema;
  final JSONWidgetController controller;
  final _valueNotifier = ValueNotifier<T>(null);

  JSONWidgetDropdown({@required this.schema, @required this.controller});

  @override
  _JSONWidgetDropdownState<T> createState() => _JSONWidgetDropdownState();

  @override
  void setValue(T value) {
    _valueNotifier.value = value;
  }

  @override
  void clearValue() {
    _valueNotifier.value = null;
  }
}

class _JSONWidgetDropdownState<T> extends State<JSONWidgetDropdown<T>> {
  Map<String, dynamic> attr = {};
  String id = '';
  String label = '';
  String type = '';
  bool mandatory = true;
  T _selection;

  @override
  void initState() {
    super.initState();

    widget._valueNotifier.addListener(() {
      setState(() {
        _selection = widget._valueNotifier.value;
      });
    });

    attr = Util.cast<Map<String, dynamic>>(widget.schema[1]);
    id = Util.cast<String>(attr['id'], 'ID');
    label = Util.cast<String>(attr['lbl'], 'LABEL');
    type = Util.cast<String>(attr['type'], 'text');
    mandatory = Util.cast<bool>(attr['required'], false);

    if (widget.controller != null) {}
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return DropdownButtonFormField<T>(
      value: _selection,
      items: [DropdownMenuItem<T>(child: Text("test"))],
      decoration: InputDecoration(labelText: label + (mandatory ? '*' : '')),
      onChanged: (T value) {
        setState(() {
          _selection = value;
        });
      },
      validator: (T value) {
        if (mandatory && value == null) return '$label is required';
        return null;
      },
      onSaved: (T value) {
        widget.controller.save(id, value);
        return value;
      },
    );
  }
}
