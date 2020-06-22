import 'dart:async';

import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class Storage {

  Database _db;
  var store = StoreRef<String, String>.main();

  Storage(String name){
    init(name);
  }

  Future init(name) async {
    this._db = await databaseFactoryIo.openDatabase(join('.ivy', name + '.db'));
  }

  Future add(key, value) async {
    store.record(key).put(_db, value);
  }

  Future<String> getString(key) async {
    return store.record(key).get(key);
  }

}