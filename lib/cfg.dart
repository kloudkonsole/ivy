import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Cfg {
  final String owner;
  final String repo;
  final String branch;

  Cfg({this.owner = "", this.repo = "", this.branch = ""});

  factory Cfg.fromJson(Map<String, dynamic> jsonMap) {
    return new Cfg(owner: jsonMap["owner"], repo: jsonMap["repo"], branch: jsonMap["branch"]);
  }
  static Future<Cfg> load(path) {
    return rootBundle.loadStructuredData<Cfg>(path, (jsonStr) async {
      return Cfg.fromJson(json.decode(jsonStr));
    });
  }
}