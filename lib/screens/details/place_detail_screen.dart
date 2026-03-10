import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/place_model.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Place place;

  const PlaceDetailScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: Color(0xFF0B2A4A),
      ),
      body: ListView(
        children: [
          // Map Placeholder
          Container(
            height: 250,
            color: Colors.grey[300],
            child: Center(
              child: Text(
                "Map placeholder\n(Google Maps API not required for this assignment)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                Text(
                  place.description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 12),

                // Address
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.black54),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text(
                      place.address,
                      style: TextStyle(fontSize: 14),
                    )),
                  ],
                ),
                SizedBox(height: 8),

                // Contact
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.black54),
                    SizedBox(width: 8),
                    Text(
                      place.contact,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Navigate Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0B2A4A),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: Icon(Icons.directions),
                  label: Text("Navigate"),
                  onPressed: () async {
                    final url =
                        "https://www.google.com/maps/dir/?api=1&destination=${place.latitude},${place.longitude}";

                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Could not open Google Maps. Please check your device.")),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}