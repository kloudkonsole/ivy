import 'dart:async';
import 'dart:convert';

import 'package:sembast/sembast.dart';
import 'package:ivy/s/storage.dart';
import 'package:ivy/m/app.dart';

class AppStore {

  final store = StoreRef<String, String>.main();

  Future setList(String key, List<App> value) async {
    store.record(key).put(await Storage.instance.db, jsonEncode(value));
  }

  Future setStr(String key, String value) async {
    store.record(key).put(await Storage.instance.db, value);
  }

  Future<List<App>> getList(key) async {
    var str = await store.record(key).get(await Storage.instance.db);
    var list = json.decode(str);
    return List<App>.from(list.map((i) => App.fromJson(i)));
  }

  Future<String> getStr(key) async {
    return store.record(key).get(await Storage.instance.db);
  }

}