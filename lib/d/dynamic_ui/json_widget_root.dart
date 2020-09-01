import 'package:flutter/material.dart';

import './json_widget.dart';
import './json_widget_controller.dart';

import './network.dart';
import './util.dart';

class JSONWidgetRoot extends StatelessWidget {
  final List<dynamic> schema;
  final JSONWidgetController controller;

  JSONWidgetRoot({@required this.schema, @required this.controller});

  @override
  Widget build(BuildContext ctx) {
    final attr = Util.cast<Map<String, dynamic>>(schema[1]);
    final child = Util.cast<List<dynamic>>(schema[2]);

    Network.instance.setDefault(attr['http']);
    controller.submitOpt = attr['submit'];

    return SafeArea(
        child: GestureDetector(
            onTap: () => FocusScope.of(ctx).requestFocus(FocusNode()),
            child: JSONWidget(schema: child, controller: controller)));
  }
}
