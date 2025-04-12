import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sosh extends StatelessWidget {
  const Sosh({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'एसओएस ऐप',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.pink[50], // हल्का गुलाबी बैकग्राउंड
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
        title: Text('एसओएस ऐप'),
        backgroundColor: const Color.fromARGB(255, 167, 28, 128), // गहरा गुलाबी ऐप बार
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink[50]!, Colors.pink[100]!], // हल्का गुलाबी ग्रेडिएंट
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // एंबुलेंस कॉल बटन
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _callAmbulance(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    backgroundColor: const Color.fromARGB(255, 167, 28, 128), // गहरा गुलाबी बटन
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // गोल कोनों वाला बटन
                    ),
                    elevation: 10, // बटन पर शैडो
                  ),
                  child: Text(
                    'एम्बुलेंस को कॉल करें',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20), // बटनों के बीच स्पेसिंग
              // ब्लड बैंक बटन
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _showBloodGroupDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    backgroundColor: const Color.fromARGB(255, 167, 28, 128), // गहरा गुलाबी बटन
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10,
                  ),
                  child: Text(
                    'ब्लड बैंक',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _callAmbulance(BuildContext context) async {
    String ambulanceNumber = '+919481032460'; // एंबुलेंस नंबर
    String url = 'tel:$ambulanceNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कॉल नहीं किया जा सका')),
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
                items: <String>['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                    .map<DropdownMenuItem<String>>((String value) {
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
                String message = 'अत्यावश्यक: $selectedBloodGroup ब्लड ग्रुप की जरूरत है';
                String url = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('व्हाट्सएप नहीं खोल सका')),
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
