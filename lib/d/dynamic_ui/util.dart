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
}
