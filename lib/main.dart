import 'package:catholic_hymnal/common/app_routes.dart';
import 'package:catholic_hymnal/providers/api_provider.dart';
import 'package:catholic_hymnal/screens/hymn_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/favorites.dart';
import 'models/hymn.dart';
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
          // routes: {
          //   HomePage.routeName: (context) => const HomePage(),
          //   //HymnDetailsScreen.routeName: (context) =>  HymnDetailsScreen(),
          //   FavoritesPage.routeName: (context) => const FavoritesPage(),
          // },
          initialRoute: AppRoutes.home,
          onGenerateRoute: Router.generateRoute),
    );
  }
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      case AppRoutes.details:
        var hymn = settings.arguments as Hymn;
        return MaterialPageRoute(builder: (_) => HymnDetails(hymn: hymn));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
