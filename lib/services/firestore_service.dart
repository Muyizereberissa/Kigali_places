import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/place_model.dart';

class FirestoreService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Place>> getPlaces() {

    return _db.collection("places").snapshots().map((snapshot) {

      return snapshot.docs
          .map((doc) => Place.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> addPlace(Place place) async {

    await _db.collection("places").add(place.toMap());
  }

  Future<void> updatePlace(Place place) async {

    await _db.collection("places")
        .doc(place.id)
        .update(place.toMap());
  }

  Future<void> deletePlace(String id) async {

    await _db.collection("places").doc(id).delete();
  }
}