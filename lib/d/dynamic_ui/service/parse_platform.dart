import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:ivy/d/dynamic_ui/service.dart';

import '../util.dart';

class CustomObject extends ParseObject implements ParseCloneable {
  CustomObject(String className) : super(className);
  CustomObject.clone(String className) : this(className);

  @override
  CustomObject clone(Map<String, dynamic> map) =>
      CustomObject.clone(parseClassName)..fromJson(map);

  Map<String, dynamic> getObjectData() {
    return toJson();
  }
}

class ParsePlatform extends Service {
  final Map<String, dynamic> defaultOption;
  ParseUser _user;

  ParsePlatform({@required this.defaultOption}) {
    init(this.defaultOption);
  }

  void init(Map<String, dynamic> option) async {
    await Parse()
        .initialize(option['keyApplicationId'], option['keyParseServerUrl'],
            masterKey: option['masterKey'], // Required for Back4App and others
            clientKey: option['clientKey'], // Required for some setups
            debug: true, // When enabled, prints logs to console
            autoSendSessionId: true, // Required for authentication and ACL
            coreStore: await CoreStoreSharedPrefsImp.getInstance());
    _user = await ParseUser.currentUser();
    if (null == _user) {
      _user = ParseUser.forQuery();
      await _user.loginAnonymous();
    }
  }

  @override
  Future<Map<String, dynamic>> query(
      dynamic req, Map<String, dynamic> value) async {
    final options = Util.cast<List<dynamic>>(req, []);

    CustomObject pObject;
    QueryBuilder pQuery;
    ParseResponse res;
    for (List<dynamic> op in options) {
      switch (op[0]) {
        case 'objectName':
          pObject = CustomObject(op[1]);
          break;
        case 'set':
          pObject.set(op[1], Util.replaceText(op[2], value));
          break;
        case 'save':
          res = await pObject.save();
          break;
        case 'queryBuilder':
          pObject = CustomObject(op[1]);
          pQuery = QueryBuilder<CustomObject>(pObject);
          break;
        case 'Contains':
          pQuery.whereContains(op[1], Util.replaceText(op[2], value));
          break;
        case 'query':
          res = await pQuery.query();
          break;
      }
    }

    return {
      'code': res.success ? 0 : 1,
      'body': res.results.map((e) => (e as CustomObject).getObjectData())
    };
  }
}
