import 'dart:convert' show json, jsonEncode;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ivy/d/dynamic_ui/service.dart';
import 'package:xml_parser/xml_parser.dart';

import '../util.dart';

class GoogleSheets extends Service {
  final Map<String, dynamic> defaultOption;
  Map<String, String> get _headers =>
      {'Accept': 'application/json', 'Content-Type': 'application/json'};

  GoogleSheets({@required this.defaultOption});

  @override
  Future<Map<String, dynamic>> query(
      Map<String, dynamic> option, Map<String, dynamic> value) async {
    option ??= {};
    final opt = Util.assign<String>(defaultOption, option);
    final paramTmpl =
        Util.assign<String>(defaultOption['params'], option['params']);

    final params = Util.replaceJSON(paramTmpl, value);
    final uri = Uri.https(opt['host'], opt['path'],
        Map.castFrom<String, dynamic, String, String>(params));

    var res;

    switch (opt['method']) {
      case 'GET':
        res = await http.get(uri, headers: _headers);
        break;
      case 'POST':
        final bodyTmpl =
            Util.assign<String>(defaultOption['body'], option['body']);
        final body = Util.replaceJSON(bodyTmpl, value);
        res = await http.post(uri, headers: _headers, body: jsonEncode(body));
        break;
    }

    // for security, script.google.com always redirect with 302
    if (res.statusCode == 302) {
      XmlDocument xmlDocument = XmlDocument.fromString(res.body);
      final achor = xmlDocument.getElementWhere(name: 'a');

      final redirectUri = Uri.parse(achor.getAttribute('href'));
      res = await http.get(redirectUri, headers: _headers);
    } else if (res.statusCode >= 400) {
      throw Exception(
          '${opt['method']} ${opt['path']} Status[${res.statusCode}]');
    }

    return json.decode(res.body);
  }
}
