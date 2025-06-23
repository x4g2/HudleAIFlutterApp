import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> courts = ["GK Sports Arena", "Netaji Stadium", "AIIMS Ground"];
  String? selectedCourt;
  String? suggestedPartner;
  bool loading = false;

  Future<void> getSuggestedPartner() async {
    setState(() => loading = true);
    await Future.delayed(Duration(seconds: 2)); // Simulated API
    setState(() {
      suggestedPartner = 'Rahul Singh';
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hudle AI Booking'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async => await FirebaseAuth.instance.signOut(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Select a Court:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              hint: Text("Choose court"),
              value: selectedCourt,
              items: courts.map((court) {
                return DropdownMenuItem<String>(
                  value: court,
                  child: Text(court),
                );
              }).toList(),
              onChanged: (value) => setState(() => selectedCourt = value),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedCourt == null || loading ? null : getSuggestedPartner,
              child: loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Suggest a Match Partner"),
            ),
            SizedBox(height: 30),
            if (suggestedPartner != null)
              Text("Suggested Partner: \$suggestedPartner",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
