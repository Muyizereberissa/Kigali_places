import 'package:flutter/material.dart';
import '../models/place_model.dart';
import '../services/firestore_service.dart';

class PlaceProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();

  List<Place> _places = [];
  bool _isLoading = false;

  List<Place> get places => _places;
  bool get isLoading => _isLoading; 

  PlaceProvider() {
    listenToPlaces();
  }

  void listenToPlaces() {
    print("Listening to Firestore...");
    _isLoading = true; 
    notifyListeners();

    _service.getPlaces().listen((data) {
      print("Loaded places: ${data.length}");
      _places = data;
      _isLoading = false; 
      notifyListeners();
    });
  }

  Future<void> addPlace(Place place) async {
    await _service.addPlace(place);
  }

  Future<void> deletePlace(String id) async {
    await _service.deletePlace(id);
  }

  Future<void> updatePlace(Place place) async {
    await _service.updatePlace(place);
  }
}