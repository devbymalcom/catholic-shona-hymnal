import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../models/hymn.dart';
import 'database_services.dart';

class ApiProvider extends ChangeNotifier {
  Future<List<Hymn>> getHymnsFromApi(BuildContext context) async {
    offlineFetchedList.removeRange(0, offlineFetchedList.length);

    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/shona_hymnal.json');
    final body = json.decode(data);

    if (body.toString().isNotEmpty) {
      List<dynamic> val = body as List;
      List<Hymn> hymnList = [];
      for (var u in val) {
        hymnList.add(Hymn.fromMap(u));
      }
      offlineFetchedList = hymnList;
      DatabaseService().createHymnalList(hymnList);
    }
    return offlineFetchedList;
  }

  // void toggleHymn(Hymn hymn) async {
  //   await DatabaseService().updateHymn(hymn);
  //   notifyListeners();
}
