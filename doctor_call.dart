import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorCall extends StatelessWidget {
  const DoctorCall({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink[100]!, Colors.pink[50]!], // Light pink gradient
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Call Doctor Button
              ElevatedButton(
                onPressed: () {
                  _callDoctor(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[800], // Dark pink color for the button
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Larger button size
                  textStyle: TextStyle(fontSize: 20), // Larger font size
                ),
                child: Text('Call Doctor'),
              ),
              SizedBox(height: 20), // Spacing between buttons
              // Call Nurse Button
              ElevatedButton(
                onPressed: () {
                  _callNurse(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[800], // Dark pink color for the button
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Larger button size
                  textStyle: TextStyle(fontSize: 20), // Larger font size
                ),
                child: Text('Call Nurse'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to call the predefined doctor number
  void _callDoctor(BuildContext context) async {
    // Predefined doctor phone number
    String doctorNumber =
        '+919481032460'; // Replace with the actual doctor number
    // Construct the phone call URL
    String url = 'tel:$doctorNumber';
    // Launch the URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not make a phone call to the doctor')),
      );
    }
  }

  // Function to call the predefined nurse number
  void _callNurse(BuildContext context) async {
    // Predefined nurse phone number
    String nurseNumber =
        '+919481032460'; // Replace with the actual nurse number
    // Construct the phone call URL
    String url = 'tel:$nurseNumber';
    // Launch the URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not make a phone call to the nurse')),
      );
    }
  }
}