import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:ivy/m/app.dart';

class BindWood {
  static const String HOST = 'kloudkonsole.com';
  static const String PATH = '/bindwood';
  Map<String, String> get _headers => {'Accept': '*/*'};

  // github branches return List or Map
  Future<List<App>> getStore() async {
    final uri = Uri.https(HOST, '$PATH/apps.json');
    final res = await http.get(uri, headers: _headers);

    if (res.statusCode >= 400) throw Exception('GET $PATH Status[${res.statusCode}]');
    var list = json.decode(res.body);
    List<App> apps = List<App>.from(list.map((i) => App.fromJson(i)));

    return apps;
  }

  String assetURL(String id, String asset){
    return 'https://$HOST$PATH/$id/$asset';
  }
}