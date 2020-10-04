import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';

//import 'package:ivy/s/bindwood.dart';

class EnvBloc with ChangeNotifier {
  //BindWood _source = new BindWood();
  Map<String, List<dynamic>> env = {};

  Future fetchEnv(String id) async {
    //String text = await _source.fetch(id, 'env');
    String text = '''
  ["root", {
    "id": "sample",
    "service":{
      "name": "parse",
      "keyApplicationId": "WVRsRhvTdjShpFqJqLJTNcsFxeXVC8KAgYc7BbJ4",
      "keyParseServerUrl": "https://parseapi.back4app.com/",
      "masterKey": "k6r5Aq5KjrHdkmft8mSsTgx4HE3Szn2DK4LCmac8",
      "clientKey": "FRnFF3TNskFyAX2qxgsBJjfYFH79OsgP5bfh8Blh"
    },
    "submit":[
      ["objectName", "inventory"],
      ["set", "key", "@id"],
      ["set", "ref", "@ref"],
      ["set", "sku", "@sku"],
      ["set", "own", "@own"],
      ["set", "img", "@img"],
      ["set", "s", "@s"],
      ["save"]
    ]
  }, ["form", {"id": "pp"}, [
      ["search", {
        "id": "ref",
        "lbl": "Parcel Reference",
        "required": true,
        "type": "text",
        "tip": [
          ["queryBuilder", "inventory"],
          ["Contains", "ref", "@ref"],
          ["query"]
        ],
        "read": [
          ["queryBuilder", "inventory"],
          ["Contains", "ref", "@ref"],
          ["query"]
        ]
      }],
      ["text", {
        "id": "id",
        "lbl": "Parcel ID",
        "required": true,
        "type": "text"
      }],
      ["text", {
        "id": "sku",
        "lbl": "SKU",
        "required": true,
        "type": "text"
      }],
      ["text", {
        "id": "own",
        "lbl": "Owner",
        "required": true,
        "type": "text"
      }],
      ["dropdown", {
        "id": "s",
        "lbl": "Status",
        "type": "int",
        "items": [[0, "Inactive"], [1, "Active"]]
      }],
      ["upload", {
        "id": "img",
        "lbl": "Image"
      }],
      ["canvas", {
        "id": "sig",
        "lbl": "Signature"
      }],
      ["date", {
        "id": "cat",
        "lbl": "Created At",
        "type": "datetime"
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
