import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ivy/w/tile.dart';
import 'package:ivy/m/app.dart';
import 'package:ivy/s/github.dart';
import 'package:ivy/s/app_store.dart';
import 'package:ivy/s/bindwood.dart';

class StoreBloc with ChangeNotifier{
  static double size = 90;
  List<Widget> _widgets = <Widget>[];

  GitHub _repo = new GitHub();
  BindWood _source = new BindWood();
  AppStore _storedb = new AppStore();

  List<App> _apps = [];
  String _ver = '';

  String get version => _ver;
  List<Widget> get apllications => _widgets;

  StoreBloc(){
    load();
  }

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

    _widgets = _apps.map((a) => Tile(url: _source.assetURL(a.id, a.icon), name: a.name)).toList();

    notifyListeners();
  }

  void removeAt(int index){
    _widgets.removeAt(index);
    notifyListeners();
  }

  void add(Widget widget){
    _widgets.add(widget);
    notifyListeners();
  }

  void swap(int oldIndex, int newIndex){
    Widget widget = _widgets.removeAt(oldIndex);
    _widgets.insert(newIndex, widget);
    notifyListeners();
  }
}