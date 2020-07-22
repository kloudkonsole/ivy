import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';

//import 'package:ivy/s/bindwood.dart';

class EnvBloc with ChangeNotifier {
  //BindWood _source = new BindWood();
  Map<String, List<dynamic>> env = {};

  Future fetchEnv(String id) async {
    //String text = await _source.fetch(id, 'env');
    /*
    String text = '''
  ["root", {"id": "blu"}, ["form", {"id": "pp"}, [
      ["search", {"id": "reference"}, []],
      ["dropdown", {"id": "state"}, []],
      ["card", {"id": "detail"}, [
        ["text", {"id": "id"}, []],
        ["text", {"id": "dst.first_name"}, []],
        ["dropdown", {"id": "dst.ccode"}, []],
        ["text", {"id: "dst.mobile"}, []],
        ["text", {"id": "dst.email"}, []],
        ["dropdown", {"id": "dst.bluport_idx"}. []],
        ["dropdown", {"id": "dst.size"}, []],
        ["text", {"id": "dst.r"}, []],
        ["text", {"id": "dst.c"}, []]
      ]]
    ]]
  ]
    ''';
*/
    String text = '''
  ["root", {"id": "blu"}, ["form", {"id": "pp"}, [
      ["search", {
        "id": "reference",
        "lbl": "Parcel Reference",
        "required": true,
        "type": "text"
      }],
      ["text", {
        "id": "id",
        "lbl": "Parcel ID",
        "required": true,
        "type": "text"
      }]
  ]]]
    ''';
    env[id] = json.decode(text);

    return env[id];
  }

  Future<List<dynamic>> getForm(String key) async {
    if (env.containsKey(key)) {
      return env[key];
    } else {
      return await fetchEnv(key);
    }
  }
}
