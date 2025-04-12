import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TimePageh extends StatefulWidget {
  final String doctorName;
  final String doctorPhone;

  TimePageh({required this.doctorName, required this.doctorPhone});

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePageh> {
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  void _sendSMS() async {
    final time = _timeController.text;
    final message =
        'नमस्ते डॉ. ${widget.doctorName}, मैं $time पर एक अपॉइंटमेंट लेना चाहता/चाहती हूँ।';

    final url =
        'sms:${widget.doctorPhone}?body=${Uri.encodeComponent(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // त्रुटि को संभालें, शायद एक डायलॉग या स्नैकबार दिखाएँ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('एसएमएस ऐप लॉन्च नहीं किया जा सका।')),
      );
      throw 'लॉन्च नहीं कर सका: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('अपॉइंटमेंट शेड्यूल करें'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'पसंदीदा समय दर्ज करें',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendSMS,
              child: Text('अपॉइंटमेंट अनुरोध भेजें'),
            ),
          ],
        ),
      ),
    );
  }
}
