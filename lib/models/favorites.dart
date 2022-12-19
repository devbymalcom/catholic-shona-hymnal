// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hymn.dart';

/// The [Favorites] class holds a list of favorite items saved by the user.
class Favorites extends ChangeNotifier {
  List<Hymn> _favoriteItems = [];

  List<Hymn> get items => _favoriteItems;

  void add(Hymn hymn) {
    _favoriteItems.add(hymn);
    storeList(_favoriteItems);
    notifyListeners();
  }

  void remove(Hymn hymn) {
    _favoriteItems.remove(hymn);
    storeList(_favoriteItems);
    notifyListeners();
  }

  // storeList(List<Hymn> list) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> stringsList = _favoriteItems.map((i) => i.toString()).toList();
  //   await prefs.setStringList("stringList", stringsList);
  //   notifyListeners();
  // }

  storeList(List<Hymn> hymns) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
        hymns.map<Map<String, dynamic>>((hymn) => Hymn.toJSON(hymn)).toList());

    await prefs.setString('stringList', encodedData);

    //
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // List<String> hymnsEncoded =
    //     hymns.map((hymn) => jsonEncode(hymn.toMap())).toList();
    // await sharedPreferences.setStringList('stringList', hymnsEncoded);
    notifyListeners();
  }

  initialize() async {
    // Fetch and decode data
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? musicsStrin = await prefs.getString('stringList');

    if (musicsStrin != null) {
      final List<Hymn> musics = Hymn.decode(musicsStrin);
      _favoriteItems = musics;
    }

    ///
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // List<dynamic> mList = sharedPreferences.getStringList('stringList') ?? [];
    // List<Hymn> mOriginaList = mList.map((hymn) => Hymn.fromMap(hymn)).toList();
    // _favoriteItems = mOriginaList;
    print(_favoriteItems);
    notifyListeners();
  }

  // initialize() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> mList = (prefs.getStringList('stringList') ?? []);
  //   List<int> mOriginaList = mList.map((i) => int.parse(i)).toList();
  //   _favoriteItems = mOriginaList.cast<Hymn>();
  //   print(_favoriteItems);
  //   notifyListeners();
  // }
}

/* Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/database_services.dart';
import 'hymn.dart';

/// The [Favorites] class holds a list of favorite items saved by the user.
class Favorites extends ChangeNotifier {
  List<int> _favoriteItems = [];

  List<int> get items => _favoriteItems;

  Future<List<Hymn>> getFavHymns(BuildContext context) async {
    favoritesList.removeRange(0, favoritesList.length);

    if (_favoriteItems.isNotEmpty) {
      //List<dynamic> val = _favoriteItems;

      List<Hymn> hymnList = [];
      for (var u in _favoriteItems) {
        Hymn hymn = await DatabaseService().readHymn(u);
        hymnList.add(hymn);
      }
      favoritesList = hymnList;
    }
    return favoritesList;
  }

  void add(int hymnNo) {
    _favoriteItems.add(hymnNo);
    storeList(_favoriteItems);
    notifyListeners();
  }

  void remove(int hymnNo) {
    _favoriteItems.remove(hymnNo);
    storeList(_favoriteItems);
    notifyListeners();
  }

  storeList(List<int> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringsList = _favoriteItems.map((i) => i.toString()).toList();
    await prefs.setStringList("stringList", stringsList);
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mList = (prefs.getStringList('stringList') ?? []);
    List<int> mOriginaList = mList.map((i) => int.parse(i)).toList();
    _favoriteItems = mOriginaList;
    print(_favoriteItems);
    notifyListeners();
  }
}
 */
