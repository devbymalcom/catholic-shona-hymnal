// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The [Favorites] class holds a list of favorite items saved by the user.
class Favorites extends ChangeNotifier {
  List<int> _favoriteItems = [];

  List<int> get items => _favoriteItems;

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
    List<String> mList = await (prefs.getStringList('stringList') ?? []);
    List<int> mOriginaList = mList.map((i) => int.parse(i)).toList();
    _favoriteItems = mOriginaList;
    print(_favoriteItems);
    notifyListeners();
  }
}
