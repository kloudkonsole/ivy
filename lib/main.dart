import 'package:flutter/material.dart';
import 'package:ivy/v/home_screen.dart';
import 'package:ivy/v/app_screen.dart';
import 'package:ivy/v/store_screen.dart';
import 'package:ivy/v/cfg_screen.dart';
import 'package:ivy/v/err_screen.dart';
import 'package:ivy/vm/store_bloc.dart';
import 'package:ivy/vm/tile_bloc.dart';
import 'package:provider/provider.dart';

main() => runApp(Ivy());

class RouteGenerator{

  static Route<dynamic> _errorRoute(code){
    return MaterialPageRoute(builder: (_) => ErrScreen(code: code));
  }
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/':
      case '/apps':
        return MaterialPageRoute(builder: (_) => HomeScreen(title: 'Ivy'));
      case '/store':
        return MaterialPageRoute(builder: (_) => StoreScreen(id: 'Ivy'));
        break;
      case '/store/:id':
        return MaterialPageRoute(builder: (_) => CfgScreen(id: 'Ivy'));
        break;
      case '/apps/:id':
        if (args is String){
          return MaterialPageRoute(builder: (_) => AppScreen(id: args));
        }
        return _errorRoute('Wrong Type: ' + args);
      default:
        return _errorRoute('Notfound: ' + settings.name);
    }
  }
}

class Ivy extends StatelessWidget{
  final String title = 'Ivy';

  @override
  Widget build(BuildContext ctx){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StoreBloc>(create: (_) => StoreBloc()),
        ChangeNotifierProvider<TileBloc>(create: (_) => TileBloc())
      ],
      child: MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.brown),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false
      ),
    );
  }
}
/*
Navigator.of(ctx).pushNamed(
  '/apps/:id',
  arguments: 1
);
*/