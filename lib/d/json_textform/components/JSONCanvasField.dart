import 'package:flutter/material.dart';

import 'package:signature/signature.dart';

import '../models/Schema.dart';

class JSONCanvasField extends StatefulWidget {
  final Schema schema;
  final Function onSaved;
  final bool isOutlined;
  final bool filled;

  JSONCanvasField(
      {@required this.schema,
      this.onSaved,
      this.isOutlined = false,
      Key key,
      @required this.filled})
      : super(key: key);

  @override
  _JSONCanvasFieldState createState() => _JSONCanvasFieldState();
}

class _JSONCanvasFieldState extends State<JSONCanvasField> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

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
  void didUpdateWidget(JSONCanvasField oldWidget) {
    if (oldWidget.schema.value != widget.schema.value) {
      Future.delayed(Duration(milliseconds: 50)).then((value) => init());
    }
    super.didUpdateWidget(oldWidget);
  }

  void init() {
    _controller.addListener(() => print("Value changed"));
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        // see: https://stackoverflow.com/a/57335217
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Text(widget.schema.label),
            //SIGNATURE CANVAS
            Signature(
                controller: _controller,
                height: 300,
                backgroundColor: Colors.grey),
            //OK AND CLEAR BUTTONS
            Container(
                decoration: const BoxDecoration(color: Colors.black),
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  color: Colors.blue,
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                )),
          ],
        ),
      ),
    );
  }
}
