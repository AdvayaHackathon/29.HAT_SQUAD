import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorCallh extends StatelessWidget {
  const DoctorCallh({super.key});

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
  const HomeScreen({super.key});

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
            colors: [
              Colors.pink[100]!,
              Colors.pink[50]!
            ], // हल्का गुलाबी ग्रेडिएंट
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // डॉक्टर को कॉल करने का बटन
              ElevatedButton(
                onPressed: () {
                  _callDoctor(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.pink[800], // गहरा गुलाबी बटन रंग
                  padding: EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20), // बड़ा बटन आकार
                  textStyle: TextStyle(fontSize: 20), // बड़ा फ़ॉन्ट आकार
                ),
                child: Text('डॉक्टर को कॉल करें'),
              ),
              SizedBox(height: 20), // बटन के बीच अंतर
              // नर्स को कॉल करने का बटन
              ElevatedButton(
                onPressed: () {
                  _callNurse(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.pink[800], // गहरा गुलाबी बटन रंग
                  padding: EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20), // बड़ा बटन आकार
                  textStyle: TextStyle(fontSize: 20), // बड़ा फ़ॉन्ट आकार
                ),
                child: Text('नर्स को कॉल करें'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // डॉक्टर को कॉल करने का फ़ंक्शन
  void _callDoctor(BuildContext context) async {
    // डॉक्टर का फ़ोन नंबर
    String doctorNumber =
        '+919481032460'; // यहाँ सही डॉक्टर नंबर डालें
    // फ़ोन कॉल के लिए URL बनाएँ
    String url = 'tel:$doctorNumber';
    // URL लॉन्च करें
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('डॉक्टर को कॉल नहीं किया जा सका')),
      );
    }
  }

  // नर्स को कॉल करने का फ़ंक्शन
  void _callNurse(BuildContext context) async {
    // नर्स का फ़ोन नंबर
    String nurseNumber =
        '+919481032460'; // यहाँ सही नर्स नंबर डालें
    // फ़ोन कॉल के लिए URL बनाएँ
    String url = 'tel:$nurseNumber';
    // URL लॉन्च करें
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('नर्स को कॉल नहीं किया जा सका')),
      );
    }
  }
}
