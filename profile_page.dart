import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maternalhealthcareapp/AUTHENTICATION/profile_display_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../DASHBOARDENGLISH/dashboard_screen.dart';

class PregnantProfilePage extends StatefulWidget {
  @override
  _PregnantProfilePageState createState() => _PregnantProfilePageState();
}

class _PregnantProfilePageState extends State<PregnantProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  DateTime? _dateOfBirth;
  String? _contact;

  // List of avatar image paths
  final List<String> _avatarImages = [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
    'assets/images/avatar4.png',
    'assets/images/avatar5.png',
  ];

  // Randomly selected avatar image
  late String _selectedAvatar;

  @override
  void initState() {
    super.initState();
    // Randomly select an avatar on initialization
    _selectedAvatar = _avatarImages[Random().nextInt(_avatarImages.length)];
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final response = await Supabase.instance.client
            .from('profiles') // Replace with your actual table name
            .insert({
          'name': _name,
          'dob': _dateOfBirth?.toIso8601String(),
          'contact': _contact,
        });
        

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Profile saved successfully."),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(20),
            duration: Duration(seconds: 2),
          ),
        );

        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => ProfileDisplayPage()),
          );
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error saving profile: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _dateOfBirth) {
      setState(() {
        _dateOfBirth = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Container(
              padding: const EdgeInsets.only(
                  top: 40, left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.pink[900]),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Create your profile',
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[900],
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            // Profile Avatar Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(_selectedAvatar),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Profile Picture',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      color: Colors.pink[900],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Form Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personal Information',
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink[900],
                              ),
                            ),
                            SizedBox(height: 10),
                            _buildTextField(
                              'Full Name',
                              (val) => _name = val,
                              hintText: 'Enter your full name',
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Please enter your name'
                                  : null,
                            ),
                            _buildDatePickerField(
                              'Date of Birth',
                              (val) => _dateOfBirth = val,
                            ),
                            _buildTextField(
                              'Contact Number',
                              (val) => _contact = val,
                              hintText: 'Enter your contact number',
                              keyboardType: TextInputType.phone,
                              validator: (val) => val == null || val.length < 10
                                  ? 'Please enter a valid contact number'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _saveProfile,
                        icon: Icon(Icons.save),
                        label: Text(
                          'Save Profile',
                          style: GoogleFonts.quicksand(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink.shade100,
                          foregroundColor: Colors.pink[900],
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    Function(String) onSaved, {
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
        keyboardType: keyboardType,
        validator: validator,
        onSaved: (val) => onSaved(val!),
        style: GoogleFonts.quicksand(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  Widget _buildDatePickerField(String label, Function(DateTime?) onSaved) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () => _selectDate(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _dateOfBirth != null
                    ? "${_dateOfBirth!.day}-${_dateOfBirth!.month}-${_dateOfBirth!.year}"
                    : "Select your date of birth",
                style:
                    GoogleFonts.quicksand(fontSize: 14, color: Colors.black87),
              ),
              Icon(Icons.calendar_today, color: Colors.pink[900]),
            ],
          ),
        ),
      ),
    );
  }
}

extension on PostgrestFilterBuilder {
  execute() {}
}
