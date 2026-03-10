import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/place_model.dart';
import '../../providers/place_provider.dart';

class AddPlaceScreen extends StatefulWidget {
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();
  final descriptionController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PlaceProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Add Listing")),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: ListView(
          children: [

            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),

            TextField(controller: categoryController, decoration: InputDecoration(labelText: "Category")),

            TextField(controller: addressController, decoration: InputDecoration(labelText: "Address")),

            TextField(controller: contactController, decoration: InputDecoration(labelText: "Contact")),

            TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Description")),

            TextField(controller: latController, decoration: InputDecoration(labelText: "Latitude")),

            TextField(controller: lngController, decoration: InputDecoration(labelText: "Longitude")),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Save"),

              onPressed: () {

                final uid = FirebaseAuth.instance.currentUser!.uid;

                final place = Place(
                  id: "",
                  name: nameController.text,
                  category: categoryController.text,
                  address: addressController.text,
                  contact: contactController.text,
                  description: descriptionController.text,
                  latitude: double.parse(latController.text),
                  longitude: double.parse(lngController.text),
                  createdBy: uid,
                );

                provider.addPlace(place);

                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}