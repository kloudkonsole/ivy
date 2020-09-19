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
    "http":{
      "method": "POST",
      "host": "script.google.com",
      "path": "/macros/s/AKfycbz96xSoMs04FMKx9qDrgxLqlaO-XJAeY146tlZ_rCN7vOvyRS0/exec",
      "params": {
        "book": "19wPdCQcOSh9yulIeAKQ0EBpu9f6gIBFb7mxuM-Wl3Ps",
        "page": "parcel"
      }
    },
    "submit":{
      "body": {
        "id": "@id",
        "ref": "@ref",
        "sku": "@sku",
        "own": "@own",
        "img": "@img",
        "s": "@s"
      }
    }
  }, ["form", {"id": "pp"}, [
      ["search", {
        "id": "ref",
        "lbl": "Parcel Reference",
        "required": true,
        "type": "text",
        "tip": {
          "method": "GET",
          "params": {
            "tip": "@ref",
            "key": "ref"
          }
        },
        "read": {
          "method": "GET",
          "params": {
            "find": "@ref",
            "key": "ref"
          }
        }
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
