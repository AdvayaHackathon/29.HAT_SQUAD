import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorCallM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'एसओएस अॅप',
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
        title: Text('एसओएस अॅप'),
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
              // डॉक्टरला कॉल करण्यासाठी बटण
              ElevatedButton(
                onPressed: () {
                  _callDoctor(context);
                },
                child: Text('डॉक्टरला कॉल करा'),
              ),
              SizedBox(height: 20), // बटणांमध्ये अंतर
              // नर्सला कॉल करण्यासाठी बटण
              ElevatedButton(
                onPressed: () {
                  _callNurse(context);
                },
                child: Text('नर्सला कॉल करा'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // डॉक्टरला कॉल करण्याचे फंक्शन
  void _callDoctor(BuildContext context) async {
    // पूर्वनिर्धारित डॉक्टरचा फोन नंबर
    String doctorNumber =
        '+919481032460'; // हा क्रमांक वास्तविक डॉक्टरच्या नंबरने बदला

    // कॉलसाठी URL तयार करणे
    String url = 'tel:$doctorNumber';

    // URL लॉन्च करणे
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('डॉक्टरला कॉल करता आला नाही')),
      );
    }
  }

  // नर्सला कॉल करण्याचे फंक्शन
  void _callNurse(BuildContext context) async {
    // पूर्वनिर्धारित नर्सचा फोन नंबर
    String nurseNumber =
        '+919481032460'; // हा क्रमांक वास्तविक नर्सच्या नंबरने बदला

    // कॉलसाठी URL तयार करणे
    String url = 'tel:$nurseNumber';

    // URL लॉन्च करणे
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('नर्सला कॉल करता आला नाही')),
      );
    }
  }
}
