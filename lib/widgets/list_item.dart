import 'package:flutter/material.dart';
import 'package:navigation_app/screens/map_screen.dart';

class ListItem extends StatelessWidget {
  final String id;
  final String title;
  final Map<String, double> coOrdinates;
  final String imageUrl;
  final String description;
  const ListItem(
      {required this.id,
      required this.title,
      required this.coOrdinates,
      required this.imageUrl,
      required this.description,
      super.key});

  void navigateToLocation(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MapScreen.routeName, arguments: {
      'latitude': coOrdinates['latitude'],
      'longitude': coOrdinates['longitude'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: Image.network(
                  imageUrl,
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(2),
                      child: Text(
                        title,
                        style: const TextStyle(
                          background: null,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(2),
                      child: Text(
                        description,
                        style: const TextStyle(
                          color: Colors.black,
                          background: null,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(2),
                child: const Text('sometime min'),
              ),
              ElevatedButton(
                onPressed: () => navigateToLocation(context),
                // style: ButtonStyle(
                //   backgroundColor: MaterialStateProperty.resolveWith(
                //     (states) {
                //       if (states.contains(MaterialState.pressed)) {
                //         return Colors.lightGreen;
                //       }
                //       return Colors.green;
                //     },
                //   ),
                // ),
                child: const Text(
                  'Navigate',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ],
      ),
    );
    // return Container(
    //   child: Card(),
    // );
  }
}
