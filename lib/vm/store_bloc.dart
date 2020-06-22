import 'package:flutter/material.dart';
import 'package:ivy/m/app.dart';

import 'package:ivy/s/github.dart';
import 'package:ivy/s/storage.dart';

class StoreBloc with ChangeNotifier{
  List<App> _apps = [];
  GitHub repo = new GitHub();
  BindWood source = new BindWood();
  Storage storedb = new Storage('store');

  List<App> get apps {
    return _apps;
  }

  StoreBloc(){
    init();
  }

  Future init() async{
    String current = await repo.getVersion();
    String last = await storedb.getString('store_version');
    if (current == last){
      _apps = await storedb.getList('store');
    }else{
      _apps = source.getStore();
      await storedb.add('store_version', current);
      await storedb.add('store', _apps);
    }
  }
}