import 'package:flutter/material.dart';
import 'package:navigation_app/screens/map_screen.dart';
import '/homepage.dart';
import '/models/locations.dart';
import '/screens/listView_screen.dart';
import '/test_data/dummy_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Locations> _availableLocations = DUMMY_LOCATIONS;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primaryColorDark: Colors.grey[900],
          primarySwatch: Colors.grey,
        ).copyWith(secondary: Colors.grey),
        textTheme: TextTheme(
            bodyMedium: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.grey[900],
        )),
      ),
      home: HomePage(_availableLocations),
      initialRoute: '/',
      routes: {
        //   '/': (ctx) => HomePage(_availableLocations),
        //   // InfoListView.routeName: (ctx) => InfoListView(_availableLocations),
        MapScreen.routeName: (ctx) => const MapScreen(),
        //   // SearchScreen.routeName: (ctx) => const SearchScreen(),
      },
    );
  }
}
