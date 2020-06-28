import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ivy/vm/store_bloc.dart';
import 'package:reorderables/reorderables.dart';

class StoreScreen extends StatelessWidget {
  final String title;

  StoreScreen({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final bloc = Provider.of<StoreBloc>(ctx);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ReorderableWrap(
              spacing: 8.0,
              runSpacing: 4.0,
              padding: const EdgeInsets.all(8),
              children: bloc.getWidgets((String id){
                final app = bloc.getApp(id);
                Navigator.of(ctx).pushNamed('/store/:id', arguments: app);
              }), 
              needsLongPressDraggable: false,
              onReorder: (int oldIndex, int newIndex){
                bloc.swap(oldIndex, newIndex);
              },
            )

          ],
        )
      )
    );
  }
}