import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import 'json_widget_controller.dart';
import 'util.dart';

class CanvasFormField extends FormField<String> {
  CanvasFormField(
      {Key key,
      SignatureController controller,
      FormFieldSetter<String> onSaved,
      FormFieldValidator<String> validator,
      InputDecoration decoration = const InputDecoration(),
      String initialValue = '',
      bool readonly = false,
      Color backgroundColor = Colors.white,
      bool autovalidate = false})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: decoration.copyWith(
                    enabled: !readonly, errorText: state.errorText),
                child: Signature(
                  controller: controller,
                  height: 300,
                  backgroundColor: backgroundColor,
                ),
              );
            });
}

class JSONWidgetCanvas extends StatefulWidget {
  final List<dynamic> schema;
  final Map<String, dynamic> attr;
  final String id;
  final String label;
  final String value;
  final bool mandatory;

  JSONWidgetCanvas._({@required this.schema, @required this.attr})
      : id = Util.cast<String>(attr['id'], 'ID'),
        label = Util.cast<String>(attr['lbl'], 'LABEL'),
        value = Util.cast<String>(attr['value'], null),
        mandatory = Util.cast<bool>(attr['required'], false);

  JSONWidgetCanvas(schema)
      : this._(
            schema: schema, attr: Util.cast<Map<String, dynamic>>(schema[1]));

  @override
  _JSONWidgetCanvasState createState() => _JSONWidgetCanvasState();
}

class _JSONWidgetCanvasState extends State<JSONWidgetCanvas> {
  ValueNotifier<String> notifier;
  JSONWidgetController ctrl;
  final SignatureController _canvasCtrl = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  @override
  void initState() {
    super.initState();

    ctrl = Provider.of<JSONWidgetController>(context, listen: false);
    notifier = ctrl.setValue(widget.id, widget.value);
  }

  @override
  Widget build(BuildContext ctx) {
    return ValueListenableBuilder<String>(
        valueListenable: notifier,
        builder: (BuildContext context, String value, Widget child) {
          return CanvasFormField(
            key: Key(value),
            controller: _canvasCtrl,
            initialValue: value,
            decoration: InputDecoration(
                labelText: widget.label + (widget.mandatory ? '*' : '')),
            validator: (String value) {
              if (widget.mandatory && value.isEmpty)
                return '${widget.label} is required';
              return null;
            },
            onSaved: (String value) {
              ctrl.setValue(widget.id, value);
              return value;
            },
          );
        });
  }
}
