import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HealthMonitoring extends StatefulWidget {
  const HealthMonitoring({super.key});

  @override
  _HealthMonitoringState createState() => _HealthMonitoringState();
}

class _HealthMonitoringState extends State<HealthMonitoring> {
  Map<String, TextEditingController> controllers = {
    "Fetal Heart Rate": TextEditingController(),
    "B.P": TextEditingController(),
    "Glucose (before food)": TextEditingController(),
    "Glucose (after food)": TextEditingController(),
    "SPO2": TextEditingController(),
  };

  List<String> emergencyContacts = [
    '+917892942557',
    '+919481032460',
    '+919606248727',
  ];

  bool isAnalysisAllowed = false;

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
              content: Text(
                "Invalid input for $key. Please enter a numeric value.",
                style: const TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.orange.shade100,
            ),
          );
        }
      }
    });
    return isValid;
  }

  Future<void> sendMessageAndCall(String message, List<String> contacts) async {
    const String accountSid = 'ACc5803bd29edc4747941e7f1b8d94d319';
    const String authToken = '70ca1c17732722dd814f6a7344d845f3';
    const String twilioNumber = '+18162969749';
    final String basicAuth = 'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}';

    for (String contact in contacts) {
      final smsResponse = await http.post(
        Uri.parse('https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json'),
        headers: {'Authorization': basicAuth},
        body: {
          'From': twilioNumber,
          'To': contact,
          'Body': message,
        },
      );

      final callResponse = await http.post(
        Uri.parse('https://api.twilio.com/2010-04-01/Accounts/$accountSid/Calls.json'),
        headers: {'Authorization': basicAuth},
        body: {
          'From': twilioNumber,
          'To': contact,
          'Url': 'http://demo.twilio.com/docs/voice.xml',
        },
      );
    }
  }

  Future<String> analyzeWithAI(Map<String, String> data) async {
    const String apiKey = 'uziKmpzc4aOCI1f2tIiUrjJGkqnPOXXpJHvc4hNv';
    const String apiUrl = 'https://api.cohere.ai/v1/generate';

    String prompt = "Analyze the following health data for a pregnant woman and predict if she has any disease:\n";
    data.forEach((key, value) {
      prompt += "$key: $value\n";
    });
    prompt += "Provide a 2-3 line analysis and prediction.";

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
      throw Exception('Failed to analyze data with Cohere: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0D70A1)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "UPDATE DETAILS",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Fetus Readings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFF0D70A1)),
            ),
            _buildInputBox("Fetal Heart Rate"),
            const SizedBox(height: 20),
            const Text(
              "Mother Readings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFF0D70A1)),
            ),
            ...["B.P", "Glucose (before food)", "Glucose (after food)", "SPO2"]
                .map((key) => _buildInputBox(key)),
            const SizedBox(height: 20),
            _buildActionButton("ENTER", () {
              if (validateInputs(context)) {
                Map<String, String> data = {};
                controllers.forEach((key, controller) {
                  data[key] = controller.text.trim();
                });

                double fetalHeartRate =
                    double.tryParse(controllers["Fetal Heart Rate"]!.text.trim()) ?? 0;
                if (fetalHeartRate < 110 || fetalHeartRate > 160) {
                  String message =
                      "Emergency: Fetal Heart Rate is $fetalHeartRate. Please check immediately!";
                  sendMessageAndCall(message, emergencyContacts);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Emergency calls and messages initiated!',
                        style: TextStyle(color: Color(0xFF0D70A1)),
                      ),
                      backgroundColor: Colors.orange[90],
                    ),
                  );
                  setState(() => isAnalysisAllowed = false);
                } else {
                  setState(() => isAnalysisAllowed = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'All readings are normal. You can analyze with AI.',
                        style: TextStyle(color: Colors.blue),
                      ),
                      backgroundColor: Colors.orange[100],
                    ),
                  );
                }
              }
            }),
            const SizedBox(height: 20),
            Visibility(
              visible: isAnalysisAllowed,
              child: _buildActionButton("ANALYZE WITH AI", () async {
                if (validateInputs(context)) {
                  Map<String, String> data = {};
                  controllers.forEach((key, controller) {
                    data[key] = controller.text.trim();
                  });
                  try {
                    String analysis = await analyzeWithAI(data);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnalysisPage(analysis: analysis),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to analyze data: $e',
                          style: const TextStyle(color: Color(0xFF0D70A1)),
                        ),
                        backgroundColor: Colors.orange[100],
                      ),
                    );
                  }
                }
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Color(0xFF0D70A1), size: 40),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.orange[100],
    );
  }

  Widget _buildInputBox(String key) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: controllers[key],
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.blue),
          decoration: InputDecoration(
            labelText: key,
            labelStyle: const TextStyle(color: Colors.blue),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Color(0xFF0D70A1), fontSize: 18),
      ),
    );
  }
}

class AnalysisPage extends StatelessWidget {
  final String analysis;
  const AnalysisPage({super.key, required this.analysis});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AI ANALYSIS",
          style: TextStyle(color: Color(0xFF0D70A1), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  analysis,
                  style: const TextStyle(fontSize: 18, color: Color(0xFF0D70A1)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'BACK',
                style: TextStyle(color: Color(0xFF0D70A1)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Color(0xFF0D70A1), size: 40),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.orange[100],
    );
  }
}
