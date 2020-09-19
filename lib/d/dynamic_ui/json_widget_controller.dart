// implemented ValueNotifier based on https://www.didierboelens.com/2020/06/statefulwidget-interactions/
import 'package:flutter/material.dart';

import './network.dart';

class JSONWidgetController {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _submitOpt = {};

  final Map<String, ValueNotifier> _notifiers = {};

  Key get formKey => _formKey;

  ValueNotifier<T> setValue<T>(String key, T value) {
    ValueNotifier<T> n;
    if (_notifiers.containsKey(key)) {
      n = _notifiers[key];
      n.value = value;
    } else {
      n = ValueNotifier<T>(value);
      _notifiers[key] = n;
    }
    return n;
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = {};
    _notifiers.forEach((key, n) {
      map[key] = n.value;
    });
    return map;
  }

  void reload(Map<String, dynamic> obj) {
    obj.forEach((key, value) {
      if (_notifiers.containsKey(key)) _notifiers[key].value = value;
    });
  }

  void setSubmitOption(Map<String, dynamic> option) {
    _submitOpt = Map.from(option);
  }

  Future<Map<String, dynamic>> onSubmit(BuildContext ctx) async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      // hide keyboard
      FocusScope.of(ctx).requestFocus(FocusNode());
      //submit form
      var ret = new Map<String, dynamic>.from(getValues());

      await Network.instance.query(_submitOpt, ret);
      // clear the content
      form.reset();
      _notifiers.forEach((key, n) {
        n.value = null;
      });

      return ret;
    } else {
      print("Form is not vaild");
      return {};
    }
  }
}
