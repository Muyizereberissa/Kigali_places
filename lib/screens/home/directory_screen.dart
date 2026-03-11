import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/place_provider.dart';
import '../../widgets/place_card.dart';
import '../../models/place_model.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});

  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {

  String searchText = "";
  String selectedCategory = "All";

  final categories = [
    "All",
    "Hospital",
    "Police",
    "Library",
    "Restaurant",
    "Cafe",
    "Park"
  ];

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PlaceProvider>(context);
    List<Place> places = provider.places;

    if (searchText.isNotEmpty) {
      places = places
          .where((p) =>
              p.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    /// CATEGORY FILTER
    if (selectedCategory != "All") {
      places = places
          .where((p) => p.category == selectedCategory)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kigali City Directory"),
        backgroundColor: const Color(0xFF0B2A4A),
      ),

      body: Column(
        children: [
          Container(
            color: const Color(0xFF0B2A4A),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [

                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: categories.map((cat) {

                      final selected = selectedCategory == cat;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: selected,
                          selectedColor: Colors.amber,
                          onSelected: (_) {
                            setState(() {
                              selectedCategory = cat;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search for a service",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),
              ],
            ),
          ),

          /// LIST SECTION
          Expanded(
            child: provider.places.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : places.isEmpty
                    ? const Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (context, index) {

                          final place = places[index];

                          return PlaceCard(place: place);
                        },
                      ),
          )
        ],
      ),
    );
  }
}