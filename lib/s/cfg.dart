import 'dart:async' show Completer, Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Cfg {

  static final Cfg _singleton = Cfg._();
  static Cfg get instance => _singleton;

  Completer<Map<String, dynamic>> _completer;

  Cfg._();

  Future<Map<String, dynamic>> get asset async {
    if (_completer == null) {
      _completer = Completer();

      final str = await rootBundle.loadString('cfg.json');

      _completer.complete(json.decode(str));
    }

    return _completer.future;
  }

  Future<String> getStr(String key) async {
    final map = await asset;
    return map[key] as String;
	}
  
	Future<int> getInt(String key) async {
	  final map = await asset;
	  return map[key] as int;
  }
}