import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/favorites_page.dart';
import 'package:provider/provider.dart';
import 'generator_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 1;
  final _destinations = <AdaptiveScaffoldDestination>[
    AdaptiveScaffoldDestination(title: 'Home', icon: Icons.home),
    AdaptiveScaffoldDestination(title: 'Favorites', icon: Icons.favorite),
  ];

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return AdaptiveNavigationScaffold(
      body: page,
      selectedIndex: selectedIndex,
      destinations: _destinations,
      onDestinationSelected: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
    );
    // return LayoutBuilder(builder: (context, constraints) {
    //   return Scaffold(
    //     body: Row(
    //       children: [
    //         SafeArea(
    //           child: NavigationRail(
    //             extended: constraints.maxWidth >= 800,
    //             destinations: [
    //               NavigationRailDestination(
    //                 icon: Icon(Icons.home),
    //                 label: Text('Home'),
    //               ),
    //               NavigationRailDestination(
    //                 icon: Icon(Icons.favorite),
    //                 label: Text('Favorites'),
    //               ),
    //             ],
    //             selectedIndex: selectedIndex,
    //           ),
    //         ),
    //         Expanded(
    //           child: Container(
    //             color: Theme.of(context).colorScheme.primaryContainer,
    //             child: page,
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // });
  }
}
