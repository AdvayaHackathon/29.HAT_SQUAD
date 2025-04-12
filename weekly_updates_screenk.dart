import 'package:flutter/material.dart';

class WeeklyUpdatesScreenk extends StatelessWidget {
  final List<String> weeks = List.generate(10, (index) => "ವಾರ ${index + 1}");

  WeeklyUpdatesScreenk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ವಾರಕ್ಕೊಮ್ಮೆ ನವೀಕರಣಗಳು"),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        color: Colors.pink[50],
        child: ListView.builder(
          itemCount: weeks.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weeks[index],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "ತೂಕ",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "ಎತ್ತರ",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
