import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TimePagem extends StatefulWidget {
  final String doctorName;
  final String doctorPhone;

  TimePagem({required this.doctorName, required this.doctorPhone});

  @override
  _TimePagemState createState() => _TimePagemState();
}

class _TimePagemState extends State<TimePagem> {
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  void _sendSMS() async {
    final time = _timeController.text;
    final message =
        'नमस्कार डॉ. ${widget.doctorName}, मी $time वाजता अपॉइंटमेंट बुक करू इच्छितो/इच्छिते.';

    final url =
        'sms:${widget.doctorPhone}?body=${Uri.encodeComponent(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // त्रुटी हाताळा, उदाहरणार्थ, डायलॉग किंवा स्नॅकबार दाखवा
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SMS अ‍ॅप उघडता आले नाही.')),
      );
      throw 'दिलेल्या URL ला उघडता आले नाही $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('अपॉइंटमेंट शेड्यूल करा'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'इच्छित वेळ',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendSMS,
              child: Text('अपॉइंटमेंट विनंती पाठवा'),
            ),
          ],
        ),
      ),
    );
  }
}
