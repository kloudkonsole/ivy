import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './json_widget.dart';
import './json_widget_controller.dart';

import './util.dart';

class JSONWidgetRoot extends StatelessWidget {
  final List<dynamic> schema;
  final JSONWidgetController controller;

  JSONWidgetRoot({@required this.schema, @required this.controller});

  @override
  Widget build(BuildContext ctx) {
    final attr = Util.cast<Map<String, dynamic>>(schema[1]);
    final child = Util.cast<List<dynamic>>(schema[2]);

    controller.createService(attr['service'], attr['submit']);

    return Provider<JSONWidgetController>(
        create: (BuildContext ctx) => controller,
        child: SafeArea(
            child: GestureDetector(
                onTap: () => FocusScope.of(ctx).requestFocus(FocusNode()),
                child: JSONWidget(schema: child, controller: controller))));
  }
}
