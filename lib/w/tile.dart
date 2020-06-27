import 'package:flutter/material.dart';

class Tile extends StatelessWidget{
  final String url;
  final String name;

  Tile({
    @required this.url,
    @required this.name,
  });

  @override
  Widget build(BuildContext ctx){
    return Column(
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
    );
  }
}