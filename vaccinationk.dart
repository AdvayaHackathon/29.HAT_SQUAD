import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ವಾಕ್ಸಿನೇಶನ್ ಮಾರ್ಗದರ್ಶಿ',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: VaccinationPagek(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VaccinationPagek extends StatelessWidget {
  final List<Map<String, String>> vaccinations = [
    {
      'month': 'ತಿಂಗಳು 1',
      'name': 'ಹೆಪಟೈಟಿಸ್ B (ಮೊದಲ ಡೋಸ್)',
      'description': 'ಹೆಪಟೈಟಿಸ್ B ನ ತಾಯಿಯಿಂದ ಶಿಶುವಿಗೆ ಸಂಚರಿಸುವುದನ್ನು ತಡೆಯುತ್ತದೆ.',
      'cause': 'ಹೆಪಟೈಟಿಸ್ B ವೈರಸ್ (HBV) ಕಾರಣ.',
      'prevention': 'ವಾಕ್ಸಿನೇಶನ್, ಸೋಂಕು ಬಂದ ರಕ್ತದೊಂದಿಗೆ ಸಂಪರ್ಕ ತಡೆಯುವುದು.',
    },
    {
      'month': 'ತಿಂಗಳು 2',
      'name': 'ಹೆಪಟೈಟಿಸ್ B (ಎರಡನೇ ಡೋಸ್)',
      'description': 'ಎರಡನೇ ಡೋಸ್ ನಿರಂತರ ರಕ್ಷಣೆಯನ್ನು ಖಚಿತಪಡಿಸುತ್ತದೆ.',
      'cause': 'ಹೆಪಟೈಟಿಸ್ B ವೈರಸ್ (HBV) ಕಾರಣ.',
      'prevention': 'ಸೂಕ್ತ ಸಮಯದಲ್ಲಿ ರಕ್ಷಣೆ ಮತ್ತು ಸ್ವಚ್ಛತೆ.',
    },
    {
      'month': 'ತಿಂಗಳು 3',
      'name': 'ಇನ್ಫ್ಲುವೆಂಜಾ (ಜ್ವರ)',
      'description': 'ಗರ್ಭಿಣಿ ಮಹಿಳೆಯನ್ನು ಋತುಕಾಲೀನ ಜ್ವರದಿಂದ ರಕ್ಷಿಸುತ್ತದೆ.',
      'cause': 'ಇನ್ಫ್ಲುವೆಂಜಾ ವೈರಸ್, ಗಾಳಿಯಲ್ಲಿ ಹಾದುಹೋಗುವ ಮತ್ತು ಸಂಕ್ರಾಮಕ.',
      'prevention': 'ವಾರ್ಷಿಕ ವಾಕ್ಸಿನೇಶನ್, ಮುಖ ಮುದುಗೆ ಮತ್ತು ಸ್ವಚ್ಛತೆ.',
    },
    {
      'month': 'ತಿಂಗಳು 4',
      'name': 'ನ್ಯೂಮೋಕೊಕಲ್ ವಾಕ್ಸಿನ್',
      'description': 'ಯಕ್ಷ್ಮಾ ಮತ್ತು ಮೆನಿಂಜಿಟಿಸ್ ಗಳಿಂದ ರಕ್ಷಿಸುತ್ತದೆ.',
      'cause': 'ಸ್ಟ್ರೆಪ್ಟೊಕಾಕಸ್ ಪ್ನ್ಯೂಮೊನಿಯಾ ಬ್ಯಾಕ್ಟೀರಿಯಾ.',
      'prevention': 'ವಾಕ್ಸಿನೇಶನ್ ಮತ್ತು ಶ್ವಾಸಕೋಶ ಸೋಂಕುಗಳನ್ನು ತಡೆಯುವುದು.',
    },
    {
      'month': 'ತಿಂಗಳು 5',
      'name': 'ಮೆನಿಂಜೊಕೊಕಲ್ ವಾಕ್ಸಿನ್',
      'description': 'ಮೆನಿಂಜಿಟಿಸ್ ಮತ್ತು ರಕ್ತಸ್ರಾವ ಸೋಂಕುಗಳನ್ನು ತಡೆಯುತ್ತದೆ.',
      'cause': 'ನೈಸೀರಿಯಾ ಮೆನಿಂಜಿಟಿಡಿಸ್ ಬ್ಯಾಕ್ಟೀರಿಯಾ.',
      'prevention': 'ವಾಕ್ಸಿನೇಶನ್, ಉಪಕರಣಗಳನ್ನು ಹಂಚಿಕೆ ಮಾಡದಿರುವುದು, ಉತ್ತಮ ಸ್ವಚ್ಛತೆ.',
    },
    {
      'month': 'ತಿಂಗಳು 6',
      'name': 'Tdap (ಟೆಟನಸ್, ಡಿಪ್ತೀರಿಯಾ, ಪರ್ಟಸಿಸ್)',
      'description': 'ಟೆಟನಸ್, ಡಿಪ್ತೀರಿಯಾ ಮತ್ತು ಕಾಸು ಹಾಕುವಿಕೆಯಿಂದ ತಾಯಿ ಮತ್ತು ಶಿಶುವನ್ನು ರಕ್ಷಿಸುತ್ತದೆ.',
      'cause': 'ಗಾಯದ ಮೂಲಕ ಅಥವಾ ಗಾಳಿಯಲ್ಲಿ ಹಾದುಹೋಗುವ ಬ್ಯಾಕ್ಟೀರಿಯಾ ಸೋಂಕುಗಳು.',
      'prevention': 'ಪ್ರತಿ ಗರ್ಭಾವಸ್ಥೆಯಲ್ಲಿ ವಾಕ್ಸಿನೇಶನ್.',
    },
    {
      'month': 'ತಿಂಗಳು 7',
      'name': 'ಇನ್ಫ್ಲುವೆಂಜಾ (ಎರಡನೇ ಡೋಸ್)',
      'description': 'ಗರ್ಭಾವಸ್ಥೆಯ ಮುಂಚಿನ ಹಂತದಲ್ಲಿ ಜ್ವರದ ರಕ್ಷಣೆಯನ್ನು ಪ್ರೋತ್ಸಾಹಿಸುತ್ತದೆ.',
      'cause': 'ಇನ್ಫ್ಲುವೆಂಜಾ ವೈರಸ್.',
      'prevention': 'ಜ್ವರದ ಬೂಸ್ಟರ್ ಟೀಕೆ, ರೋಗಿಗಳಿಂದ ದೂರವಿರುವುದು.',
    },
    {
      'month': 'ತಿಂಗಳು 8',
      'name': 'ಹೆಪಟೈಟಿಸ್ A',
      'description': 'ಕೆಲವು ಪ್ರದೇಶಗಳಲ್ಲಿ ಕೆಟ್ಟ ಸ್ವಚ್ಛತೆಯಿಂದಾಗುವ ಆಹಾರಜನ್ಯ ಕುಂದಲು ಸೋಂಕುಗಳನ್ನು ತಡೆಯುತ್ತದೆ.',
      'cause': 'ಹೆಪಟೈಟಿಸ್ A ವೈರಸ್.',
      'prevention': 'ವಾಕ್ಸಿನೇಶನ್, ಸುರಕ್ಷಿತ ಆಹಾರ ಮತ್ತು ಶುದ್ಧ ನೀರು.',
    },
    {
      'month': 'ತಿಂಗಳು 9',
      'name': 'ಹೆಪಟೈಟಿಸ್ B (ಮೂರನೇ ಡೋಸ್)',
      'description': 'ಅಂತಿಮ ಡೋಸ್ ಹೆಪಟೈಟಿಸ್ B ಗೆ ಪೂರ್ಣ ರಕ್ಷಣೆಯನ್ನು ಖಚಿತಪಡಿಸುತ್ತದೆ.',
      'cause': 'ಹೆಪಟೈಟಿಸ್ B ವೈರಸ್.',
      'prevention': '3 ಡೋಸ್ ವಾಕ್ಸಿನ್ ಸರಣಿಯನ್ನು ಪೂರ್ಣಗೊಳಿಸುವುದು.',
    },
  ];

  void sendSMS(BuildContext context, String message) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: '7892942557', // ರೋಗಿಯ ಫೋನ್ ಸಂಖ್ಯೆಯನ್ನು ಬದಲಾಯಿಸಿ
      queryParameters: {'body': message},
    );
    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        throw 'SMS ಅಪ್ಲಿಕೇಶನ್ ಅನ್ನು ಪ್ರಾರಂಭಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SMS ಕಳುಹಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue.shade900),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'ಗರ್ಭಿಣಿ ವಾಕ್ಸಿನೇಶನ್ ಮಾರ್ಗದರ್ಶಿ',
          style: TextStyle(color: Colors.blue.shade900),
        ),
        backgroundColor: Colors.orange.shade100,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: vaccinations.length,
          itemBuilder: (context, index) {
            final v = vaccinations[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              color: Colors.white.withOpacity(0.9),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange.shade200,
                  child: Icon(Icons.vaccines, color: Colors.orange[900]),
                ),
                title: Text(
                  '${v['name']} (${v['month']})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                subtitle: Text(
                  'ಹೆಚ್ಚಿನ ಮಾಹಿತಿಗೆ ಟ್ಯಾಪ್ ಮಾಡಿ',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                  ),
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15), // ವಕ್ರ ಪೆಟ್ಟಿಗೆ
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
                            children: [
                              TextSpan(text: "ವಿವರಣೆ: ", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: v['description']),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
                            children: [
                              TextSpan(text: "ಕಾರಣ: ", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: v['cause']),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
                            children: [
                              TextSpan(text: "ತಡೆಗಟ್ಟುವಿಕೆ: ", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: v['prevention']),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              // ರೋಗಿಗೆ ಸಾಮಾನ್ಯ SMS ಕಳುಹಿಸುವುದು
                              final msg = 'ನೆನಪಿಸಿಸುವಿಕೆ: ${v['name']} ಅಂದಾಜು ${v['month']} ಗೆ ನಿರ್ಧರಿಸಲ್ಪಟ್ಟಿದೆ.';
                              sendSMS(context, msg);

                              // ಖಚಿತಪಡಿಸುವ ಸಂದೇಶ ತೋರಿಸುವುದು
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('ನೆನಪಿಸಿಸುವಿಕೆ ಯಶಸ್ವಿಯಾಗಿ ಕಳುಹಿಸಲ್ಪಟ್ಟಿದೆ!')),
                              );
                            },
                            icon: Icon(Icons.alarm),
                            label: Text(
                              'ನನಗೆ ನೆನಪಿಸಿಸು',
                              style: TextStyle(color: Colors.orange[900]),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade100,
                              foregroundColor: Colors.orange[900],
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}