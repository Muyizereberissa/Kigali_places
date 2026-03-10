import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool locationNotificationsEnabled = false; // simulated preference

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Color(0xFF0B2A4A),
      ),
      body: user == null
          ? Center(child: Text("No user is logged in"))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Section
                  Text(
                    "Profile Information",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  SizedBox(height: 12),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(user.displayName ?? "No display name"),
                    subtitle: Text("Name"),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(user.email ?? "No email"),
                    subtitle: Text("Email"),
                  ),
                  ListTile(
                    leading: Icon(Icons.fingerprint),
                    title: Text(user.uid),
                    subtitle: Text("UID"),
                  ),
                  Divider(height: 32),

                  // Notification Toggle
                  Text(
                    "Notifications",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  SizedBox(height: 12),
                  SwitchListTile(
                    title: Text("Enable Location-based Notifications"),
                    value: locationNotificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        locationNotificationsEnabled = value;
                      });

                      // Simulate saving preference (can later persist in shared_preferences)
                      print(
                          "Location-based notifications: $locationNotificationsEnabled");
                    },
                    secondary: Icon(Icons.location_on),
                  ),
                ],
              ),
            ),
    );
  }
}