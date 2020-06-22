import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:ivy/cfg.dart';

class GitHub {
  Cfg _cfg;
  final _host = 'api.github.com';
  Map<String, String> get _headers => {'Accept': '*/*'};

  GitHub(){
    loadCfg("cfg.json");
  }

  void loadCfg(path) async{
    _cfg = await Cfg.load(path);
  }

  // github branches return List or Map
  Future<String> getVersion() async {
    final path = '/repos/${_cfg.owner}/${_cfg.repo}/branches';
    final uri = Uri.https(_host, path);
    final res = await http.get(uri, headers: _headers);

    if (res.statusCode >= 500) throw Exception('GET $path Status[${res.statusCode}]');
    final body = json.decode(res.body);

    if (res.statusCode >= 400 && body['message']>= 500) throw Exception('GET $path Status[${res.statusCode}] Message[${body['messgae']}]');

    final list = body as List;

    final branch = list.firstWhere((element) => element['name'] == _cfg.branch);
    return branch['commit']['sha'];
  }
}