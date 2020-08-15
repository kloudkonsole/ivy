import 'package:flutter/material.dart';

class JSONWidgetController {
  GlobalKey<FormState> formKey;
  List<TextEditingController> fields = [];
  Map<String, dynamic> attr;

  final Map<String, dynamic> _value = {};

  void save(String key, dynamic value) {
    _value[key] = value;
  }

  String readString(String key) {
    return _value[key];
  }

  Future<Map<String, dynamic>> onSubmit(BuildContext ctx) async {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      // hide keyboard
      FocusScope.of(ctx).requestFocus(FocusNode());
      //submit form
      var ret = new Map<String, dynamic>.from(_value);
      // clear the content
      _value.clear();
      form.reset();
      fields.forEach((element) {
        element.clear();
      });

      return ret;
    } else {
      print("Form is not vaild");
      return {};
    }
  }
}
