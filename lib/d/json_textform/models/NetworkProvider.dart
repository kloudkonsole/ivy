import 'package:flutter/material.dart';

import '../utils.dart';

class NetworkProvider with ChangeNotifier {
  String url;
  GlobalKey<ScaffoldState> key = GlobalKey();

  NetworkProvider({
    this.url,
  });

  String _preProcessURL(String path) {
    String p = "$path/".replaceFirst("-", "_");
    String url = getURL(this.url, p);
    return url;
  }

  /// Get schema
  // Future<List<Map<String, dynamic>>> getEditSchema(String path) async {
  //   try {
  //     String u = _preProcessURL(path);
  //     Response response =
  //         await networkProvider.request(u, options: Options(method: "OPTIONS"));
  //     if ((response.data as Map).containsKey("fields"))
  //       return (response.data['fields'] as List)
  //           .map((d) => d as Map<String, dynamic>)
  //           .toList();
  //   } on DioError catch (e) {
  //     _showSnackBar(e.message);
  //   }
  //   return null;
  // }

  /// show error message
  void _showSnackBar(String message) {
    key.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
