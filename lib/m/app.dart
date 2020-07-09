import 'package:flutter/material.dart';

class App{
  String id;
  Color bgcolor;
  Color color;
  String icon;
  String name;
  String desc;
  String author;
  int private;

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
    Color color = Color(int.parse(json['color'].replaceAll('#', '0xff')));
    Color bgcolor = Color(int.parse(json['bgcolor'].replaceAll('#', '0xff')));
    return App(
      id: json['id'],
      bgcolor: bgcolor,
      color: color,
      icon: json['icon'],
      name: json['name'],
      desc: json['desc'] ,
      author: json['author'],
      private: json['private'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'bgcolor': '#${bgcolor.value.toRadixString(16)}',
    'color': '#${color.value.toRadixString(16)}',
    'icon': icon,
    'name': name,
    'desc': desc,
    'author': author,
    'private': private
  };

  @override
  String toString() {
    return """
    id: $id
    bgcolor: #${bgcolor.value.toRadixString(16)}
    color: #${color.value.toRadixString(16)}
    icon: $icon
    name: $name
    desc: $desc
    author: $author
    private: $private
    ----------------------------------
    """;
  }

  @override
  bool operator == (Object other) => identical(this, other) || other is App && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  String get text => name ?? desc ?? 'No Description';
}