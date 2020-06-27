import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  final String id;

  AppScreen({Key key, @required this.id}) : super(key: key);

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
            'App Page',
            style: TextStyle(fontSize: 50),
          ),
          RaisedButton(
            child: Text('Home'),
            onPressed: (){
              Navigator.of(ctx).pop();
            })
        ],
      ),
    );
  }
}
