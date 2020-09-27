import 'package:flutter/material.dart';
import 'package:ivy/d/dynamic_ui/service.dart';

class Firestore extends Service {
  final Map<String, dynamic> defaultOption;

  Firestore({@required this.defaultOption});

  @override
  Future<Map<String, dynamic>> query(
      Map<String, dynamic> option, Map<String, dynamic> value) async {
    // TODO: implement query
    throw UnimplementedError();
  }
}
