import './Icon.dart';
import './Schema.dart';

/// Actions type
enum ActionTypes { image, qrScan }

/// Actions when the action is finished
enum ActionDone {
  /// get input from the action
  /// And use the input to fill the field
  getInput,

  /// get image from the action
  /// and use the image to fill the field
  getImage,
}

typedef OnDone<T> = Future<dynamic> Function(T value);

/// Field Action class for each json field
class FieldAction<T> implements Field<FieldAction> {
  ActionTypes actionTypes;
  ActionDone actionDone;
  final OnDone<T> onDone;

  @override
  String schemaFor;

  @override
  bool useGlobally;

  FieldAction(
      {this.actionDone,
      this.actionTypes,
      this.onDone,
      this.useGlobally = true,
      this.schemaFor});

  @override
  List<Schema> merge(
      List<Schema> schemas, Map<String, FieldAction> fields, String name) {
    return schemas.map((s) {
      if (!fields.containsKey(s.actionName)) return s;
      var f = fields[s.actionName];
      if ((f.schemaFor == null && f.useGlobally) || f.schemaFor == name) {
        s.action = f;
      } else if ((!f.useGlobally && f.schemaFor == null) &&
          f.schemaFor == null) {
        s.action = f;
      }
      return s;
    }).toList();
  }
}
