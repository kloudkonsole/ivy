import 'package:flutter/material.dart';

import './json_widget_root.dart';
import './json_widget_form.dart';
import './json_widget_card.dart';
import './json_widget_search.dart';
import './json_widget_text.dart';
import './json_widget_dropdown.dart';

class JSONWidget extends StatelessWidget {
  final List<dynamic> schema;

  JSONWidget({@required this.schema});

  T cast<T>(x) => x is T ? x : null;

  @override
  Widget build(BuildContext ctx) {
    final type = cast<String>(schema[0]);
    switch (type) {
      case 'form':
        return new JSONWidgetForm(schema: schema);
      case 'card':
        return new JSONWidgetCard(schema: schema);
      case 'text':
        return new JSONWidgetText(schema: schema);
      case 'search':
        return new JSONWidgetSearch(schema: schema);
      case 'dropdown':
        return new JSONWidgetDropDown(schema: schema);
      case 'root':
        return new JSONWidgetRoot(schema: schema);
    }
  }
}
