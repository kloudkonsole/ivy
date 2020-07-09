import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';

import 'package:ivy/s/bindwood.dart';

class EnvBloc with ChangeNotifier {
  BindWood _source = new BindWood();
  Map<String, Map<String, dynamic>> env = {};

  Future fetchEnv(String id) async {
    String text = await _source.fetch(id, 'env');
    env[id] = json.decode(text);

    return env[id];
  }

  Future<Map<String, dynamic>> getForm(String key) async {
    if (env.containsKey(key)) {
      return env[key];
    } else {
      return await fetchEnv(key);
    }
  }
}
