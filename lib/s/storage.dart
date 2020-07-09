import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class Storage {

  static final Storage _singleton = Storage._();
  static Storage get instance => _singleton;

  Completer<Database> _completer;

  Storage._();

  Future<Database> get db async {
    if (_completer == null) {
      _completer = Completer();

      // get app document path
      final appDocDir = await getApplicationDocumentsDirectory();

      final db = await databaseFactoryIo.openDatabase(join(appDocDir.path, 'app.db'));

      _completer.complete(db);
    }

    return _completer.future;
  }
}