import 'package:flutter/material.dart';
import 'package:ivy/m/app.dart';

class AppStoreBloc with ChangeNotifier{
  List<App> _apps = [];

  List<App> get apps {
    return _apps;
  }
}