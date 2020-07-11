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
      "readonly": true,
      "extra": {"related_model": "storage-management/author"},
      "name": "author_name",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "series",
      "readonly": true,
      "extra": {"related_model": "storage-management/series"},
      "name": "series_name",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "category",
      "readonly": true,
      "extra": {"related_model": "storage-management/category"},
      "name": "category_name",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "location",
      "readonly": true,
      "extra": {"related_model": "storage-management/location"},
      "name": "location_name",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "detail position",
      "readonly": true,
      "extra": {"related_model": "storage-management/detailposition"},
      "name": "position_name",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "images",
      "readonly": false,
      "extra": {"related_model": "storage-management/itemimage"},
      "name": "images",
      "widget": "tomany-table",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "files",
      "readonly": false,
      "extra": {"related_model": "storage-management/itemfile"},
      "name": "files",
      "widget": "tomany-table",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "author",
      "readonly": false,
      "extra": {"related_model": "storage-management/author"},
      "name": "author_id",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "series",
      "readonly": false,
      "extra": {"related_model": "storage-management/series"},
      "name": "series_id",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "category",
      "readonly": false,
      "extra": {"related_model": "storage-management/category"},
      "name": "category_id",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "location",
      "readonly": false,
      "extra": {"related_model": "storage-management/location"},
      "name": "location_id",
      "widget": "foreignkey",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "detail position",
      "readonly": false,
      "extra": {"related_model": "storage-management/detailposition"},
      "name": "position_id",
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
    },
    {
      "label": "files",
      "readonly": true,
      "extra": {"related_model": "storage-management/itemfile"},
      "name": "files_objects",
      "widget": "tomany-table",
      "required": false,
      "translated": false,
      "validations": {}
    },
    {
      "label": "images",
      "readonly": true,
      "extra": {"related_model": "storage-management/itemimage"},
      "name": "images_objects",
      "widget": "tomany-table",
      "required": false,
      "translated": false,
      "validations": {}
    }
  ],
  "fieldsets": [
    {
      "title": null,
      "fields": [
        {"name": "name"},
        {"name": "description"},
        {"name": "price"},
        {"name": "column"},
        {"name": "row"},
        {"name": "qr_code"},
        {"name": "unit"},
        {"name": "created_time"},
        {"name": "author_name"},
        {"name": "series_name"},
        {"name": "category_name"},
        {"name": "location_name"},
        {"name": "position_name"},
        {"name": "author_id"},
        {"name": "series_id"},
        {"name": "category_id"},
        {"name": "location_id"},
        {"name": "position_id"},
        {"name": "uuid"}
      ]
    }
  ],
  "list_display": ["id"],
  "filter_fields": [],
  "languages": [
    "af",
    "ar",
    "ast",
    "az",
    "bg",
    "be",
    "bn",
    "br",
    "bs",
    "ca",
    "cs",
    "cy",
    "da",
    "de",
    "dsb",
    "el",
    "en",
    "en-au",
    "en-gb",
    "eo",
    "es",
    "es-ar",
    "es-co",
    "es-mx",
    "es-ni",
    "es-ve",
    "et",
    "eu",
    "fa",
    "fi",
    "fr",
    "fy",
    "ga",
    "gd",
    "gl",
    "he",
    "hi",
    "hr",
    "hsb",
    "hu",
    "hy",
    "ia",
    "id",
    "io",
    "is",
    "it",
    "ja",
    "ka",
    "kab",
    "kk",
    "km",
    "kn",
    "ko",
    "lb",
    "lt",
    "lv",
    "mk",
    "ml",
    "mn",
    "mr",
    "my",
    "nb",
    "ne",
    "nl",
    "nn",
    "os",
    "pa",
    "pl",
    "pt",
    "pt-br",
    "ro",
    "ru",
    "sk",
    "sl",
    "sq",
    "sr",
    "sr-latn",
    "sv",
    "sw",
    "ta",
    "te",
    "th",
    "tr",
    "tt",
    "udm",
    "uk",
    "ur",
    "vi",
    "zh-hans",
    "zh-hant"
  ],
  "ordering_fields": [],
  "needs": [
    {
      "app": "storage-management",
      "singular": "itemimage",
      "plural": "itemimages"
    },
    {"app": "storage-management", "singular": "itemfile", "plural": "itemfiles"}
  ],
  "list_editable": [],
  "sortable_by": null,
  "translated_fields": [],
  "custom_actions": [],
  "bulk_actions": [],
  "list_actions": [],
  "save_twice": false,
  "search_enabled": false,
  "conditional_formatting": {}
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
