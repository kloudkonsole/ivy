import 'package:flutter/material.dart';

import './SelectionPage.dart';
import '../models/Schema.dart';

typedef void OnChange(Choice choice);

class JSONSelectField extends StatelessWidget {
  final Schema schema;
  final OnChange onSaved;
  final bool showIcon;
  final bool isOutlined;

  /// implementation. Default is false
  final bool useDropdownButton;

  JSONSelectField({
    @required this.schema,
    this.onSaved,
    this.showIcon = true,
    this.isOutlined = false,
    @required this.useDropdownButton,
  });

  @override
  Widget build(BuildContext context) {
    if (useDropdownButton != null && useDropdownButton) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
        child: Row(
          children: <Widget>[
            if (schema.icon != null)
              Icon(
                schema.icon.iconData,
                color: Theme.of(context).iconTheme.color,
              ),
            Spacer(),
            Expanded(
              flex: 9,
              child: DropdownButton(
                hint: Text("Select ${schema.label}"),
                isExpanded: true,
                onChanged: (v) {
                  this.onSaved(v);
                },
                value: schema?.extra?.choices?.firstWhere(
                  (element) => element.value == schema.value,
                  orElse: () => null,
                ),
                items: schema?.extra?.choices
                    ?.map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.label),
                      ),
                    )
                    ?.toList(),
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
      child: Container(
        decoration: isOutlined
            ? BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).inputDecorationTheme.fillColor)
            : null,
        child: ListTile(
          key: Key("selection-field"),
          leading: schema.icon != null
              ? Icon(
                  schema.icon.iconData,
                  color: Theme.of(context).iconTheme.color,
                )
              : null,
          trailing:
              Icon(Icons.expand_more, color: Theme.of(context).iconTheme.color),
          onTap: schema?.extra?.choices == null
              ? null
              : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return SelectionPage(
                          onSelected: (value) {
                            if (this.onSaved != null) {
                              this.onSaved(value);
                            }
                          },
                          title: "Select ${schema.label}",
                          selections: schema.extra.choices,
                          value: schema.value ?? schema.extra.defaultValue,
                        );
                      },
                    ),
                  );
                },
          title: Text("Select ${schema.label}"),
          subtitle: Text(schema.value ?? schema?.extra?.defaultValue ?? ""),
        ),
      ),
    );
  }
}
