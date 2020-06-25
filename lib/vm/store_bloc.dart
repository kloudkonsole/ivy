import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ivy/m/app.dart';

import 'package:ivy/s/github.dart';
import 'package:ivy/s/app_store.dart';
import 'package:ivy/s/bindwood.dart';

class StoreBloc with ChangeNotifier{
  GitHub _repo = new GitHub();
  BindWood _source = new BindWood();
  AppStore _storedb = new AppStore();

  List<App> _apps = [];
  String _ver = '';

  List<App> get applications => _apps;
  String get version => _ver;

  Future load() async{
    String current = await _repo.getVersion();
    String last = await _storedb.getStr('ver');
    if (current == last){
      _apps = await _storedb.getList('store');
    }else{
      _apps = await _source.getStore();
      await _storedb.setStr('ver', current);
      await _storedb.setList('store', _apps);
    }

    notifyListeners();
  }
}