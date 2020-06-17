import 'package:flutter/material.dart';

class ErrScreen extends StatelessWidget {
  final String code;

  ErrScreen({Key key, @required this.code}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text('Error: ' + code)
      )
    );
  }
}

