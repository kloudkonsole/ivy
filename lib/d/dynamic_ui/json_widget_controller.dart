import 'package:flutter/material.dart';

typedef Future<Map<String, dynamic>> OnSubmit(BuildContext ctx);

class JSONWidgetController {
  OnSubmit onSubmit;
  GlobalKey<FormState> formKey;
}
