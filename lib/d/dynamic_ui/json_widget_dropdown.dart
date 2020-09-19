import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './json_widget_controller.dart';
import './util.dart';

class JSONWidgetDropdown<T> extends StatefulWidget {
  final List<dynamic> schema;
  final Map<String, dynamic> attr;
  final String id;
  final String label;
  final String type;
  final bool mandatory;

  JSONWidgetDropdown._({@required this.schema, @required this.attr})
      : id = Util.cast<String>(attr['id'], 'ID'),
        label = Util.cast<String>(attr['lbl'], 'LABEL'),
        type = Util.cast<String>(attr['type'], 'text'),
        mandatory = Util.cast<bool>(attr['required'], false);

  JSONWidgetDropdown(schema)
      : this._(
            schema: schema, attr: Util.cast<Map<String, dynamic>>(schema[1]));

  @override
  _JSONWidgetDropdownState<T> createState() => _JSONWidgetDropdownState();
}

class _JSONWidgetDropdownState<T> extends State<JSONWidgetDropdown<T>> {
  ValueNotifier<T> notifier;
  JSONWidgetController ctrl;

  @override
  void initState() {
    super.initState();

    ctrl = Provider.of<JSONWidgetController>(context, listen: false);
    notifier = ctrl.setValue<T>(widget.id, widget.attr['value']);
  }

  @override
  Widget build(BuildContext ctx) {
    return ValueListenableBuilder<T>(
        valueListenable: notifier,
        builder: (BuildContext context, T value, Widget child) {
          return DropdownButtonFormField<T>(
            value: value,
            items: widget.attr['items']
                .map<DropdownMenuItem<T>>((item) => new DropdownMenuItem<T>(
                    child: Text(item[1]), value: item[0]))
                .toList(),
            decoration: InputDecoration(
                labelText: widget.label + (widget.mandatory ? '*' : '')),
            onChanged: (T value) {
              //ctrl.setValue<T>(widget.id, value);
            },
            validator: (T value) {
              if (widget.mandatory && value == null)
                return '${widget.label} is required';
              return null;
            },
            onSaved: (T value) {
              ctrl.setValue<T>(widget.id, value);
              return value;
            },
          );
        });
  }
}
