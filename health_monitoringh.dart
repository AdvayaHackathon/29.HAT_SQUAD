import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP requests for Twilio and Cohere
import 'dart:convert'; // JSON encoding/decoding

class HealthMonitoringh extends StatefulWidget {
  const HealthMonitoringh({super.key});

  @override
  _HealthMonitoringState createState() => _HealthMonitoringState();
}

class _HealthMonitoringState extends State<HealthMonitoringh> {
  // Controllers for input fields
  Map<String, TextEditingController> controllers = {
    "भ्रूण की हृदय गति": TextEditingController(),
    "रक्तचाप": TextEditingController(),
    "ग्लूकोज (भोजन से पहले)": TextEditingController(),
    "ग्लूकोज (भोजन के बाद)": TextEditingController(),
    "SPO2": TextEditingController(),
  };

  // Hardcoded emergency contacts
  List<String> emergencyContacts = [
    '+917892942557', // Replace with actual emergency contact numbers
    '+919481032460',
    '+919606248727',
  ];

  // State variable to track if analysis is allowed
  bool isAnalysisAllowed = false;

  // Function to validate inputs
  bool validateInputs(BuildContext context) {
    bool isValid = true;
    controllers.forEach((key, controller) {
      String value = controller.text.trim();
      if (value.isNotEmpty) {
        double? parsedValue = double.tryParse(value);
        if (parsedValue == null) {
          isValid = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$key के लिए अमान्य इनपुट। कृपया एक संख्यात्मक मान दर्ज करें।"),
            ),
          );
        }
      }
    });
    return isValid;
  }

  // Function to send message and make calls using Twilio
  Future<void> sendMessageAndCall(String message, List<String> contacts) async {
    const String accountSid = 'ACc5803bd29edc4747941e7f1b8d94d319'; // Replace with your Twilio SID
    const String authToken = '70ca1c17732722dd814f6a7344d845f3'; // Replace with your Twilio token
    const String twilioNumber = '+18162969749'; // Replace with your Twilio number
    final String basicAuth = 'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}';

    for (String contact in contacts) {
      // Send SMS
      final smsResponse = await http.post(
        Uri.parse('https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json'),
        headers: {'Authorization': basicAuth},
        body: {
          'From': twilioNumber,
          'To': contact,
          'Body': message,
        },
      );
      if (smsResponse.statusCode == 201) {
        print('SMS $contact को भेजा गया');
      } else {
        print('$contact को SMS भेजने में विफल: ${smsResponse.body}');
      }

      // Make a call
      final callResponse = await http.post(
        Uri.parse('https://api.twilio.com/2010-04-01/Accounts/$accountSid/Calls.json'),
        headers: {'Authorization': basicAuth},
        body: {
          'From': twilioNumber,
          'To': contact,
          'Url': 'http://demo.twilio.com/docs/voice.xml', // TwiML URL for call
        },
      );
      if (callResponse.statusCode == 201) {
        print('$contact को कॉल किया गया');
      } else {
        print('$contact को कॉल करने में विफल: ${callResponse.body}');
      }
    }
  }

  // Function to analyze data using Cohere API
  Future<String> analyzeWithAI(Map<String, String> data) async {
    const String apiKey = 'uziKmpzc4aOCI1f2tIiUrjJGkqnPOXXpJHvc4hNv'; // Replace with your Cohere API key
    const String apiUrl = 'https://api.cohere.ai/v1/generate';

    // Prepare the prompt for Cohere
    String prompt = "एक गर्भवती महिला के लिए निम्नलिखित स्वास्थ्य डेटा का विश्लेषण करें और भविष्यवाणी करें कि क्या उसे कोई बीमारी है:\n";
    data.forEach((key, value) {
      prompt += "$key: $value\n";
    });
    prompt += "2-3 पंक्तियों में विश्लेषण और भविष्यवाणी प्रदान करें।";

    // Make the API request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt': prompt,
        'max_tokens': 100,
        'temperature': 0.7,
        'model': 'command',
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['generations'][0]['text'].trim();
    } else {
      throw Exception('Cohere के साथ डेटा का विश्लेषण करने में विफल: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "विवरण अपडेट करें",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "भ्रूण के माप",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: controllers["भ्रूण की हृदय गति"],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "भ्रूण की हृदय गति",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "माँ के माप",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            ...["रक्तचाप", "ग्लूकोज (भोजन से पहले)", "ग्लूकोज (भोजन के बाद)", "SPO2"]
                .map((String key) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: controllers[key],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: key,
                    border: const OutlineInputBorder(),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (validateInputs(context)) {
                  // Collect data from input fields
                  Map<String, String> data = {};
                  controllers.forEach((key, controller) {
                    data[key] = controller.text.trim();
                  });

                  // Check fetal heart rate
                  double fetalHeartRate =
                      double.tryParse(controllers["भ्रूण की हृदय गति"]!.text.trim()) ?? 0;

                  if (fetalHeartRate < 110 || fetalHeartRate > 160) {
                    // Trigger emergency calls and messages
                    String message =
                        "आपातकाल: भ्रूण की हृदय गति $fetalHeartRate है। कृपया तुरंत जांच करें!";
                    sendMessageAndCall(message, emergencyContacts);

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('आपातकालीन कॉल और संदेश शुरू किए गए!')),
                    );

                    // Disable analysis
                    setState(() {
                      isAnalysisAllowed = false;
                    });
                  } else {
                    // Enable analysis
                    setState(() {
                      isAnalysisAllowed = true;
                    });

                    // Show normal readings message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('सभी माप सामान्य हैं। आप AI के साथ विश्लेषण कर सकते हैं।')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[900],
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'दर्ज करें',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: isAnalysisAllowed,
              child: ElevatedButton(
                onPressed: () async {
                  if (validateInputs(context)) {
                    // Collect data from input fields
                    Map<String, String> data = {};
                    controllers.forEach((key, controller) {
                      data[key] = controller.text.trim();
                    });

                    try {
                      // Analyze data with Cohere AI
                      String analysis = await analyzeWithAI(data);

                      // Navigate to AnalysisPage with the analysis result
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnalysisPage(analysis: analysis),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('डेटा का विश्लेषण करने में विफल: $e')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'AI के साथ विश्लेषण करें',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink[900],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white, size: 40),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.pink[50],
    );
  }
}

// AnalysisPage Widget
class AnalysisPage extends StatelessWidget {
  final String analysis;

  const AnalysisPage({super.key, required this.analysis});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AI विश्लेषण",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  analysis,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[900],
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'वापस',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink[900],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white, size: 40),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.pink[50],
    );
  }
}