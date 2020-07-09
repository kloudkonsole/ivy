import 'package:flutter/material.dart';
import 'package:ivy/vm/tile_bloc.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  HomeScreen({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final bloc = Provider.of<TileBloc>(ctx);

    var wrap = ReorderableWrap(
      spacing: 8.0,
      runSpacing: 4.0,
      padding: const EdgeInsets.all(8),
      children: bloc.tiles,
      onReorder: (int oldIndex, int newIndex){
        bloc.swap(oldIndex, newIndex);
      },
      onNoReorder: (int index) {
        //this callback is optional
        debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
      },
      onReorderStarted: (int index) {
        //this callback is optional
        debugPrint('${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
      }
    );

    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        wrap,
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              iconSize: 50,
              icon: Icon(Icons.add_circle),
              color: Colors.deepOrange,
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                var newTile = Icon(Icons.filter_9_plus, size: TileBloc.size);
                bloc.add(newTile);
              },
            ),
            IconButton(
              iconSize: 50,
              icon: Icon(Icons.remove_circle),
              color: Colors.teal,
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                bloc.removeAt(0);
              },
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(ctx).pushNamed('/store', arguments: '1');
            },
          ),
        ]
      ),

      body: SingleChildScrollView(
        child: column,
      ),
    );
  }
}