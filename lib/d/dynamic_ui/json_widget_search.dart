import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import 'package:ivy/d/dynamic_ui/json_widget_controller.dart';

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

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller.fields.add(_ctrl);
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
    final attr = Util.cast<Map<String, dynamic>>(widget.schema[1]);
    final label = Util.cast<String>(attr['lbl'], 'LABEL');
    final type = Util.cast<String>(attr['type'], 'text');
    final mandatory = Util.cast<bool>(attr['required'], false);

    _ctrl.text = widget.controller.readString(attr['id']);

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
        widget.controller.save(attr['id'], value);
        return value;
      },
      suggestionsCallback: (pattern) async {
        //return await BackendService.getSuggestions(pattern);
        return [
          {'icon': 'shopping_cart', 'name': 'world', 'price': '3.4'},
          {'name': 'hello', 'price': '10.0'},
        ];
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: Icon(Util.icon(suggestion['icon'] ?? '')),
          title: Text(suggestion['name']),
          subtitle: Text('\$${suggestion['price']}'),
        );
      },
      onSuggestionSelected: (suggestion) {
        _ctrl.text = suggestion['name'];
      },
    );
  }
}
