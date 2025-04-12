import 'package:flutter/material.dart';

class DoctorAppointment extends StatelessWidget {
  const DoctorAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(), // Set HomeScreen as the initial page
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: Colors.pink[50],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DateAndTimePicker(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink[900],
            foregroundColor: Colors.white,
          ),
          child: Text('Go to Doctor Appointment'),
        ),
      ),
    );
  }
}

class DateAndTimePicker extends StatefulWidget {
  const DateAndTimePicker({super.key});

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
      // Show an error message if any field is missing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all the details.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Navigate to the new page to display saved details
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SavedDetailsPage(
            doctorName: 'Dr. ${doctorNameController.text}',
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
        title: Text('Doctor Appointment'),
        backgroundColor: Colors.pink[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Container(
        color: Colors.pink[50],
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Select Date and Time',
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
                      labelText: 'Doctor Name',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.pink[100],
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: hospitalNameController,
                    decoration: InputDecoration(
                      labelText: 'Hospital Name',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.pink[100],
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Align buttons to left and right
                    children: [
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[900],
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Select Date'),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectTime(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[900],
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Select Time'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _saveDetails(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[900],
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Save Details'),
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

  const SavedDetailsPage({super.key, 
    required this.doctorName,
    required this.hospitalName,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Details'),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        color: Colors.pink[50],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Doctor Name: $doctorName',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.pink[900],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Hospital Name: $hospitalName',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.pink[900],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Selected Date: ${selectedDate.toLocal().toString().split(' ')[0]}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.pink[900],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Selected Time: ${selectedTime.format(context)}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.pink[900],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(
                context); // Navigate back to the Doctor Appointment page
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink[900],
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50), // Full-width button
          ),
          child: Text('Go to Home Screen'),
        ),
      ),
    );
  }
}
