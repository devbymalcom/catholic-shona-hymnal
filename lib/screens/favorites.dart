// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/app_routes.dart';
import '../models/favorites.dart';
import '../models/hymn.dart';
import '../providers/api_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Favorites favProvider = Provider.of<Favorites>(context);
    final hymns = favProvider.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: FutureBuilder(
          //future: apiProvider.getHymnsFromApi(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Consumer<Favorites>(builder: (context, value, child) {
          return value.items.isNotEmpty
              ? ListView.builder(
                  itemCount: value.items.length,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (context, index) {
                    Hymn hymn = hymns[index];
                    //Hymn hymn =  DatabaseService().readHymn(value.items[index]);

                    final favoritesList = context.watch<Favorites>();

                    return FavoriteItemTile(
                      hymn: hymn,
                      itemNo: hymn.hymnNumber,
                    );
                  })
              : const Center(
                  child: Text('No favorites added.'),
                );
        });
      }),
    );
  }
}

class FavoriteItemTile extends StatelessWidget {
  final int itemNo;
  final Hymn hymn;

  const FavoriteItemTile({super.key, required this.itemNo, required this.hymn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
          ),
          title: Text(hymn.hymnTitle
              //'Item $itemNo',
              //key: Key('favorites_text_$itemNo'),
              ),
          trailing: IconButton(
            key: Key('remove_icon_$itemNo'),
            icon: const Icon(Icons.close),
            onPressed: () {
              context.read<Favorites>().remove(hymn);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from favorites.'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ), //
          onTap: (() {
            Navigator.pushNamed(context, AppRoutes.details, arguments: hymn);
          })
          //

          ),
    );
  }
}
