// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/hymn.dart';
import '../models/favorites.dart';

class FavoritesPage extends StatelessWidget {
  static const routeName = '/favorites_page';

  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Consumer<Favorites>(
        builder: (context, value, child) => value.items.isNotEmpty
            ? ListView.builder(
                itemCount: value.items.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  //Hymn hymn = offlineFetchedList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.primaries[
                            value.items[index] % Colors.primaries.length],
                      ),
                      title: Text(
                        value.items[index].toString(),
                        //key: Key('favorites_text_$hymn.hymnNumber'),
                      ),
                      trailing: IconButton(
                        //key: Key('remove_icon_$itemNo'),
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          context.read<Favorites>().remove(value.items[index]);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Removed from favorites.'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                })
            : const Center(
                child: Text('No favorites added.'),
              ),
      ),
    );
  }
}
