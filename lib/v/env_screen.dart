import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ivy/d/json_textform/JSONForm.dart';
import 'package:ivy/d/json_textform/JSONSchemaForm.dart';
import 'package:ivy/d/json_textform/models/Action.dart';
import 'package:ivy/d/json_textform/models/Controller.dart';
import 'package:ivy/d/json_textform/models/Icon.dart';
import 'package:ivy/d/json_textform/models/Schema.dart';
import 'package:ivy/m/app.dart';
import 'package:ivy/vm/env_bloc.dart';

class EnvScreen extends StatelessWidget {
  final App app;
  final JSONSchemaController jctrl = JSONSchemaController();

  EnvScreen({Key key, @required this.app}) : super(key: key);

  void save(BuildContext ctx) async {
    var value = await jctrl.onSubmit(ctx);
    print(value);
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
      body: FutureBuilder<Map<String, dynamic>>(
        future: bloc.getForm(app.id),
        builder:
            (BuildContext ctx, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final map = snapshot.data;
          return SizedBox.expand(
              child: JSONSchemaForm(
            schemaName: 'darren',
            controller: jctrl,
            onAddForignKeyField: (path, values) async {
              print("added");
            },
            onUpdateForignKeyField: (path, values, id) async {
              print("updated");
            },
            onFetchingForignKeyChoices: (path) async {
              print("$path");
              return [
                Choice(label: "Hello", value: "1"),
              ];
            },
            onFetchingSchema: (path, isEdit, id) async {
              print("$path $id");
              return SchemaValues(
                schema: (map['fields'] as List)
                    .map((s) => s as Map<String, dynamic>)
                    .toList(),
                values: {},
              );
            },
            filled: false,
            rounded: false,
            showSubmitButton: false,
            useDropdownButton: false,
            schema: (map['fields'] as List)
                .map((s) => s as Map<String, dynamic>)
                .toList(),
            icons: [
              FieldIcon(schemaName: "name", iconData: Icons.title),
              FieldIcon(schemaName: "description", iconData: Icons.description),
              FieldIcon(schemaName: "price", iconData: Icons.attach_money),
              FieldIcon(schemaName: "column", iconData: Icons.view_column),
              FieldIcon(schemaName: "row", iconData: Icons.view_list),
              FieldIcon(schemaName: "qr_code", iconData: Icons.scanner),
              FieldIcon(schemaName: "unit", iconData: Icons.g_translate)
            ],
            actions: [
              FieldAction(
                schemaName: "qr_code",
                actionTypes: ActionTypes.qrScan,
                actionDone: ActionDone.getInput,
              ),
              FieldAction<File>(
                  schemaName: "description",
                  schemaFor: "darren",
                  actionTypes: ActionTypes.image,
                  actionDone: ActionDone.getInput,
                  onDone: (File file) async {
                    if (file is File) {
                      print(file);
                    }
                    return file.path;
                  })
            ],
            url: "http://192.168.1.120",
            values: {
              "author_id": {"label": "sdfsdfa", "value": 2},
              "name": "abcdefhaha",
              "time": DateTime(2016, 1, 4, 1).toIso8601String(),
            },
          ));
        },
      ),
    );
  }
}
