import 'package:flutter/material.dart';

import './json_widget_root.dart';
import './json_widget_form.dart';
import './json_widget_card.dart';
import './json_widget_search.dart';
import './json_widget_text.dart';
import './json_widget_dropdown.dart';
import './json_widget_controller.dart';
import './util.dart';

class JSONWidget extends StatelessWidget {
  final List<dynamic> schema;
  final JSONWidgetController controller;

  JSONWidget({@required this.schema, this.controller});

  @override
  Widget build(BuildContext ctx) {
    final type = Util.cast<String>(schema[0]);
    switch (type) {
      case 'form':
        return JSONWidgetForm(schema: schema, controller: controller);
      case 'card':
        return JSONWidgetCard(schema: schema);
      case 'text':
        return JSONWidgetText(schema: schema);
      case 'search':
        return JSONWidgetSearch(schema: schema);
      case 'dropdown':
        return JSONWidgetDropDown(schema: schema);
      case 'root':
        return JSONWidgetRoot(
          schema: schema,
          controller: controller,
        );
    }
    return JSONWidgetText(schema: [
      'text',
      {'id': 'error', 'value': 'unknown $type'}
    ]);
  }
}
