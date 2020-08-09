import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './json_widget.dart';
import './util.dart';
import './form_bloc.dart';

class JSONWidgetRoot extends StatelessWidget {
  final List<dynamic> schema;

  JSONWidgetRoot({@required this.schema});

  @override
  Widget build(BuildContext ctx) {
    final attr = Util.cast<Map<String, dynamic>>(schema[1]);
    final child = Util.cast<List<dynamic>>(schema[2]);

    return Provider<FormBloc>(
        create: (_ctx) => FormBloc(attr: attr),
        child: SafeArea(
            child: GestureDetector(
                onTap: () => FocusScope.of(ctx).requestFocus(FocusNode()),
                child: JSONWidget(schema: child))));
  }
}
