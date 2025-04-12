import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'गर्भावस्थेतील लसीकरण मार्गदर्शक',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: VaccinationPagem(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VaccinationPagem extends StatelessWidget {
  final List<Map<String, String>> vaccinations = [
    {
      'month': 'महिना १',
      'name': 'हिपॅटायटिस बी (पहिली मात्रा)',
      'description': 'हिपॅटायटिस बी चा आईपासून बाळामध्ये होणारा संसर्ग रोखतो.',
      'cause': 'हिपॅटायटिस बी विषाणूमुळे होते.',
      'prevention': 'लसीकरण, संक्रमित रक्तापासून दूर राहणे.',
    },
    {
      'month': 'महिना २',
      'name': 'हिपॅटायटिस बी (दुसरी मात्रा)',
      'description': 'सुरक्षिततेसाठी दुसरी मात्रा आवश्यक आहे.',
      'cause': 'हिपॅटायटिस बी विषाणूमुळे होते.',
      'prevention': 'वेळेवर लसीकरण आणि स्वच्छता.',
    },
    {
      'month': 'महिना ३',
      'name': 'इन्फ्लूएंझा (फ्लू)',
      'description': 'गर्भवती महिलांना फ्लूपासून संरक्षण.',
      'cause': 'इन्फ्लूएंझा विषाणू, हवेतून पसरणारा.',
      'prevention': 'प्रत्येक वर्षी लस, मास्क वापरणे व स्वच्छता.',
    },
    {
      'month': 'महिना ४',
      'name': 'न्यूमोकॉकल लस',
      'description': 'न्युमोनिया व मेंदूज्वरापासून संरक्षण.',
      'cause': 'स्ट्रेप्टोकोकस न्यूमोनिया बॅक्टेरिया.',
      'prevention': 'लसीकरण व श्वसन संसर्ग टाळणे.',
    },
    {
      'month': 'महिना ५',
      'name': 'मेनिंजोकॉकल लस',
      'description': 'मेंदूज्वर व रक्तातील संसर्ग रोखते.',
      'cause': 'नायसिरीया मेनिंजिटिडीस बॅक्टेरिया.',
      'prevention': 'लसीकरण, भांडी शेअर करणे टाळा, स्वच्छता.',
    },
    {
      'month': 'महिना ६',
      'name': 'टीडीएपी (टिटॅनस, डिफ्थीरिया, पर्टुसिस)',
      'description': 'आई व बाळाला टिटॅनस, डिफ्थीरिया व खोकल्यापासून संरक्षण.',
      'cause': 'जखम किंवा हवेमार्फत पसरणारे बॅक्टेरिया.',
      'prevention': 'प्रत्येक गर्भधारणेत लसीकरण आवश्यक.',
    },
    {
      'month': 'महिना ७',
      'name': 'इन्फ्लूएंझा (दुसरी मात्रा)',
      'description': 'गर्भधारणेच्या उत्तर टप्प्यात फ्लूपासून अधिक संरक्षण.',
      'cause': 'इन्फ्लूएंझा विषाणू.',
      'prevention': 'बूस्टर लस, आजारी लोकांपासून अंतर ठेवा.',
    },
    {
      'month': 'महिना ८',
      'name': 'हिपॅटायटिस ए',
      'description': 'अस्वच्छ पाणी व अन्नामुळे होणाऱ्या यकृताच्या संसर्गापासून संरक्षण.',
      'cause': 'हिपॅटायटिस ए विषाणू.',
      'prevention': 'लसीकरण, स्वच्छ अन्न व पाणी.',
    },
    {
      'month': 'महिना ९',
      'name': 'हिपॅटायटिस बी (तिसरी मात्रा)',
      'description': 'हिपॅटायटिस बी पासून पूर्ण संरक्षणासाठी अंतिम मात्रा.',
      'cause': 'हिपॅटायटिस बी विषाणू.',
      'prevention': '३ मात्रा पूर्ण करणे आवश्यक.',
    },
  ];

  void sendSMS(BuildContext context, String message) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: '7892942557', // रुग्णाचा फोन नंबर येथे द्या
      queryParameters: {'body': message},
    );
    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        throw 'एसएमएस अ‍ॅप उघडता आला नाही';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('एसएमएस पाठवता आला नाही.')),
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
          'गर्भावस्थेतील लसीकरण मार्गदर्शक',
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
                  'अधिक माहितीसाठी टॅप करा',
                  style: TextStyle(color: Colors.blue.shade900),
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
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
                              TextSpan(text: "वर्णन: ", style: TextStyle(fontWeight: FontWeight.bold)),
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
                              TextSpan(text: "प्रतिबंध: ", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: v['prevention']),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final msg = 'स्मरणपत्र: ${v['name']} हे ${v['month']} साठी नियोजित आहे.';
                              sendSMS(context, msg);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('स्मरणपत्र यशस्वीरित्या पाठवले!')),
                              );
                            },
                            icon: Icon(Icons.alarm),
                            label: Text(
                              'स्मरणपत्र पाठवा',
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
