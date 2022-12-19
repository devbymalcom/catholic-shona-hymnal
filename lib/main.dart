import 'package:catholic_hymnal/providers/api_provider.dart';
import 'package:catholic_hymnal/screens/hymn_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/favorites.dart';
import 'screens/favorites.dart';
import 'screens/home.dart';

void main() {
  runApp(const HymnalApp());
}

class HymnalApp extends StatelessWidget {
  const HymnalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ApiProvider(),
        ),
        ChangeNotifierProvider<Favorites>(
            create: (context) => Favorites()..initialize()),
      ],
      child: MaterialApp(
        title: 'Testing Sample',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          FavoritesPage.routeName: (context) => const FavoritesPage(),
        },
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
