import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TimePage extends StatefulWidget {
  final String doctorName;
  final String doctorPhone;

  const TimePage({super.key, required this.doctorName, required this.doctorPhone});

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  void _sendSMS() async {
    final time = _timeController.text;
    final message =
        'Hello Dr. ${widget.doctorName}, I would like to schedule an appointment at $time.';

    final url =
        'sms:${widget.doctorPhone}?body=${Uri.encodeComponent(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error, perhaps show a dialog or a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch SMS app.')),
      );
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'Preferred Time',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendSMS,
              child: Text('Send Appointment Request'),
            ),
          ],
        ),
      ),
    );
  }
}
