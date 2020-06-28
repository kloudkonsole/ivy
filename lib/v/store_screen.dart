import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ivy/vm/store_bloc.dart';
import 'package:reorderables/reorderables.dart';

class StoreScreen extends StatelessWidget {
  final String id;

  StoreScreen({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final bloc = Provider.of<StoreBloc>(ctx);

    return Scaffold(
      appBar: AppBar(
        title: Text(id),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ReorderableWrap(
              spacing: 8.0,
              runSpacing: 4.0,
              padding: const EdgeInsets.all(8),
              children: bloc.getApps((String id){
                Navigator.of(ctx).pushNamed('/store/:id', arguments: id);
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