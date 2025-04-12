import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorCall extends StatelessWidget {
  const DoctorCall({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS ಅಪ್ಲಿಕೇಶನ್',
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
        title: Text('SOS ಅಪ್ಲಿಕೇಶನ್'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.pink[100]!,
              Colors.pink[50]!
            ], // ಲೈಟ್ ಪಿಂಕ್ ಗ್ರೇಡಿಯಂಟ್
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ಡಾಕ್ಟರ್ ಕರೆ ಬಟನ್
              ElevatedButton(
                onPressed: () {
                  _callDoctor(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.pink[800], // ಡಾರ್ಕ್ ಪಿಂಕ್ ಬಟನ್ ಬಣ್ಣ
                  padding: EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20), // ದೊಡ್ಡ ಬಟನ್ ಗಾತ್ರ
                  textStyle: TextStyle(fontSize: 20), // ದೊಡ್ಡ ಫಾಂಟ್ ಗಾತ್ರ
                ),
                child: Text('ಡಾಕ್ಟರ್ ಕರೆ ಮಾಡಿ'),
              ),
              SizedBox(height: 20), // ಬಟನ್‌ಗಳ ನಡುವೆ ಜಾಗ
              // ನರ್ಸ್ ಕರೆ ಬಟನ್
              ElevatedButton(
                onPressed: () {
                  _callNurse(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.pink[800], // ಡಾರ್ಕ್ ಪಿಂಕ್ ಬಟನ್ ಬಣ್ಣ
                  padding: EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20), // ದೊಡ್ಡ ಬಟನ್ ಗಾತ್ರ
                  textStyle: TextStyle(fontSize: 20), // ದೊಡ್ಡ ಫಾಂಟ್ ಗಾತ್ರ
                ),
                child: Text('ನರ್ಸ್ ಕರೆ ಮಾಡಿ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ಡಾಕ್ಟರ್‌ಗೆ ಕರೆ ಮಾಡುವ ಕಾರ್ಯ
  void _callDoctor(BuildContext context) async {
    // ಡಾಕ್ಟರ್ ಫೋನ್ ಸಂಖ್ಯೆ
    String doctorNumber =
        '+919481032460'; // ನಿಜವಾದ ಡಾಕ್ಟರ್ ಸಂಖ್ಯೆ ಇಲ್ಲಿಗೆ ಹಾಕಿ
    // ಫೋನ್ ಕರೆ URL ತಯಾರಿಸಿ
    String url = 'tel:$doctorNumber';
    // URL ಲಾಂಚ್ ಮಾಡಿ
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ಡಾಕ್ಟರ್‌ಗೆ ಫೋನ್ ಕರೆ ಮಾಡಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ')),
      );
    }
  }

  // ನರ್ಸ್‌ಗೆ ಕರೆ ಮಾಡುವ ಕಾರ್ಯ
  void _callNurse(BuildContext context) async {
    // ನರ್ಸ್ ಫೋನ್ ಸಂಖ್ಯೆ
    String nurseNumber =
        '+919481032460'; // ನಿಜವಾದ ನರ್ಸ್ ಸಂಖ್ಯೆ ಇಲ್ಲಿಗೆ ಹಾಕಿ
    // ಫೋನ್ ಕರೆ URL ತಯಾರಿಸಿ
    String url = 'tel:$nurseNumber';
    // URL ಲಾಂಚ್ ಮಾಡಿ
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ನರ್ಸ್‌ಗೆ ಫೋನ್ ಕರೆ ಮಾಡಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ')),
      );
    }
  }
}
