import 'package:flutter/material.dart';
import 'camera_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Capture App'),
        backgroundColor: Colors.orange[100], // Dark pink app bar
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
            children: [
              // Take Photo Button with Camera Icon
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraPage()),
                  );
                },
                icon: Icon(Icons.camera_alt, size: 30), // Camera icon
                label: Text(
                  'Take Photo',
                  style: TextStyle(fontSize: 20), // Larger font size
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[800], // Dark pink button
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Larger button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}