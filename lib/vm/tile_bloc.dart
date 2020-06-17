import 'package:flutter/material.dart';

class TileBloc with ChangeNotifier{
  static double size = 90;
  List<Widget> _tiles = <Widget>[
      Icon(Icons.filter_1, size: TileBloc.size),
      Icon(Icons.filter_2, size: TileBloc.size),
      Icon(Icons.filter_3, size: TileBloc.size),
      Icon(Icons.filter_4, size: TileBloc.size),
      Icon(Icons.filter_5, size: TileBloc.size),
      Icon(Icons.filter_6, size: TileBloc.size),
      Icon(Icons.filter_7, size: TileBloc.size),
      Icon(Icons.filter_8, size: TileBloc.size),
      Icon(Icons.filter_9, size: TileBloc.size),
    ];

  List<Widget> get tiles {
    return _tiles;
  }

  void removeAt(int index){
    _tiles.removeAt(index);
    notifyListeners();
  }

  void add(Widget tile){
    _tiles.add(tile);
    notifyListeners();
  }

  void swap(int oldIndex, int newIndex){
    Widget tile = _tiles.removeAt(oldIndex);
    _tiles.insert(newIndex, tile);
    notifyListeners();
  }
}