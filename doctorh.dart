import 'package:flutter/material.dart';

class DoctorAppointmenth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DateAndTimePicker(),
    );
  }
}

class DateAndTimePicker extends StatefulWidget {
  @override
  _DateAndTimePickerState createState() => _DateAndTimePickerState();
}

class _DateAndTimePickerState extends State<DateAndTimePicker> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController hospitalNameController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _saveDetails(BuildContext context) {
    if (doctorNameController.text.isEmpty ||
        hospitalNameController.text.isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('कृपया सभी विवरण भरें।'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SavedDetailsPage(
            doctorName: 'डॉ. ${doctorNameController.text}',
            hospitalName: hospitalNameController.text,
            selectedDate: selectedDate!,
            selectedTime: selectedTime!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("डॉक्टर की नियुक्ति"),
        backgroundColor: Colors.pink.shade900,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.pink.shade50,
      body: Container(
        color: Colors.pink[50],
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'तारीख और समय चुनें',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[900],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: doctorNameController,
                    decoration: InputDecoration(
                      labelText: 'डॉक्टर का नाम',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      fillColor: Colors.pink[100],
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: hospitalNameController,
                    decoration: InputDecoration(
                      labelText: 'अस्पताल का नाम',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      fillColor: Colors.pink[100],
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[900],
                    foregroundColor: Colors.white,
                  ),
                  child: Text('तारीख चुनें'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[900],
                    foregroundColor: Colors.white,
                  ),
                  child: Text('समय चुनें'),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _saveDetails(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[900],
                    foregroundColor: Colors.white,
                  ),
                  child: Text('विवरण सहेजें'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SavedDetailsPage extends StatelessWidget {
  final String doctorName;
  final String hospitalName;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  SavedDetailsPage({
    required this.doctorName,
    required this.hospitalName,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('सहेजे गए विवरण'),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        color: Colors.pink[50],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'डॉक्टर का नाम: $doctorName',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.pink[900],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'अस्पताल का नाम: $hospitalName',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.pink[900],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'चयनित तारीख: ${selectedDate.toLocal().toString().split(' ')[0]}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.pink[900],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'चयनित समय: ${selectedTime.format(context)}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.pink[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
