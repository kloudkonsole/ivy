import 'package:flutter/material.dart';

import './json_widget_root.dart';
import './json_widget_form.dart';
import './json_widget_text.dart';
import './json_widget_search.dart';
import './json_widget_dropdown.dart';
import './json_widget_datepicker.dart';
import './json_widget_controller.dart';
import './util.dart';

class JSONWidget extends StatelessWidget {
  final List<dynamic> schema;
  final JSONWidgetController controller;

  JSONWidget({@required this.schema, this.controller});

  @override
  Widget build(BuildContext ctx) {
    final type = Util.cast<String>(schema[0]);
    final attr = Util.cast<Map<String, dynamic>>(schema[1]);
    String subtype = '';

    switch (type) {
      case 'root':
        return JSONWidgetRoot(schema: schema, controller: controller);
      case 'form':
        return JSONWidgetForm(schema: schema, controller: controller);
      case 'text':
        return JSONWidgetText(schema);
      case 'search':
        return JSONWidgetSearch(schema);
      case 'dropdown':
        subtype = Util.cast<String>(attr['type'], 'text');
        switch (subtype) {
          case 'text':
            return JSONWidgetDropdown<String>(schema);
          case 'int':
            return JSONWidgetDropdown<int>(schema);
          case 'bool':
            return JSONWidgetDropdown<bool>(schema);
          default:
            return JSONWidgetDropdown<String>(schema);
        }
        break;
      case 'date':
        return JSONWidgetDatePicker(schema);
    }
    return JSONWidgetText([
      'text',
      {'id': 'error', 'value': 'unknown type [$type]'}
    ]);
  }
}
