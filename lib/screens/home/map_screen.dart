import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/place_provider.dart';
import '../details/place_detail_screen.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaceProvider>(context);

    if (provider.places.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("City Map"),
          backgroundColor: Color(0xFF0B2A4A),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("City Map"),
        backgroundColor: Color(0xFF0B2A4A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 300,
              color: Colors.grey[300],
              child: Center(
                child: Text(
                  "Map placeholder",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: provider.places.length,
                itemBuilder: (context, index) {
                  final place = provider.places[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.location_on, color: Colors.red),
                      title: Text(place.name),
                      subtitle: Text(place.address),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlaceDetailScreen(place: place),
                          ),
                        );
                      },
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