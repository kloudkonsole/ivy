import 'dart:convert' show json, jsonEncode;
import 'package:http/http.dart' as http;

import './util.dart';

class Network {
  static final Network _singleton = Network._();
  static Network get instance => _singleton;

  Network._();

  Map<String, dynamic> defaultOption = {};
  Map<String, String> get _headers => {'Accept': '*/*'};

  void setDefault(Map<String, dynamic> option) {
    defaultOption = option ?? {};
  }

  Future<Map<String, dynamic>> query(
      Map<String, dynamic> option, Map<String, dynamic> value) async {
    option ??= {};
    final opt = Map.from(defaultOption);
    opt.addAll(option);

    final Map<String, String> params = Map.from(defaultOption['params'] ?? {});
    params.addAll(
        Map.castFrom<String, dynamic, String, String>(option['params'] ?? {}));

    Util.replaceJSON(params, value);
    final uri = Uri.https(opt['host'], opt['path'], params);

    var res;

    switch (opt['method']) {
      case 'GET':
        res = await http.get(uri, headers: _headers);
        break;
      case 'POST':
        final req = Map.from(defaultOption['body'] ?? {});
        req.addAll(option['body'] ?? {});
        res = await http.post(uri, headers: _headers, body: jsonEncode(req));
        break;
    }
    if (res.statusCode >= 400)
      throw Exception(
          '${opt['method']} ${opt['path']} Status[${res.statusCode}]');
    return json.decode(res.body);
  }
}
