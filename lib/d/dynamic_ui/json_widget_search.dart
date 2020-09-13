import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ivy/d/dynamic_ui/json_stateful_widget.dart';

import 'package:ivy/d/dynamic_ui/json_widget_controller.dart';

import './network.dart';
import './util.dart';

class JSONWidgetSearch extends StatefulWidget
    implements JSONStatefulWidget<String> {
  final List<dynamic> schema;
  final Map<String, dynamic> attr;
  final String id;
  final String label;
  final String type;
  final bool mandatory;
  final JSONWidgetController controller;
  final TextEditingController _ctrl = TextEditingController();

  JSONWidgetSearch._(
      {@required this.schema, @required this.controller, @required this.attr})
      : id = Util.cast<String>(attr['id'], 'ID'),
        label = Util.cast<String>(attr['lbl'], 'LABEL'),
        type = Util.cast<String>(attr['type'], 'text'),
        mandatory = Util.cast<bool>(attr['required'], false) {
    if (controller != null) {
      controller.addWidget(id, this);
    }
  }

  JSONWidgetSearch(schema, controller)
      : this._(
            schema: schema,
            controller: controller,
            attr: Util.cast<Map<String, dynamic>>(schema[1]));

  @override
  _JSONWidgetSearchState createState() => _JSONWidgetSearchState();

  @override
  void setValue(String value) {
    _ctrl.text = value;
  }

  @override
  void clearValue() {
    _ctrl.text = '';
  }
}

class _JSONWidgetSearchState extends State<JSONWidgetSearch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    widget._ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    widget._ctrl.text = widget.controller.readString(widget.id);

    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget._ctrl,
        decoration: InputDecoration(
            labelText: widget.label + (widget.mandatory ? '*' : '')),
        keyboardType:
            Util.str2enum<TextInputType>(TextInputType.values, widget.type),
        textInputAction: TextInputAction.search,
      ),
      validator: (String value) {
        if (widget.mandatory && value.isEmpty)
          return '${widget.label} is required';
        return null;
      },
      onSaved: (String value) {
        widget.controller.save(widget.id, value);
        return value;
      },
      suggestionsCallback: (pattern) async {
        final Map<String, dynamic> ret =
            await Network.instance.query(widget.attr['tip'], {'ref': pattern});
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
