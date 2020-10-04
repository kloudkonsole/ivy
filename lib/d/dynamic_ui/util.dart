import 'package:flutter/material.dart';
import 'package:icons_helper/icons_helper.dart';

class Util {
  // ignore: avoid_init_to_null
  static T cast<T>(x, [d = null]) => x is T ? x : d;

  static T str2enum<T>(Iterable<T> values, String name) {
    return values.firstWhere(
        (f) =>
            "${f.toString().substring(f.toString().indexOf('.') + 1)}"
                .toString() ==
            name,
        orElse: () => null);
  }

  static IconData icon(name) {
    return getIconUsingPrefix(name: name);
  }

  static dynamic replaceText(String key, Map<String, dynamic> map) {
    if ('@' == key.substring(0, 1)) {
      String mapKey = key.substring(1);
      if (map.containsKey(mapKey)) return map[mapKey];
    }
    return key;
  }

  static Map<String, dynamic> replaceJSON(
      Map<String, String> json, Map<String, dynamic> map) {
    Map<String, dynamic> ret = {};
    json.forEach((key, value) {
      ret[key] = Util.replaceText(value, map);
    });
    return ret;
  }

  static Map<String, T> extractType<T>(Map<String, dynamic> map) {
    Map<String, T> ret = {};
    map.forEach((key, value) {
      if (value is T) ret[key] = cast<T>(value);
    });
    return ret;
  }

  static Map<String, T> assign<T>(
      Map<String, dynamic> to, Map<String, dynamic> from) {
    final Map<String, T> clone = Map.from(Util.extractType<T>(to ?? {}));
    clone.addAll(Util.extractType<T>(from ?? {}));
    return clone;
  }
}
