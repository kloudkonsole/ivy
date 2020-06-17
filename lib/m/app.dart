import 'package:flutter/material.dart';

class App{
  String id;
  Color bgcolor;
  Color color;
  String icon;
  String name;
  String desc;
  String author;
  bool private;

  App({
    this.id, 
    this.bgcolor,
    this.color, 
    this.icon,
    this.name, 
    this.desc, 
    this.author,
    this.private,
  });

  factory App.fromJson(json){
    Color bgcolor = Color(int.parse(json['color'].replaceAll('#', '0xff')));
    Color color = bgcolor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return App(
      id: json['id'],
      bgcolor: bgcolor,
      color: color,
      icon: json['urls']['icon'],
      name: json['urls']['name'],
      desc: json['alt_description'] ,
      author: json['user']['author'],
      private: json['user']['private'],
    );
  }

  @override
  bool operator == (Object other) => identical(this, other) || other is App && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  String get text => name ?? desc ?? 'No Description';
}