import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:ivy/s/cfg.dart';

class GitHub {
  final _host = 'api.github.com';
  final Map<String, String> _headers = {'Accept': '*/*'};

  // github branches return List or Map
  Future<String> getVersion() async {
    final owner = await Cfg.instance.getStr('owner');
    final repo = await Cfg.instance.getStr('repo');
    final branch = await Cfg.instance.getStr('branch');
    final path = '/repos/$owner/$repo/branches';
    final uri = Uri.https(_host, path);
    final res = await http.get(uri, headers: _headers);

    if (res.statusCode >= 500) throw Exception('GET $path Status[${res.statusCode}]');
    final body = json.decode(res.body);

    if (res.statusCode >= 400) throw Exception('GET $path Status[${res.statusCode}] Message[${body['message']}]');

    final list = body as List;

    final b = list.firstWhere((element) => element['name'] == branch);
    return b['commit']['sha'];
  }
}