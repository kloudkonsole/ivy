import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../models/Action.dart';
import '../models/Schema.dart';

class JSONSearchField extends StatefulWidget {
  final Schema schema;
  final Function onSaved;
  final bool isOutlined;
  final bool filled;

  JSONSearchField(
      {@required this.schema,
      this.onSaved,
      this.isOutlined = false,
      Key key,
      @required this.filled})
      : super(key: key);

  @override
  _JSONSearchFieldState createState() => _JSONSearchFieldState();
}

class _JSONSearchFieldState extends State<JSONSearchField> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(JSONSearchField oldWidget) {
    if (oldWidget.schema.value != widget.schema.value) {
      Future.delayed(Duration(milliseconds: 50)).then((value) => init());
    }
    super.didUpdateWidget(oldWidget);
  }

  void init() {
    String value = widget.schema.value?.toString() ??
        widget.schema.extra?.defaultValue?.toString() ??
        "";

    if (_controller == null) {
      _controller = TextEditingController(text: value);
    } else {
      _controller.text = value;
    }
  }

  String validation(String value) {
    switch (widget.schema.widget) {
      case WidgetType.number:
        final n = num.tryParse(value);
        if (n == null) {
          return '$value is not a valid number';
        }
        break;
      default:
        if ((value == null || value == "") && widget.schema.isRequired) {
          return "This field is required";
        }
    }
  }

  _suffixIconAction({File image, String inputValue}) async {
    switch (widget.schema.action.actionDone) {
      case ActionDone.getInput:
        if (inputValue != null) {
          setState(() {
            _controller.text = inputValue.toString();
          });
        } else if (image != null) {
          var value =
              await (widget.schema.action as FieldAction<File>).onDone(image);
          if (value is String) {
            setState(() {
              _controller.text = value;
            });
          }
        }
        break;

      case ActionDone.getImage:
        if (image != null) {
          await (widget.schema.action as FieldAction<File>).onDone(image);
        }
        break;
    }
  }

  Widget _renderSuffixIcon() {
    if (widget.schema.action != null) {
      switch (widget.schema.action.actionTypes) {
        case ActionTypes.qrScan:
          return IconButton(
            onPressed: () async {
              if (Platform.isAndroid || Platform.isIOS) {
                try {
                  var result = await BarcodeScanner.scan();
                  await _suffixIconAction(inputValue: result.rawContent);
                } on PlatformException catch (e) {
                  print(e);
                } on FormatException {} catch (e) {
                  print("format error: $e");
                }
              } else if (Platform.isMacOS) {
                //TODO: Add macOS support
              }
            },
            icon: Icon(Icons.camera_alt),
          );
          break;
        default:
          break;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: InputDecoration(
                filled: widget.filled,
                helperText: widget.schema.extra?.helpText,
                labelText: widget.schema.label,
                prefixIcon: widget.schema.icon != null
                    ? Icon(widget.schema.icon.iconData)
                    : null,
                suffixIcon: _renderSuffixIcon(),
                border: widget.isOutlined == true
                    ? OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      )
                    : null,
              )),
          suggestionsCallback: (pattern) async {
            return null;
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(suggestion['name']),
              subtitle: Text('\$${suggestion['price']}'),
            );
          },
          onSuggestionSelected: (suggestion) {},
        ),
      ),
    );
  }
}
