import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'टीकाकरण मार्गदर्शिका',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: VaccinationPageh(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VaccinationPageh extends StatelessWidget {
  final List<Map<String, String>> vaccinations = [
    {
      'month': 'महीना 1',
      'name': 'हेपेटाइटिस B (पहली खुराक)',
      'description': 'हेपेटाइटिस B के माता से शिशु में संचरण को रोकता है।',
      'cause': 'हेपेटाइटिस B वायरस (HBV) के कारण।',
      'prevention': 'टीकाकरण, संक्रमित रक्त से संपर्क न करना।',
    },
    {
      'month': 'महीना 2',
      'name': 'हेपेटाइटिस B (दूसरी खुराक)',
      'description': 'दूसरी खुराक निरंतर सुरक्षा सुनिश्चित करती है।',
      'cause': 'हेपेटाइटिस B वायरस (HBV) के कारण।',
      'prevention': 'समय पर टीकाकरण और स्वच्छता।',
    },
    {
      'month': 'महीना 3',
      'name': 'इन्फ्लुएंजा (फ्लू)',
      'description': 'गर्भवती महिलाओं को मौसमी फ्लू से बचाता है।',
      'cause': 'इन्फ्लुएंजा वायरस, हवा में फैलने वाला और संक्रामक।',
      'prevention': 'वार्षिक टीकाकरण, मास्क का उपयोग और स्वच्छता।',
    },
    {
      'month': 'महीना 4',
      'name': 'न्यूमोकोकल वैक्सीन',
      'description': 'न्यूमोनिया और मेनिन्जाइटिस से बचाता है।',
      'cause': 'स्ट्रेप्टोकोकस न्यूमोनिया बैक्टीरिया।',
      'prevention': 'टीकाकरण और श्वसन संक्रमण से बचना।',
    },
    {
      'month': 'महीना 5',
      'name': 'मेनिंगोकोकल वैक्सीन',
      'description': 'मेनिन्जाइटिस और रक्तस्राव संक्रमण से बचाता है।',
      'cause': 'नाइसेरिया मेनिंगिटिडिस बैक्टीरिया।',
      'prevention': 'टीकाकरण, बर्तन साझा न करना, अच्छी स्वच्छता।',
    },
    {
      'month': 'महीना 6',
      'name': 'Tdap (टेटनस, डिप्थीरिया, पर्टुसिस)',
      'description': 'टेटनस, डिप्थीरिया और काली खांसी से माँ और बच्चे को बचाता है।',
      'cause': 'घावों या हवा के माध्यम से फैलने वाले बैक्टीरियल संक्रमण।',
      'prevention': 'प्रत्येक गर्भावस्था में टीकाकरण।',
    },
    {
      'month': 'महीना 7',
      'name': 'इन्फ्लुएंजा (दूसरी खुराक)',
      'description': 'गर्भावस्था के बाद के चरण में फ्लू सुरक्षा को बढ़ावा देता है।',
      'cause': 'इन्फ्लुएंजा वायरस।',
      'prevention': 'फ्लू की बूस्टर टीका, बीमार लोगों से दूर रहना।',
    },
    {
      'month': 'महीना 8',
      'name': 'हेपेटाइटिस A',
      'description': 'खराब स्वच्छता वाले क्षेत्रों में भोजनजन्य यकृत संक्रमण से बचाता है।',
      'cause': 'हेपेटाइटिस A वायरस।',
      'prevention': 'टीकाकरण, सुरक्षित भोजन और स्वच्छ पानी।',
    },
    {
      'month': 'महीना 9',
      'name': 'हेपेटाइटिस B (तीसरी खुराक)',
      'description': 'अंतिम खुराक हेपेटाइटिस B के खिलाफ पूर्ण सुरक्षा सुनिश्चित करती है।',
      'cause': 'हेपेटाइटिस B वायरस।',
      'prevention': '3 खुराक वाली टीका सीरीज़ पूरी करना।',
    },
  ];

  void sendSMS(BuildContext context, String message) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: '7892942557', // रोगी का फ़ोन नंबर बदलें
      queryParameters: {'body': message},
    );
    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        throw 'SMS एप्लिकेशन नहीं खोला जा सका';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SMS भेजने में असफल।')),
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
          'गर्भावस्था टीकाकरण मार्गदर्शिका',
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
                  'अधिक जानकारी के लिए टैप करें',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                  ),
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15), // वक्र बॉक्स
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
                              TextSpan(text: "विवरण: ", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: v['description']),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
                            children: [
                              TextSpan(text: "कारण: ", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: v['cause']),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
                            children: [
                              TextSpan(text: "रोकथाम: ", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: v['prevention']),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              // रोगी को SMS भेजें
                              final msg = 'याद दिलाना: ${v['name']} अनुमानित ${v['month']} के लिए निर्धारित है।';
                              sendSMS(context, msg);

                              // संदेश दिखाएं
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('याद दिलाना सफलतापूर्वक भेजा गया!')),
                              );
                            },
                            icon: Icon(Icons.alarm),
                            label: Text(
                              'मुझे याद दिलाएं',
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