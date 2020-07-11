import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './JSONForm.dart';
import './models/Action.dart';
import './models/Controller.dart';
import './models/Icon.dart';
import './models/NetworkProvider.dart';

/// A JSON Schema Form Widget
/// Which will take a schema input
/// and generate a form
class JSONSchemaForm extends StatelessWidget {
  /// Text form is filled
  final bool filled;

  /// schema controller
  final JSONSchemaController controller;

  /// Fetching choices for forign key selections
  final OnFetchForignKeyChoices onFetchingForignKeyChoices;

  /// Update forign key's value
  final OnUpdateForignKeyField onUpdateForignKeyField;

  /// Add new forign key
  final OnAddForignKeyField onAddForignKeyField;

  // Fetching forign key's schema
  final OnFetchingSchema onFetchingSchema;

  /// Schema's name
  /// Use this to identify the actions and icons
  /// if forignkey text field has the same name as the home screen's field.
  /// Default is null
  final String schemaName;

  /// Schema you want to have. This is a JSON object
  /// Using dart's map data structure
  final List<Map<String, dynamic>> schema;

  /// List of actions. Each field will only have one action.
  /// If not, the last one will replace the first one.
  final List<FieldAction> actions;

  /// List of icons. Each field will only have one icon.
  /// If not, the last one will replace the first one.
  final List<FieldIcon> icons;

  /// Default values for each field
  final Map<String, dynamic> values;

  /// Will call this function after user
  /// clicked the submit button
  final OnSubmit onSubmit;

  /// URL for forignkey
  /// Forignkey field will use this to get editing data
  /// Default is http://0.0.0.0
  final String url;

  /// Round corner of text field
  final bool rounded;

  /// Whether show submit button
  final bool showSubmitButton;

  /// Whether use dropdown button instead of using
  /// another page to show choices.
  /// This will only apply for the select field,
  /// but not forign key field based on current
  /// implementation. Default is false
  final bool useDropdownButton;

  JSONSchemaForm({
    @required this.schema,
    this.filled = false,
    this.onSubmit,
    this.icons,
    this.actions,
    this.values,
    this.rounded = false,
    this.schemaName,
    this.controller,
    this.url = "http://0.0.0.0",
    this.showSubmitButton = true,
    this.useDropdownButton = false,
    @required this.onFetchingSchema,
    @required this.onFetchingForignKeyChoices,
    @required this.onAddForignKeyField,
    @required this.onUpdateForignKeyField,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NetworkProvider>(
          create: (_) => NetworkProvider(
            url: url,
          ),
        )
      ],
      child: JSONForm(
        filled: filled,
        schema: schema,
        schemaName: schemaName,
        onSubmit: onSubmit,
        icons: icons,
        actions: actions,
        values: values,
        rounded: rounded,
        controller: controller,
        showSubmitButton: showSubmitButton,
        useDropdownButton: useDropdownButton,
        onFetchingSchema: onFetchingSchema,
        onFetchForignKeyChoices: onFetchingForignKeyChoices,
        onAddForignKeyField: onAddForignKeyField,
        onUpdateForignKeyField: onUpdateForignKeyField,
      ),
    );
  }
}
