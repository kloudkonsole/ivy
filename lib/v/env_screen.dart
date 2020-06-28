import 'package:flutter/material.dart';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:provider/provider.dart';

import 'package:ivy/m/app.dart';
import 'package:ivy/vm/env_bloc.dart';

class EnvScreen extends StatelessWidget implements ClickListener {
  final App app;

  EnvScreen({Key key, @required this.app}) : super(key: key);

  @override
  void onClicked(String event) {
    print("Receive click event: " + event);
  }


  @override
  Widget build(BuildContext ctx) {
    final bloc = Provider.of<EnvBloc>(ctx);

    return Scaffold(
      appBar: AppBar(
        title: Text(app.name),
        actions: <Widget>[
          FlatButton(
            child: Text('Remove'),
            onPressed: () {
              /* TODO: remove from home page */
            },
          ),
          FlatButton(
            child: Text('Save'),
            onPressed: () {
              /* TODO: save to home page */
            },
          ),
        ]
      ),
      body: FutureBuilder<Widget>(
        future: _buildWidget(ctx, bloc.getJson(app.id)),
        builder: (BuildContext ctx, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? SizedBox.expand(
                  child: snapshot.data,
                )
              : Text("Loading...");
        },
      ),
    );
  }

  Future<Widget> _buildWidget(BuildContext ctx, String json) async {
    return DynamicWidgetBuilder.build(json, ctx, this);
  }
}