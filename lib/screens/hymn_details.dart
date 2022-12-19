// A Widget that accepts the necessary arguments via the
// constructor.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorites.dart';
import '../models/hymn.dart';

class HymnDetails extends StatelessWidget {
  final Hymn hymn;

  const HymnDetails({super.key, required this.hymn});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //final favoritesList = context.watch<Favorites>();
      appBar: AppBar(
        title: Text(hymn.hymnTitle),
        actions: [
          Builder(builder: (context) {
            final favoritesList = context.watch<Favorites>();
            return IconButton(
              icon: favoritesList.items.contains(hymn)
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              onPressed: () {
                !favoritesList.items.contains(hymn)
                    ? favoritesList.add(hymn)
                    : favoritesList.remove(hymn);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(favoritesList.items.contains(hymn)
                        ? 'Added to favorites.'
                        : 'Removed from favorites.'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            );
          })
        ],
      ),
      body: Center(
        child: Text(hymn.hymnLyrics),
      ),
    );
  }
}

// Scaffold(
//       appBar: AppBar(
//         //backgroundColor: lightColorScheme.primary,
//         leading: IconButton(
//             //color: lightColorScheme.onSecondary,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back)),
//         actions: [
//           IconButton(
//               //color: lightColorScheme.onSecondary,
//               onPressed: () {},
//               icon: const Icon(Icons.bookmark_border)),
//           IconButton(
//             //color: lightColorScheme.onSecondary,
//             icon: const Icon(
//               Icons.more_vert,
//             ),
//             onPressed: () {
//               showModalBottomSheet(
//                   isScrollControlled: true,
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(20),
//                           topLeft: Radius.circular(20))),
//                   context: context,
//                   builder: (context) {
//                     return Wrap(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(16.0, 32, 16, 32),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Hymn Details',
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 const Text(
//                                   'Hymn Number',
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   hymn.hymnNumber.toString(),
//                                   style: const TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 const Text(
//                                   'Categories',
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 Row(
//                                   children: [
//                                     ActionChip(
//                                         shape: const RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(50))),
//                                         label: Text(hymn.hymnCategory),
//                                         onPressed: () {}),
//                                     const SizedBox(width: 4),
//                                     ActionChip(
//                                         shape: const RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(50))),
//                                         label: Text(hymn.hymnCategory),
//                                         onPressed: () {}),
//                                     const SizedBox(width: 4),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 16),
//                                 const Text(
//                                   'Author',
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   hymn.hymnAuthor,
//                                   style: const TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ]),
//                         )
//                       ],
//                     );
//                   });
//             },
//           )
//         ],
//       ),
//       body: isLoading
//           ? const CircularProgressIndicator()
//           : Padding(
//               padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
//               child: (Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     hymn.hymnTitle,
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     hymn.hymnLyrics,
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               )),
//             ),
//     );