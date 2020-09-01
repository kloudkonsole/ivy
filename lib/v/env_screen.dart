import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../d/dynamic_ui/json_widget.dart';
import '../d/dynamic_ui/json_widget_controller.dart';
import '../m/app.dart';
import '../vm/env_bloc.dart';
import '../w/empty_state.dart';

class EnvScreen extends StatelessWidget {
  final App app;
  final JSONWidgetController _ctrl = new JSONWidgetController();

  EnvScreen({Key key, @required this.app}) : super(key: key);

  void save(BuildContext ctx) async {
    _ctrl.onSubmit(ctx);
  }

  @override
  Widget build(BuildContext ctx) {
    final bloc = Provider.of<EnvBloc>(ctx);

    return Scaffold(
      appBar: AppBar(title: Text(app.name), actions: <Widget>[
        FlatButton(
          textColor: Colors.white,
          child: Text('Reset'),
          onPressed: () {
            /* TODO: remove from home page */
          },
        ),
        FlatButton(
          textColor: Colors.white,
          child: Text('Save'),
          onPressed: () {
            save(ctx);
            /* TODO: save to home page */
          },
        ),
      ]),
      body: FutureBuilder<List<dynamic>>(
        future: bloc.getForm(app.id),
        builder: (BuildContext ctx, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: EmptyState(
                title: 'Oops',
                message: snapshot.error,
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return SizedBox.expand(
              child: JSONWidget(schema: snapshot.data, controller: _ctrl));
        },
      ),
    );
  }
}
