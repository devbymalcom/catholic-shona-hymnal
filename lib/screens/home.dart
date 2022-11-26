// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:catholic_hymnal/common/navigation_drawer.dart';
import 'package:catholic_hymnal/models/hymn.dart';
import 'package:catholic_hymnal/models/favorites.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/api_provider.dart';
import 'favorites.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Testing Sample'),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, FavoritesPage.routeName);
            },
            icon: const Icon(Icons.favorite_border),
            label: const Text('Favorites'),
          ),
        ],
      ),
      body: FutureBuilder(
          future: apiProvider.getHymnsFromApi(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: offlineFetchedList.length,
                  cacheExtent: 20.0,
                  controller: ScrollController(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (context, index) {
                    Hymn hymn = offlineFetchedList[index];
                    final favoritesList = context.watch<Favorites>();

                    /** */
                    // if (favoritesList.items
                    //     .contains(offlineFetchedList.indexOf(hymn))) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Colors.primaries[index % Colors.primaries.length],
                        ),
                        title: Text(
                          hymn.hymnTitle,
                          //'Item $itemNo',
                          key: Key('text_$index'),
                        ),
                        trailing: IconButton(
                          key: Key('icon_$index'),
                          icon: favoritesList.items.contains(index)
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border),
                          onPressed: () {
                            !favoritesList.items.contains(index)
                                ? favoritesList.add(index)
                                : favoritesList.remove(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    favoritesList.items.contains(index)
                                        ? 'Added to favorites.'
                                        : 'Removed from favorites.'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  // return Container(
                  //   child: Text(';'),
                  // );
                  /** */

                  // return ItemTile(
                  //   index,
                  //   hymn: hymn,
                  // );
                  //}
                  );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}

// class ItemTile extends StatelessWidget {
//   final int itemNo;
//   final Hymn hymn;

//   const ItemTile(this.itemNo, {super.key, required this.hymn});

//   @override
//   Widget build(BuildContext context) {
//     final favoritesList = context.watch<Favorites>();

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
//         ),
//         title: Text(
//           hymn.hymnTitle,
//           //'Item $itemNo',
//           key: Key('text_$itemNo'),
//         ),
//         trailing: IconButton(
//           key: Key('icon_$itemNo'),
//           icon: favoritesList.items.contains(itemNo)
//               ? const Icon(Icons.favorite)
//               : const Icon(Icons.favorite_border),
//           onPressed: () {
//             !favoritesList.items.contains(itemNo)
//                 ? favoritesList.add(itemNo)
//                 : favoritesList.remove(itemNo);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(favoritesList.items.contains(itemNo)
//                     ? 'Added to favorites.'
//                     : 'Removed from favorites.'),
//                 duration: const Duration(seconds: 1),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
