import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './util.dart';
import './form_bloc.dart';

class JSONWidgetText extends StatelessWidget {
  final List<dynamic> schema;
  final TextEditingController _ctrl = TextEditingController();

  JSONWidgetText({@required this.schema});

  @override
  Widget build(BuildContext ctx) {
    final bloc = Provider.of<FormBloc>(ctx);
    final attr = Util.cast<Map<String, dynamic>>(schema[1]);
    final label = Util.cast<String>(attr['lbl'], 'LABEL');
    final type = Util.cast<String>(attr['type'], 'text');
    final mandatory = Util.cast<bool>(attr['required'], false);

    _ctrl.text = bloc.readString('text');

    return TextFormField(
      controller: _ctrl,
      decoration: InputDecoration(labelText: label + (mandatory ? '*' : '')),
      keyboardType: Util.str2enum<TextInputType>(TextInputType.values, type),
      textInputAction: TextInputAction.done,
      validator: (String value) {
        if (mandatory && value.isEmpty) return '$label is required';
        return null;
      },
      onSaved: (String value) {
        bloc.save('text', value);
        return value;
      },
    );
  }
}
