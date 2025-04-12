import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';

class MedicalGraphPage extends StatefulWidget {
  @override
  _MedicalGraphPageState createState() => _MedicalGraphPageState();
}

class _MedicalGraphPageState extends State<MedicalGraphPage> {
  List<HeartRateData> fetalHeartRateData = [];
  List<HeartRateData> motherHeartRateData = [];
  List<BPData> bloodPressureData = [];
  Timer? _updateTimer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isFetalAlertActive = false;
  bool _isMaternalAlertActive = false;
  bool _isBPAlertActive = false;
  bool _isSoundPlaying = false;

  // Emergency contacts
  List<String> emergencyContacts = [
    '+917892942557',
  ];

  // Twilio credentials
  final String twilioAccountSid = 'ACae92fee9e19e2f5785d302a254cb5d06';
  final String twilioAuthToken = '1bf24b57e9bdc2b5ed4d9954eb46f186';
  final String twilioPhoneNumber = '+917892942557';

  final TextEditingController _fetalHeartRateController =
      TextEditingController();
  final TextEditingController _motherHeartRateController =
      TextEditingController();
  final TextEditingController _bpSystolicController = TextEditingController();
  final TextEditingController _bpDiastolicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((_) {
      _isSoundPlaying = false;
      if (_isFetalAlertActive || _isMaternalAlertActive || _isBPAlertActive) {
        _playAlertSound();
      }
    });
    _startContinuousUpdates();
  }

  void _startContinuousUpdates() {
    _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (fetalHeartRateData.isNotEmpty) {
          final lastFetal = fetalHeartRateData.last;
          fetalHeartRateData.add(HeartRateData(
            time: DateTime.now(),
            rate: lastFetal.rate,
          ));
        }

        if (motherHeartRateData.isNotEmpty) {
          final lastMaternal = motherHeartRateData.last;
          motherHeartRateData.add(HeartRateData(
            time: DateTime.now(),
            rate: lastMaternal.rate,
          ));
        }

        if (bloodPressureData.isNotEmpty) {
          final lastBP = bloodPressureData.last;
          bloodPressureData.add(BPData(
            time: DateTime.now(),
            systolic: lastBP.systolic,
            diastolic: lastBP.diastolic,
          ));
        }

        if (fetalHeartRateData.length > 100) {
          fetalHeartRateData.removeAt(0);
          motherHeartRateData.removeAt(0);
          bloodPressureData.removeAt(0);
        }
      });
    });
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    _audioPlayer.dispose();
    _fetalHeartRateController.dispose();
    _motherHeartRateController.dispose();
    _bpSystolicController.dispose();
    _bpDiastolicController.dispose();
    super.dispose();
  }

  Future<void> _playAlertSound() async {
    if (!_isSoundPlaying) {
      _isSoundPlaying = true;
      try {
        await _audioPlayer.play(AssetSource('sounds/alert.mp3'));
      } catch (e) {
        print('Error playing sound: $e');
        _isSoundPlaying = false;
      }
    }
  }

  Future<void> _stopAlertSound() async {
    try {
      await _audioPlayer.stop();
      _isSoundPlaying = false;
    } catch (e) {
      print('Error stopping sound: $e');
    }
  }

  Future<void> _sendEmergencySMS(String message) async {
    final url = Uri.parse(
      'https://api.twilio.com/2010-04-01/Accounts/$twilioAccountSid/Messages.json',
    );
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$twilioAccountSid:$twilioAuthToken'))}';

    for (final contact in emergencyContacts) {
      try {
        final response = await http.post(
          url,
          headers: {'Authorization': basicAuth},
          body: {
            'From': twilioPhoneNumber,
            'To': contact,
            'Body': message,
          },
        );

        if (response.statusCode == 201) {
          print('SMS sent to $contact');
        } else {
          print('Failed to send SMS to $contact: ${response.body}');
        }
      } catch (e) {
        print('Error sending SMS: $e');
      }
    }
  }

  void _triggerEmergencyProtocol(
      String parameterName, String value, String normalRange) {
    final message = 'EMERGENCY: $parameterName CRITICAL at $value '
        '(Normal range: $normalRange). Immediate medical attention required!';

    // Send SMS to all emergency contacts
    _sendEmergencySMS(message);

    // Play alert sound
    _playAlertSound();
  }

  void _addData() {
    if (_fetalHeartRateController.text.isNotEmpty &&
        _motherHeartRateController.text.isNotEmpty &&
        _bpSystolicController.text.isNotEmpty &&
        _bpDiastolicController.text.isNotEmpty) {
      final fetalRate = double.tryParse(_fetalHeartRateController.text) ?? 0;
      final maternalRate =
          double.tryParse(_motherHeartRateController.text) ?? 0;
      final systolic = double.tryParse(_bpSystolicController.text) ?? 0;
      final diastolic = double.tryParse(_bpDiastolicController.text) ?? 0;
      final now = DateTime.now();

      setState(() {
        fetalHeartRateData.add(HeartRateData(
          time: now,
          rate: fetalRate,
        ));

        motherHeartRateData.add(HeartRateData(
          time: now,
          rate: maternalRate,
        ));

        bloodPressureData.add(BPData(
          time: now,
          systolic: systolic,
          diastolic: diastolic,
        ));

        // Check for critical conditions
        _checkHealthParameters(fetalRate, maternalRate, systolic, diastolic);

        _fetalHeartRateController.clear();
        _motherHeartRateController.clear();
        _bpSystolicController.clear();
        _bpDiastolicController.clear();
      });
    }
  }

  void _checkHealthParameters(double fetalRate, double maternalRate,
      double systolic, double diastolic) {
    // Check fetal heart rate
    if (fetalRate < 110 || fetalRate > 160) {
      if (!_isFetalAlertActive) {
        _isFetalAlertActive = true;
        _triggerEmergencyProtocol('Fetal heart rate',
            '${fetalRate.toStringAsFixed(0)} bpm', '110-160 bpm');
      }
    } else {
      _isFetalAlertActive = false;
    }

    // Check maternal heart rate
    if (maternalRate < 60 || maternalRate > 100) {
      if (!_isMaternalAlertActive) {
        _isMaternalAlertActive = true;
        _triggerEmergencyProtocol('Maternal heart rate',
            '${maternalRate.toStringAsFixed(0)} bpm', '60-100 bpm');
      }
    } else {
      _isMaternalAlertActive = false;
    }

    // Check blood pressure
    if (systolic < 90 || systolic > 140 || diastolic < 60 || diastolic > 90) {
      if (!_isBPAlertActive) {
        _isBPAlertActive = true;
        _triggerEmergencyProtocol(
            'Blood pressure',
            '${systolic.toStringAsFixed(0)}/${diastolic.toStringAsFixed(0)} mmHg',
            '90-140/60-90 mmHg');
      }
    } else {
      _isBPAlertActive = false;
    }

    // Stop alert if all parameters are normal
    if (!_isFetalAlertActive && !_isMaternalAlertActive && !_isBPAlertActive) {
      _stopAlertSound();
    }
  }

  Widget _buildCurrentReadingsCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Readings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
                'Fetal Heart Rate: ${fetalHeartRateData.isNotEmpty ? fetalHeartRateData.last.rate.toStringAsFixed(1) : 'N/A'} bpm'),
            Text(
                'Maternal Heart Rate: ${motherHeartRateData.isNotEmpty ? motherHeartRateData.last.rate.toStringAsFixed(1) : 'N/A'} bpm'),
            Text(
                'Blood Pressure: ${bloodPressureData.isNotEmpty ? '${bloodPressureData.last.systolic.toStringAsFixed(1)}/${bloodPressureData.last.diastolic.toStringAsFixed(1)} mmHg' : 'N/A'}'),
          ],
        ),
      ),
    );
  }

  Widget _buildInputForm() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Input Readings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _fetalHeartRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Fetal Heart Rate (bpm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _motherHeartRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Maternal Heart Rate (bpm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bpSystolicController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Systolic BP (mmHg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bpDiastolicController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Diastolic BP (mmHg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addData,
              child: Text('Add Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 243, 139, 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalGraphCard({
    required String title,
    required String unit,
    required double minY,
    required double maxY,
    required RangeValues normalRange,
    required Color dangerColor,
    required List<LineSeries<dynamic, DateTime>> series,
    required bool isAlertActive,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SfCartesianChart(
              primaryXAxis: DateTimeAxis(),
              primaryYAxis: NumericAxis(
                minimum: minY,
                maximum: maxY,
                axisLine: const AxisLine(width: 0),
                majorGridLines: const MajorGridLines(width: 0.5),
              ),
              series: series,
            ),
            if (isAlertActive)
              Text(
                'ALERT: $title is out of normal range!',
                style:
                    TextStyle(color: dangerColor, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Monitoring Dashboard'),
        backgroundColor: const Color.fromARGB(255, 243, 139, 12),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildInputForm(),
              _buildMedicalGraphCard(
                title: 'FETAL HEART RATE',
                unit: 'bpm',
                minY: 100,
                maxY: 180,
                normalRange: const RangeValues(110, 160),
                dangerColor: const Color.fromARGB(255, 243, 139, 12),
                series: [
                  LineSeries<HeartRateData, DateTime>(
                    dataSource: fetalHeartRateData,
                    xValueMapper: (HeartRateData data, _) => data.time,
                    yValueMapper: (HeartRateData data, _) => data.rate,
                    color: const Color.fromARGB(255, 0, 5, 9),
                    width: 2,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                ],
                isAlertActive: _isFetalAlertActive,
              ),
              _buildMedicalGraphCard(
                title: 'MATERNAL HEART RATE',
                unit: 'bpm',
                minY: 50,
                maxY: 120,
                normalRange: const RangeValues(60, 100),
                dangerColor: const Color.fromARGB(255, 243, 139, 12),
                series: [
                  LineSeries<HeartRateData, DateTime>(
                    dataSource: motherHeartRateData,
                    xValueMapper: (HeartRateData data, _) => data.time,
                    yValueMapper: (HeartRateData data, _) => data.rate,
                    color: Colors.green,
                    width: 2,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                ],
                isAlertActive: _isMaternalAlertActive,
              ),
              _buildMedicalGraphCard(
                title: 'BLOOD PRESSURE',
                unit: 'mmHg',
                minY: 40,
                maxY: 180,
                normalRange: const RangeValues(90, 140),
                dangerColor: const Color.fromARGB(255, 243, 139, 12),
                series: [
                  LineSeries<BPData, DateTime>(
                    dataSource: bloodPressureData,
                    xValueMapper: (BPData data, _) => data.time,
                    yValueMapper: (BPData data, _) => data.systolic,
                    name: 'Systolic',
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 2,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                  LineSeries<BPData, DateTime>(
                    dataSource: bloodPressureData,
                    xValueMapper: (BPData data, _) => data.time,
                    yValueMapper: (BPData data, _) => data.diastolic,
                    name: 'Diastolic',
                    color: Colors.purple,
                    width: 2,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                ],
                isAlertActive: _isBPAlertActive,
              ),
              _buildCurrentReadingsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeartRateData {
  final DateTime time;
  final double rate;

  HeartRateData({required this.time, required this.rate});
}

class BPData {
  final DateTime time;
  final double systolic;
  final double diastolic;

  BPData({required this.time, required this.systolic, required this.diastolic});
}
