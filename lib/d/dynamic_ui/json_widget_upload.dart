import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import './json_widget_controller.dart';
import './util.dart';

class UploadFormField extends FormField<String> {
  static const String defaultImg =
      'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHQAAAB0CAMAAABjROYVAAAAaVBMVEX///8AAADm5ubBwcHFxcX4+Pjd3d12dnZWVlb8/Px6enqpqanx8fGHh4fp6el+fn5tbW1dXV1oaGienp7W1tbMzMwPDw88PDy3t7diYmI1NTUbGxtRUVEmJiYhISGXl5dDQ0MtLS2Pj49bWjB6AAAEiklEQVRoge1b24KiMAylKCiCIHIRHa/z/x+5zChNeklx28I+rOeR2h7SNulJikHwwQf/ElkYZnNzVg/Gvm7zcu7YL9Zzcm7YC/toNs6CceySmTh3DKGch3PPBKxnsDXZMAm76dd1JXP2u2lqzr3KObXnJDsdJ2PHCWc40czt5OtK2Plr61ScR5pzqnWl5/aJSSJiYeZkbOWfsx7jZKzxTnrDM8m99Yz31sY7KZrdfcRDYZmhqOg/9qd87HUEsbCP9rCnv72Txu1r6GOCAnD/AuC9tXfSwdTVj2cIpMO5U/nnDILFoW0vt19vFEiDpHq07ambgrNHXL8CgEgaBFE9wdTKkElnwYf0Q/ohBSRxXTdLjCZ+lzQWOy7rOn4nAYi36y8moy3ErgRpUrRK16/zdoy3KZVeT4hnJUF6JjqvTZoiM2hMIZ7rSTu69z4nzTzRvdh2nNQk3U6EsWbptcM/5RoFkybaPIdDyzoi9wRLt8PTlfapHprTLzv8RZdY+/ojr31QS0BKrmswlAtS6emIqYpENb9lm8q/7y69CypPU+MoygRj/7xXy1iAdr8n2giYiz2b6o4GloRxjppSr0E8wdaLb19Bg3dVh2KGqFIhFE1Q7wOLBGfPLsNjzb52RsbX9YFHhyXdkl0dAK6EFzWcbkV/AHsp1JIufJD0KqCu0fgLD6RRne4P1x6nMq3VPVC9RAAcLO6k2U04q+/fUuhAB9ywVq6kyTdTsMXRpEENl9wL6VKlxCYFUoGr80CqM/OJghuLY+0QgZxIDRKKx3KhrObBUqMcGcp0WJ21sTPpm0c0erUhjtuTLtgIXnOZbV6K+5qqXf+SNHsIDF9lUZRX4dF1cNh68YMl+K81qTC529dihcJ2JiuStqQZGvyM8qkQ6xxKxtuSImlRikkT8iNKAFiSRuDzBzkHg1D8INSVJSn8oJVz1SCE1FJpcyKFY7hQG2E3EeVBS1LQ/xpjoPdObXQg5WFGt2yw4MSVhR1pxDeL9l6Nz8NdryXtSEFEapYULSohYF0t1V4OTEMK+ZX2ihYuL/SOakkKYUdjS8QdlbhJtSSFcK9R4yCctCtuTQrjntX5hZhP5Ae2sZf/QI06KAElsi/bUwadJUuxpYHS3JGox9mSYrEisNaoHEhlX9bK4YJYCz6NGZYOLdXXmlTQ9u2qicMwbsSqJ5lm2qtBSWm3l4dUZ6UvFe1J8wszog3Jrg5iO9ZRAQw1XZe0gkjZnjDVDZwSqIVaaB/m1lircMtPw7uOsdcT5ktF10z8pl4NjNeBnGsO4VbaxdcVITw9kva+k6JKxz2lPeVtUqWEq0fdpVVVdW9+TqEvXkGZzv8HEgFWzTjFyvjlyJW8QLFHyPPYk3Dgwhc4hOJwAZSzxAwWnf7ev8tAp5+4Y5AcYZs39uP7yPG9lKRQcdN1ky48IS2Ew196oZDNAGUKb+N9XKFWByLq5tQbSk3OkT+m5bxoI4BUnpqFs7fV+GGgG0oy0iXVeG873ExXaeFIqdMOxVi4SboNoUnscFh1b33qnOWhN+Sz/0Pgg/8HfwDOxjcTBKggRAAAAABJRU5ErkJggg==';

  UploadFormField(
      {Key key,
      FormFieldSetter<String> onSaved,
      FormFieldValidator<String> validator,
      InputDecoration decoration = const InputDecoration(),
      String initialValue = '',
      String defaultValue = defaultImg,
      double height = 40,
      BoxFit fit = BoxFit.fitWidth,
      bool readonly = false,
      bool autovalidate = false})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<String> state) {
              String value = initialValue ?? defaultValue;
              Image image;
              if (value.contains('data:image/')) {
                image = Image.memory(base64Decode(value.split(',')[1]),
                    height: height, fit: fit);
              } else {
                image = Image.network(value, height: height, fit: fit);
              }

              return InputDecorator(
                  decoration: decoration.copyWith(
                      enabled: !readonly, errorText: state.errorText),
                  child: image);
            });
}

class JSONWidgetUpload extends StatefulWidget {
  final List<dynamic> schema;
  final Map<String, dynamic> attr;
  final String id;
  final String label;
  final String value;
  final bool mandatory;

  JSONWidgetUpload._({@required this.schema, @required this.attr})
      : id = Util.cast<String>(attr['id'], 'ID'),
        label = Util.cast<String>(attr['lbl'], 'LABEL'),
        value = Util.cast<String>(attr['value'], null),
        mandatory = Util.cast<bool>(attr['required'], false);

  JSONWidgetUpload(schema)
      : this._(
            schema: schema, attr: Util.cast<Map<String, dynamic>>(schema[1]));

  @override
  _JSONWidgetUploadState createState() => _JSONWidgetUploadState();
}

class _JSONWidgetUploadState extends State<JSONWidgetUpload> {
  ValueNotifier<String> notifier;
  JSONWidgetController ctrl;

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
          return UploadFormField(
            key: Key(value),
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
