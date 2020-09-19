import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import './json_widget_controller.dart';
import './network.dart';
import './util.dart';

class JSONWidgetSearch extends StatefulWidget {
  final List<dynamic> schema;
  final Map<String, dynamic> attr;
  final String id;
  final String label;
  final String type;
  final bool mandatory;

  JSONWidgetSearch._({@required this.schema, @required this.attr})
      : id = Util.cast<String>(attr['id'], 'ID'),
        label = Util.cast<String>(attr['lbl'], 'LABEL'),
        type = Util.cast<String>(attr['type'], 'text'),
        mandatory = Util.cast<bool>(attr['required'], false);

  JSONWidgetSearch(schema)
      : this._(
            schema: schema, attr: Util.cast<Map<String, dynamic>>(schema[1]));

  @override
  _JSONWidgetSearchState createState() => _JSONWidgetSearchState();
}

class _JSONWidgetSearchState extends State<JSONWidgetSearch> {
  ValueNotifier<String> notifier;
  JSONWidgetController ctrl;

  @override
  void initState() {
    super.initState();

    ctrl = Provider.of<JSONWidgetController>(context, listen: false);
    notifier = ctrl.setValue(widget.id, widget.attr['value']);
  }

  @override
  Widget build(BuildContext ctx) {
    return ValueListenableBuilder<String>(
        valueListenable: notifier,
        builder: (BuildContext context, String value, Widget child) {
          return TypeAheadFormField(
            key: Key(value),
            initialValue: value,
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                  labelText: widget.label + (widget.mandatory ? '*' : '')),
              keyboardType: Util.str2enum<TextInputType>(
                  TextInputType.values, widget.type),
              textInputAction: TextInputAction.search,
            ),
            validator: (String value) {
              if (widget.mandatory && value.isEmpty)
                return '${widget.label} is required';
              return null;
            },
            onSaved: (String value) {
              ctrl.setValue(widget.id, value);
              return value;
            },
            suggestionsCallback: (pattern) async {
              final Map<String, dynamic> ret = await Network.instance
                  .query(widget.attr['tip'], {'ref': pattern});
              if (ret['code'] != 0) return [];
              return List.from(ret['body'] ?? []);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading:
                    Icon(Util.icon(1 == suggestion['fav'] ? 'favorite' : '')),
                title: Text(suggestion['ref']),
                subtitle: Text('${suggestion['id']} SKU[${suggestion['sku']}]'),
              );
            },
            onSuggestionSelected: (suggestion) {
              ctrl.reload(suggestion);
            },
          );
        });
  }
}
