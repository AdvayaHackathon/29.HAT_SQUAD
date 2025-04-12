import 'package:flutter/material.dart';
import 'package:maternalhealthcareapp/AUTHENTICATION/login_page.dart';
import 'package:maternalhealthcareapp/DASHBOARDENGLISH/dashboard_screen.dart';
import 'package:maternalhealthcareapp/DASHBOARDHINDI/dashboard_screenh.dart';
import 'DASHBOARDHINDI/doctorinterfaceh.dart';
import 'DASHBOARDKANNADA/doctorinterfacek.dart'; // डॉक्टर इंटरफेस पृष्ठ को आयात करें

class PreDashboardPageh extends StatelessWidget {
  const PreDashboardPageh({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // शीर्षक को खाली सेट करके हटा दें
        title: Container(),
        backgroundColor:
            Colors.pink[50], // ऐप बार की पृष्ठभूमि हल्के गुलाबी रंग में सेट करें
      ),
      backgroundColor:
          Colors.pink[50], // पूरे पृष्ठ की पृष्ठभूमि हल्के गुलाबी रंग में सेट करें
      body: Column(
        children: [
          // पृष्ठ के ऊपरी भाग में "हमें अपने बारे में बताएं" पाठ जोड़ें
          Padding(
            padding:
                EdgeInsets.only(top: 50, bottom: 10), // नीचे का पैडिंग कम करें
            child: Text(
              'हमें अपने बारे में बताएं!!',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.pink[800], // गहरे गुलाबी रंग में पाठ
              ),
            ),
          ),
          // बटनों को ऊर्ध्वाधर रूप से केंद्र में रखें
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // डॉक्टर इंटरफेस पर जाएं
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DoctorInterfacePageh()), // अपडेटेड लाइन
                      );
                      print(
                          'डॉक्टर इंटरफेस पर नेविगेट किया जा रहा है'); // हिंदी प्रिंट स्टेटमेंट
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20), // बड़ा पैडिंग
                      minimumSize: Size(350, 80), // बड़ा बटन आकार
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // हल्का बड़ा बॉर्डर रेडियस
                      ),
                      backgroundColor:
                          Colors.white, // बटन की पृष्ठभूमि को सफेद रंग में सेट करें
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/doctor_icon.png', // सही पथ
                          width: 100, // बड़ा चित्र आकार
                          height: 100, // बड़ा चित्र आकार
                        ),
                        SizedBox(
                            width:
                                15), // चित्र और पाठ के बीच अधिक स्थान
                        Text(
                          'मैं डॉक्टर हूँ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.pink[
                                  900]), // बड़ा फ़ॉन्ट आकार और गुलाबी पाठ रंग
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30), // बटनों के बीच अधिक स्थान
                  ElevatedButton(
                    onPressed: () {
                      // रोगी इंटरफेस पर जाएं
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DashboardScreenH()), // अपडेटेड लाइन
                      );
                      print(
                          'रोगी इंटरफेस पर नेविगेट किया जा रहा है'); // हिंदी प्रिंट स्टेटमेंट
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20), // बड़ा पैडिंग
                      minimumSize: Size(350, 80), // बड़ा बटन आकार
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // हल्का बड़ा बॉर्डर रेडियस
                      ),
                      backgroundColor:
                          Colors.white, // बटन की पृष्ठभूमि को सफेद रंग में सेट करें
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/patient_icon.png', // सही पथ
                          width: 100, // बड़ा चित्र आकार
                          height: 100, // बड़ा चित्र आकार
                        ),
                        SizedBox(
                            width:
                                15), // चित्र और पाठ के बीच अधिक स्थान
                        Text(
                          'मैं गर्भवती हूँ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.pink[
                                  900]), // बड़ा फ़ॉन्ट आकार और गुलाबी पाठ रंग
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
  const DoctorLoginPage({super.key});

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
  const PatientLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('रोगी लॉगिन'),
      ),
      body: Center(
        child: Text('रोगी लॉगिन पृष्ठ सामग्री'),
      ),
    );
  }
}
