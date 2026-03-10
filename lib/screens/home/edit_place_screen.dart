import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/place_model.dart';
import '../../providers/place_provider.dart';

class EditPlaceScreen extends StatefulWidget {

  final Place place;

  EditPlaceScreen({required this.place});

  @override
  _EditPlaceScreenState createState() => _EditPlaceScreenState();
}

class _EditPlaceScreenState extends State<EditPlaceScreen> {

  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController addressController;
  late TextEditingController contactController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.place.name);
    categoryController = TextEditingController(text: widget.place.category);
    addressController = TextEditingController(text: widget.place.address);
    contactController = TextEditingController(text: widget.place.contact);
    descriptionController = TextEditingController(text: widget.place.description);
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PlaceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Listing"),
        backgroundColor: Color(0xFF0B2A4A),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: ListView(
          children: [

            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),

            TextField(controller: categoryController, decoration: InputDecoration(labelText: "Category")),

            TextField(controller: addressController, decoration: InputDecoration(labelText: "Address")),

            TextField(controller: contactController, decoration: InputDecoration(labelText: "Contact")),

            TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Description")),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Update"),

              onPressed: () {

                final updatedPlace = Place(
                  id: widget.place.id,
                  name: nameController.text,
                  category: categoryController.text,
                  address: addressController.text,
                  contact: contactController.text,
                  description: descriptionController.text,
                  latitude: widget.place.latitude,
                  longitude: widget.place.longitude,
                  createdBy: widget.place.createdBy,
                );

                provider.updatePlace(updatedPlace);

                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}