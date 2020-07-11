import 'package:flutter/cupertino.dart';
import './Schema.dart';

abstract class Field<T> {
  /// When this value is null,
  /// then the icon will be for the main schema and all its
  /// forignkey schema's field;
  /// If this field is set, then only the related name's field will be set icon.
  String schemaFor;

  /// If this is true and schemaFor is null, then use the icon/action globally,
  /// otherwise, only main screen will use the icon/action
  bool useGlobally;

  /// Merge with schema
  List<Schema> merge(List<Schema> schemas, Map<String, T> fields, String name);
}

class FieldIcon implements Field<FieldIcon> {
  IconData iconData;

  @override
  String schemaFor;

  @override
  bool useGlobally;

  FieldIcon({this.iconData, this.schemaFor, this.useGlobally = true});

  @override
  List<Schema> merge(
      List<Schema> schemas, Map<String, FieldIcon> fields, String name) {
    return schemas.map((s) {
      if (!fields.containsKey(s.iconName)) return s;
      var f = fields[s.iconName];
      if ((f.schemaFor == null && f.useGlobally) || f.schemaFor == name) {
        s.icon = f;
      } else if ((!f.useGlobally && f.schemaFor == null) &&
          f.schemaFor == null) {
        s.icon = f;
      }
      return s;
    }).toList();
  }
}
