// import this to use the File type
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place_model.dart';
import '../helpers/db_helper.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<PlaceModel> _items = [];

  List<PlaceModel> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    // add a new place to the _items array
    final newPlace = PlaceModel(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: null,
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();

    // then save it to the database by using the .insert
    // method that you created in db_helper.dart
    // the keys that are used here are the keys you
    // set in db.execute in db_helper.dart
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');

    _items = dataList
        .map(
          (item) => PlaceModel(
            id: item['id'],
            title: item['title'],
            location: null,
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
