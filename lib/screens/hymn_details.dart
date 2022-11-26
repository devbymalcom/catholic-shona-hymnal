import 'package:flutter/material.dart';

import '../models/hymn.dart';
import '../providers/database_services.dart';

class HymnDetailsScreen extends StatefulWidget {
  final int hymnNumberId;
  static const routeName = '/hymn_details';

  const HymnDetailsScreen({super.key, required this.hymnNumberId});

  @override
  State<HymnDetailsScreen> createState() => _HymnDetailsScreenState();
}

class _HymnDetailsScreenState extends State<HymnDetailsScreen> {
  late Hymn hymn;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshHymn();
  }

  Future refreshHymn() async {
    setState(() => isLoading = true);
    hymn = await DatabaseService().readHymn(widget.hymnNumberId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Hymn;

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: lightColorScheme.primary,
        leading: IconButton(
            //  color: lightColorScheme.onSecondary,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              //  color: lightColorScheme.onSecondary,
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border)),
          IconButton(
            //color: lightColorScheme.onSecondary,
            icon: const Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 32, 16, 32),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hymn Details',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Hymn Number',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  hymn.hymnNumber.toString(),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Categories',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    ActionChip(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        label: Text(hymn.hymnCategory),
                                        onPressed: () {}),
                                    const SizedBox(width: 4),
                                    ActionChip(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        label: Text(hymn.hymnCategory),
                                        onPressed: () {}),
                                    const SizedBox(width: 4),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Author',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  hymn.hymnAuthor,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                        )
                      ],
                    );
                  });
            },
          )
        ],
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
              child: (Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    args.hymnTitle,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    args.hymnLyrics,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )),
            ),
    );
  }
}
