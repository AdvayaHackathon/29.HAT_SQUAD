import 'package:flutter/material.dart';
import 'package:maternalhealthcareapp/DASHBOARDMARATHI/dashboard_screenm.dart';
import 'package:maternalhealthcareapp/DASHBOARDMARATHI/doctorinterfacem.dart';

class PreDashboardPagem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // शीर्षक हटवण्यासाठी रिक्त कंटेनर सेट करा
        title: Container(),
        backgroundColor:
            Colors.pink[50], // अॅप बारचा पार्श्वभूमी रंग हलका गुलाबी सेट करा
      ),
      backgroundColor: Colors
          .pink[50], // संपूर्ण पृष्ठाचा पार्श्वभूमी रंग हलका गुलाबी सेट करा
      body: Column(
        children: [
          // "आम्हाला तुमच्याबद्दल सांगा" हा मजकूर वरच्या भागात जोडा
          Padding(
            padding:
                EdgeInsets.only(top: 50, bottom: 10), // खालचा पॅडिंग कमी केला
            child: Text(
              'आम्हाला तुमच्याबद्दल\n   सांगा!!',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.pink[800], // गडद गुलाबी रंग मजकूरासाठी
              ),
            ),
          ),
          // बटणे उभ्या बाजूने मध्यभागी ठेवा
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // डॉक्टर इंटरफेसकडे जा
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DoctorInterfacePageM()), // अद्ययावत ओळ
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20), // मोठा पॅडिंग
                      minimumSize: Size(350, 80), // मोठे बटण आकार
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // किंचित मोठा सीमा त्रिज्या
                      ),
                      backgroundColor:
                          Colors.white, // बटणाचा पार्श्वभूमी रंग पांढरा ठेवा
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/doctor_icon.png', // योग्य मार्ग
                          width: 100, // मोठा प्रतिमा आकार
                          height: 100, // मोठा प्रतिमा आकार
                        ),
                        SizedBox(
                            width: 15), // प्रतिमा आणि मजकूरामधील जागा वाढवा
                        Text(
                          'मी डॉक्टर आहे',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors
                                  .pink[900]), // मोठा फॉन्ट आणि गुलाबी रंग
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30), // बटनांमधील अंतर वाढवा
                  ElevatedButton(
                    onPressed: () {
                      // रुग्ण इंटरफेसकडे जा
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DashboardScreenM()), // अद्ययावत ओळ
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20), // मोठा पॅडिंग
                      minimumSize: Size(350, 80), // मोठे बटण आकार
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // किंचित मोठा सीमा त्रिज्या
                      ),
                      backgroundColor:
                          Colors.white, // बटणाचा पार्श्वभूमी रंग पांढरा ठेवा
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/patient_icon.png', // योग्य मार्ग
                          width: 100, // मोठा प्रतिमा आकार
                          height: 100, // मोठा प्रतिमा आकार
                        ),
                        SizedBox(
                            width: 15), // प्रतिमा आणि मजकूरामधील जागा वाढवा
                        Text(
                          'मी गर्भवती आहे',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors
                                  .pink[900]), // मोठा फॉन्ट आणि गुलाबी रंग
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('डॉक्टर लॉगिन'),
      ),
      body: Center(
        child: Text('डॉक्टर लॉगिन पृष्ठ सामग्री'),
      ),
    );
  }
}

class PatientLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('रुग्ण लॉगिन'),
      ),
      body: Center(
        child: Text('रुग्ण लॉगिन पृष्ठ सामग्री'),
      ),
    );
  }
}
