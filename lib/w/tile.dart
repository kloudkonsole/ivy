import 'package:flutter/material.dart';

class Tile extends StatelessWidget{
  final String id;
  final String url;
  final String name;
  final Function(String) tap;

  Tile({
    @required this.id,
    @required this.name,
    @required this.url,
    @required this.tap,
  });

  Tile.clone(Tile tile, Function(String) onTap): this(id: tile.id, name: tile.name, url: tile.url, tap: onTap);

  @override
  Widget build(BuildContext ctx){
    return GestureDetector(
      onTap: () => tap(id),
      child: Column(
        children: <Widget>[
          Image.network(url, fit: BoxFit.fill, height: 60,),
          Container(
            width: 90,
            color: Colors.white.withOpacity(0.5),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(fontSize: 14, color: Colors.black), textAlign: TextAlign.center,),
          ),
        ],
      )
    );
  }
}