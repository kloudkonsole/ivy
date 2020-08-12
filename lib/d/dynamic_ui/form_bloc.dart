import 'package:flutter/material.dart';

import './json_widget_controller.dart';

class FormBloc with ChangeNotifier {
  final Map<String, dynamic> attr;
  final Map<String, dynamic> _value = {};
  final JSONWidgetController controller;

  FormBloc({@required this.attr, @required this.controller}) {
    controller.onSubmit = onSubmit;
  }

  void save(String key, dynamic value) {
    _value[key] = value;
  }

  String readString(String key) {
    return _value[key];
  }

  Future<Map<String, dynamic>> onSubmit(BuildContext ctx) async {
    var state = controller.formKey.currentState;
    if (state.validate()) {
      state.save();
      // hide keyboard
      FocusScope.of(ctx).requestFocus(FocusNode());
      // clear the content
      state.reset();
      return _value;
    } else {
      print("Form is not vaild");
      return {};
    }
  }
}
