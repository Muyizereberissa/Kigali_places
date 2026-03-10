import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../providers/place_provider.dart';
// import '../../models/place_model.dart';
// import '../../widgets/place_card.dart';
import 'add_place_screen.dart';
import 'edit_place_screen.dart';
import '../details/place_detail_screen.dart';

class MyListingsScreen extends StatefulWidget {
  @override
  _MyListingsScreenState createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {

  String searchText = "";
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PlaceProvider>(context);

    final uid = FirebaseAuth.instance.currentUser!.uid;

    final myPlaces = provider.places.where((place) {
      return place.createdBy == uid;
    }).toList();

    final filteredPlaces = myPlaces.where((place) {

      final matchesSearch =
          place.name.toLowerCase().contains(searchText.toLowerCase());

      final matchesCategory =
          selectedCategory == "All" || place.category == selectedCategory;

      return matchesSearch && matchesCategory;

    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("My Listings"),
        backgroundColor: Color(0xFF0B2A4A),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0B2A4A),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddPlaceScreen()),
          );
        },
      ),

      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            TextField(
              decoration: InputDecoration(
                hintText: "Search listings...",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),

            SizedBox(height: 10),

            DropdownButton<String>(
              value: selectedCategory,
              items: [
                "All",
                "Restaurant",
                "Hospital",
                "Police",
                "School"
              ].map((category) {

                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );

              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            Expanded(
              child: filteredPlaces.isEmpty
                  ? Center(child: Text("No listings found"))
                  : ListView.builder(
                      itemCount: filteredPlaces.length,
                      itemBuilder: (context, index) {

                        final place = filteredPlaces[index];

                        return Card(
                          child: ListTile(
                            title: Text(place.name),
                            subtitle: Text(place.category),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      PlaceDetailScreen(place: place),
                                ),
                              );
                            },

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            EditPlaceScreen(place: place),
                                      ),
                                    );
                                  },
                                ),

                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    provider.deletePlace(place.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}