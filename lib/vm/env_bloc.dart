import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';

import 'package:ivy/s/bindwood.dart';

class EnvBloc with ChangeNotifier {
  BindWood _source = new BindWood();
  Map<String, Map<String, dynamic>> env = {};

  Future fetchEnv(String id) async {
    //String text = await _source.fetch(id, 'env');
    String text = '''
{
  "fields": [
    {
      "label": "ID",
      "readonly": true,
      "extra": {},
      "name": "id",
      "widget": "number",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "Item Name",
      "readonly": false,
      "extra": {"help": "Please Enter your item name", "default": ""},
      "name": "name",
      "widget": "text",
      "iconName": "name",
      "actionName": "qr_code",
      "required": true,
      "translated": false,
      "validations": {
        "length": {"maximum": 1024}
      }
    },
    {
      "label": "description",
      "readonly": false,
      "extra": {"help": "Please enter your item description"},
      "name": "description",
      "widget": "text",
      "required": true,
      "translated": false,
      "validations": {
        "length": {"maximum": 1024}
      }
    },
    {
      "label": "created time",
      "readonly": false,
      "extra": {"help": "Please enter your item description"},
      "name": "time",
      "widget": "datetime",
      "required": true,
      "translated": false,
      "validations": {}
    },
    {
      "label": "price",
      "readonly": false,
      "extra": {"default": 0.0},
      "name": "price",
      "widget": "number",
      "required": true,
      "translated": false,
      "validations": {}
    },
    {
      "label": "column",
      "readonly": false,
      "extra": {"default": 1},
      "name": "column",
      "widget": "number",
      "required": true,
      "translated": false,
      "validations": {}
    },
    {
      "label": "row",
      "readonly": false,
      "extra": {"default": 1},
      "name": "row",
      "widget": "number",
      "required": true,
      "translated": false,
      "validations": {}
    },
    {
      "label": "qr code",
      "readonly": false,
      "extra": {},
      "name": "qr_code",
      "widget": "text",
      "required": true,
      "translated": false,
      "validations": {
        "length": {"maximum": 10008}
      }
    },
    {
      "label": "unit",
      "readonly": false,
      "extra": {
        "choices": [
          {"label": "US Dollar", "value": "USD"},
          {"label": "Hong Kong Dollar", "value": "HDK"},
          {"label": "RMB", "value": "CNY"}
        ],
        "default": "USD"
      },
      "name": "unit",
      "widget": "select",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "created time",
      "readonly": true,
      "extra": {},
      "name": "created_time",
      "widget": "datetime",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "author",
      "readonly": false,
      "extra": {"related_model": "storage-management/author"},
      "name": "author_name",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "series",
      "readonly": false,
      "extra": {"related_model": "storage-management/series"},
      "name": "series_name",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "category",
      "readonly": false,
      "extra": {"related_model": "storage-management/category"},
      "name": "category_name",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "location",
      "readonly": false,
      "extra": {"related_model": "storage-management/location"},
      "name": "location_name",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "detail position",
      "readonly": false,
      "extra": {"related_model": "storage-management/detailposition"},
      "name": "position_name",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "uuid",
      "readonly": true,
      "extra": {"default": "2584ca7c-bab3-4231-a846-c2aecbd4ba00"},
      "name": "uuid",
      "widget": "text",
      "required": false,
      "translated": false,
      "validations": {}
    }
  ]
}
    ''';
    env[id] = json.decode(text);

    return env[id];
  }

  Future<Map<String, dynamic>> getForm(String key) async {
    if (env.containsKey(key)) {
      return env[key];
    } else {
      return await fetchEnv(key);
    }
  }
}
