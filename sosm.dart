import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SosM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'एसओएस ऐप',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('एसओएस ऐप'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.pinkAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _callAmbulance(context);
                },
                child: Text('एम्बुलेंस कॉल करें'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showBloodGroupDialog(context);
                },
                child: Text('ब्लड बैंक'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _callAmbulance(BuildContext context) async {
    String ambulanceNumber = '+919481032460';
    String url = 'tel:$ambulanceNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('फोन कॉल नहीं किया जा सका')),
      );
    }
  }

  void _showBloodGroupDialog(BuildContext context) {
    String selectedBloodGroup = 'A+';

    final Map<String, String> bloodGroupToNumber = {
      'A+': '+919481032460',
      'A-': '+917892942557',
      'B+': '+919606248727',
      'B-': '+918217748909',
      'AB+': '+919481032460',
      'AB-': '+917892942557',
      'O+': '+919606248727',
      'O-': '+918217748909',
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ब्लड ग्रुप चुनें'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButton<String>(
                value: selectedBloodGroup,
                onChanged: (String? newValue) {
                  selectedBloodGroup = newValue!;
                },
                items: <String>[
                  'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('रद्द करें'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('संदेश भेजें'),
              onPressed: () async {
                String phoneNumber = bloodGroupToNumber[selectedBloodGroup]!;
                String message = 'अति आवश्यक: ब्लड ग्रुप $selectedBloodGroup की जरूरत है';
                String url = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('व्हाट्सएप खोलने में असमर्थ')),
                  );
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class BloodBankPage extends StatelessWidget {
  final String bloodGroup;

  BloodBankPage(this.bloodGroup);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ब्लड बैंक'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue],
          ),
        ),
        child: Center(
          child: Text('चयनित ब्लड ग्रुप: $bloodGroup'),
        ),
      ),
    );
  }
}
