import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  final String id;

  StoreScreen({Key key, @required this.id}) : super(key: key){
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'App Store Page',
            style: TextStyle(fontSize: 50),
          ),
          RaisedButton(
            child: Text('Home'),
            onPressed: (){
              Navigator.of(ctx).pop();
            }),
          RaisedButton(
            child: Text('Safe Entry'),
            onPressed: (){
              Navigator.of(ctx).pushNamed('/store/:id', arguments: '1');
            })
        ],
      ),
    );
  }
}