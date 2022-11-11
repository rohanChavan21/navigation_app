import 'package:flutter/material.dart';
import '/models/locations.dart';
import '/screens/map_screen.dart';
import '/test_data/dummy_data.dart';
import '/widgets/list_item.dart';

class InfoListView extends StatefulWidget {
  static const routeName = '/list-view';
  final List<Locations> availableLocations;
  const InfoListView(this.availableLocations, {super.key});

  @override
  State<InfoListView> createState() => _InfoListViewState();
}

class _InfoListViewState extends State<InfoListView> {
  late List<Locations> displayedLocations = widget.availableLocations.toList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(25),
        itemBuilder: (context, index) {
          return ListItem(
            id: displayedLocations[index].id,
            title: displayedLocations[index].title,
            coOrdinates: displayedLocations[index].coOrdinates,
            imageUrl: displayedLocations[index].imageUrl,
            description: displayedLocations[index].description,
          );
        },
      ),
    );
  }
}
