import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ivy/d/dynamic_ui/service.dart';
import 'package:ivy/d/dynamic_ui/util.dart';

class Firestore extends Service {
  final Map<String, dynamic> defaultOption;

  Firestore({@required this.defaultOption}) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  }

  void signin() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  @override
  Future<Map<String, dynamic>> query(
      Map<String, dynamic> option, Map<String, dynamic> value) async {
    option ??= {};
    final opt = Util.assign<String>(defaultOption, option);
    final paramTmpl =
        Util.assign<String>(defaultOption['params'], option['params']);
    final List<List<dynamic>> query = option['query'];

    final params = Util.replaceJSON(paramTmpl, value);

    CollectionReference col = FirebaseFirestore.instance.collection(opt['col']);

    query.fold(col, (query, step) {
      switch (step[0]) {
        case 'arrayContainsAny':
          return query.where(step[1], arrayContainsAny: step[2]);
        case 'isGreaterThan':
          return query.where(step[1], isGreaterThan: step[2]);
        case 'limit':
          return query.limit(step[1]);
        case 'limitToLast':
          return query.limitToLast(step[1]);
        case 'orderBy':
          return query.orderBy(step[1], descending: step[2] ?? false);
        case 'startAt':
          return query.startAt(step[1]);
        case 'endAt':
          return query.endAt(step[1]);
        case 'get':
          return query.get();
        case 'add':
          return query.add(params);
        case 'set':
          return query.set(params);
        case 'update':
          return query.update(params);
        case 'delete':
          return query.delete();
      }
    });
  }
}
