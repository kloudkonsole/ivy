import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:ivy/d/dynamic_ui/json_widget_controller.dart';

import './network.dart';
import './util.dart';

class JSONWidgetSearch extends StatefulWidget {
  final List<dynamic> schema;
  final JSONWidgetController controller;

  JSONWidgetSearch({Key key, @required this.schema, @required this.controller})
      : super(key: key);

  @override
  _JSONWidgetSearchState createState() => _JSONWidgetSearchState();
}

class _JSONWidgetSearchState extends State<JSONWidgetSearch> {
  final TextEditingController _ctrl = TextEditingController();
  Map<String, dynamic> attr = {};
  String id = '';
  String label = '';
  String type = '';
  bool mandatory = true;

  @override
  void initState() {
    super.initState();

    attr = Util.cast<Map<String, dynamic>>(widget.schema[1]);
    id = Util.cast<String>(attr['id'], 'ID');
    label = Util.cast<String>(attr['lbl'], 'LABEL');
    type = Util.cast<String>(attr['type'], 'text');
    mandatory = Util.cast<bool>(attr['required'], false);

    if (widget.controller != null) {
      widget.controller.addField(id, _ctrl);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    _ctrl.text = widget.controller.readString(id);

    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _ctrl,
        decoration: InputDecoration(labelText: label + (mandatory ? '*' : '')),
        keyboardType: Util.str2enum<TextInputType>(TextInputType.values, type),
        textInputAction: TextInputAction.search,
      ),
      validator: (String value) {
        if (mandatory && value.isEmpty) return '$label is required';
        return null;
      },
      onSaved: (String value) {
        widget.controller.save(id, value);
        return value;
      },
      suggestionsCallback: (pattern) async {
        final Map<String, dynamic> ret =
            await Network.instance.query(attr['tip'], {'ref': pattern});
        if (ret['code'] != 0) return [];
        return List.from(ret['body'] ?? []);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: Icon(Util.icon(1 == suggestion['fav'] ? 'favorite' : '')),
          title: Text(suggestion['ref']),
          subtitle: Text('${suggestion['id']} SKU[${suggestion['sku']}]'),
        );
      },
      onSuggestionSelected: (suggestion) {
        widget.controller.reload(suggestion);
      },
    );
  }
}
