import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:ivy/m/app.dart';

class BindWood {
  final _host = 'kloudkonsole.com';
  Map<String, String> get _headers => {'Accept': '*/*'};

  // github branches return List or Map
  Future<List<App>> getStore() async {
    final path = '/bindwood/apps.json';
    final uri = Uri.https(_host, path);
    final res = await http.get(uri, headers: _headers);

    if (res.statusCode >= 400) throw Exception('GET $path Status[${res.statusCode}]');
    var list = json.decode(res.body);
    List<App> apps = List<App>.from(list.map((i) => App.fromJson(i)));

    return apps;
  }
}