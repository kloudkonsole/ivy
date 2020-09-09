import 'package:flutter/material.dart';

import 'package:ivy/d/dynamic_ui/json_stateful_widget.dart';
import 'package:ivy/d/dynamic_ui/json_widget_controller.dart';

import './util.dart';

class JSONWidgetDropdown<T> extends StatefulWidget
    implements JSONStatefulWidget<T> {
  final List<dynamic> schema;
  final Map<String, dynamic> attr;
  final String id;
  final String label;
  final String type;
  final bool mandatory;
  final JSONWidgetController controller;
  final _valueNotifier = ValueNotifier<T>(null);

  JSONWidgetDropdown._(
      {@required this.schema, @required this.controller, @required this.attr})
      : id = Util.cast<String>(attr['id'], 'ID'),
        label = Util.cast<String>(attr['lbl'], 'LABEL'),
        type = Util.cast<String>(attr['type'], 'text'),
        mandatory = Util.cast<bool>(attr['required'], false) {
    if (controller != null) {
      controller.addWidget(id, this);
    }
  }

  JSONWidgetDropdown(schema, controller)
      : this._(
            schema: schema,
            controller: controller,
            attr: Util.cast<Map<String, dynamic>>(schema[1]));

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
  T _selection;

  @override
  void initState() {
    super.initState();

    _selection = widget.attr['def'];

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
    return DropdownButtonFormField<T>(
      value: _selection,
      items: widget.attr['items']
          .map<DropdownMenuItem<T>>((item) =>
              new DropdownMenuItem<T>(child: Text(item[1]), value: item[0]))
          .toList(),
      decoration: InputDecoration(
          labelText: widget.label + (widget.mandatory ? '*' : '')),
      onChanged: (T value) {
        widget._valueNotifier.value = value;
      },
      validator: (T value) {
        if (widget.mandatory && value == null)
          return '${widget.label} is required';
        return null;
      },
      onSaved: (T value) {
        widget.controller.save(widget.id, value);
        return value;
      },
    );
  }
}
