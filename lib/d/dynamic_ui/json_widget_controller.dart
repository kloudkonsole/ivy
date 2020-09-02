import 'package:flutter/material.dart';
import 'package:ivy/d/dynamic_ui/json_stateful_widget.dart';

import './network.dart';

class JSONWidgetController {
  GlobalKey<FormState> formKey;
  Map<String, dynamic> submitOpt;

  final Map<String, JSONStatefulWidget> _widgets = {};
  final Map<String, dynamic> _value = {};

  void addWidget(String key, JSONStatefulWidget widget) {
    _widgets[key] = widget;
  }

  void save(String key, dynamic value) {
    _value[key] = value;
  }

  String readString(String key) {
    return _value[key];
  }

  void reload(Map<String, dynamic> obj) {
    obj.forEach((key, value) {
      if (_widgets.containsKey(key)) _widgets[key].setValue(value);
    });
    _value.addAll(obj);
  }

  Future<Map<String, dynamic>> onSubmit(BuildContext ctx) async {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      // hide keyboard
      FocusScope.of(ctx).requestFocus(FocusNode());
      //submit form
      var ret = new Map<String, dynamic>.from(_value);

      Network.instance.query(submitOpt, ret);
      // clear the content
      _value.clear();
      form.reset();
      _widgets.forEach((key, value) {
        value.clearValue();
      });

      return ret;
    } else {
      print("Form is not vaild");
      return {};
    }
  }
}
