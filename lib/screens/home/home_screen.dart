import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/place_provider.dart';
import 'directory_screen.dart';
import 'map_screen.dart';
import 'my_listings_screen.dart';
import './settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int index = 0;

  final screens = [
    DirectoryScreen(),
    MyListingsScreen(),
    MapScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<PlaceProvider>(context, listen: false).listenToPlaces();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: screens[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        backgroundColor: Color(0xFF0B2A4A),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Listings"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}