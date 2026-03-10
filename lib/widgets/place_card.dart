import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {

  final dynamic place;

  const PlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,

      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.location_city),
        ),

        title: Text(
          place.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 4),

            Text("${place.category} • ${place.address}"),

            SizedBox(height: 4),

            Text(
              place.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 4),

            Text("📞 ${place.contact}"),
          ],
        ),

        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}