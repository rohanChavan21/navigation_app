import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '/models/locations.dart';
import '/screens/listView_screen.dart';
import '/screens/map_screen.dart';

class HomePage extends StatefulWidget {
  final List<Locations> availableLocations;
  HomePage(this.availableLocations, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  late List<Widget> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      const MapScreen(),
      InfoListView(widget.availableLocations),
    ];
    super.initState();
  }

  void _submitData() {
    if (_searchController.text.isEmpty) return;
    final destination = _searchController.text;
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: GNav(
            gap: 8,
            color: Colors.white,
            activeColor: Colors.white,
            backgroundColor: Colors.black,
            selectedIndex: _selectedPageIndex,
            tabBackgroundColor: Colors.grey.shade800,
            onTabChange: _selectPage,
            tabs: const [
              GButton(
                icon: Icons.map_sharp,
                text: 'Explore',
                textStyle: TextStyle(backgroundColor: Colors.transparent),
                textSize: 25,
                // onPressed: _selectPage,
              ),
              GButton(
                icon: Icons.list,
                text: 'ListView',
                textStyle: TextStyle(backgroundColor: Colors.transparent),
                textSize: 25,
                // onPressed: _selectPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
