import 'package:flutter/material.dart';

class CfgScreen extends StatelessWidget {
  final String id;

  CfgScreen({Key key, @required this.id}) : super(key: key){
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
            'App Configuration Page',
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
