import 'package:flutter/material.dart';

import 'add_place_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places_provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Consumer<GreatPlacesProvider>(
        child: const Center(
          child: Text('No places yet, start adding some!'),
        ),
        builder: (context, greatPlaces, child) => greatPlaces.items.isEmpty
            // this child is the child above (Center widget)
            // you can directly put the Center widget here
            // you just save it so that you know what the child in the builder do.
            ? child!
            : ListView.builder(
                itemCount: greatPlaces.items.length,
                itemBuilder: (context, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                      greatPlaces.items[i].image,
                    ),
                  ),
                  title: Text(
                    greatPlaces.items[i].title,
                  ),
                  onTap: () {},
                ),
              ),
      ),
    );
  }
}
