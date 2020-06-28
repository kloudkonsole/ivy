import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ivy/s/bindwood.dart';

class EnvBloc with ChangeNotifier{
  BindWood _source = new BindWood();
  Map<String, String> env = {};

  Future fetchEnv(String id) async{

    String json = await _source.fetch(id, 'env');
    env[id] = json;

    notifyListeners();
  }

  String getJson(String key) {
    if (env.containsKey(key)){
      return env[key];
    }else {
      fetchEnv(key);
      return '';
    }
  }
}