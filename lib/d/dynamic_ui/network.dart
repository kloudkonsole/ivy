import 'dart:convert' show json, jsonEncode;

import 'package:http/http.dart' as http;
import 'package:xml_parser/xml_parser.dart';

import './util.dart';

class Network {
  static final Network _singleton = Network._();
  static Network get instance => _singleton;

  Network._();

  Map<String, dynamic> defaultOption = {};
  Map<String, String> get _headers =>
      {'Accept': 'application/json', 'Content-Type': 'application/json'};

  void setDefault(Map<String, dynamic> option) {
    defaultOption = option ?? {};
  }

  Future<Map<String, dynamic>> query(
      Map<String, dynamic> option, Map<String, dynamic> value) async {
    option ??= {};
    final opt = Util.assign<String>(defaultOption, option);
    final params =
        Util.assign<String>(defaultOption['params'], option['params']);

    Util.replaceJSON(params, value);
    final uri = Uri.https(opt['host'], opt['path'], params);

    var res;

    switch (opt['method']) {
      case 'GET':
        res = await http.get(uri, headers: _headers);
        break;
      case 'POST':
        final body = Util.assign<String>(defaultOption['body'], option['body']);
        Util.replaceJSON(body, value);
        res = await http.post(uri, headers: _headers, body: jsonEncode(body));
        break;
    }

    // for security, script.google.com always redirect with 302
    if (res.statusCode == 302) {
      // parse return html to get temp url
      // send again
      XmlDocument xmlDocument = XmlDocument.fromString(res.body);
      final achor = xmlDocument.getElementWhere(name: 'a');

      final redirectUri = Uri.parse(achor.getAttribute('href'));
      res = await http.get(redirectUri, headers: _headers);
      /*
      final newOption = {
        'method': option['method'],
        'host': redirectUri.authority,
        'path': redirectUri.path,
        'params':
            Util.assign<String>(option['params'], redirectUri.queryParameters),
        'body': option['body']
      };
      return query(newOption, value);
      */
    } else if (res.statusCode >= 400) {
      throw Exception(
          '${opt['method']} ${opt['path']} Status[${res.statusCode}]');
    }

    return json.decode(res.body);
  }
}
