import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maternalhealthcareapp/AUTHENTICATION/login_page.dart';
import 'package:maternalhealthcareapp/AUTHENTICATION/profile_display_page.dart';
import 'package:maternalhealthcareapp/WELCOME_SCREEN/chatbot.dart';
import 'package:maternalhealthcareapp/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'profile_modal.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? _profileData; // To store profile data from Supabase
  bool _isLoading = true; // To handle loading state

  @override
  void initState() {
    super.initState();
    _fetchProfileData(); // Fetch profile data when the screen loads
  }

  // Fetch profile data from Supabase
  Future<void> _fetchProfileData() async {
    try {
      final session = supabaseClient.auth.currentSession;
      if (session != null) {
        final userId = session.user!.id;

        // Fetch profile data from the 'profiles' table
        final response = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', userId)
            .single();

        setState(() {
          _profileData = Map<String, dynamic>.from(response);
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching profile data: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Logout functionality
  Future<void> _logout() async {
    try {
      await supabaseClient.auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => LoginPage()), // Replace with your login page
      );
    } catch (e) {
      print("Error logging out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to logout. Please try again.')),
      );
    }
  }

  List<Map<String, dynamic>> get options => [
        {
          'title': 'Health Monitoring',
          'imagePath': 'assets/images/health_monitoring.png',
          'route': '/healthMonitoring'
        },
        {
          'title': 'Fetal Position \n Dectection',
          'imagePath': 'assets/images/fetal.png',
          'route': '/ml'
        },
        {
          'title': 'Diet',
          'imagePath': 'assets/images/diet.png',
          'route': '/diet'
        },
        {
          'title': 'Excercise',
          'imagePath': 'assets/images/exercise.png',
          'route': '/exercise'
        },
        {
          'title': 'Prescription',
          'imagePath': 'assets/images/prescription.png',
          'route': '/firstpage'
        },
        {
          'title': 'Vaccination',
          'imagePath': 'assets/images/vaccination.png',
          'route': '/vaccine'
        },
        {'title': 'SOS', 'imagePath': 'assets/images/sos.png', 'route': '/sos'},
        {
          'title': 'Call Doctor/ Nurse',
          'imagePath': 'assets/images/call_doctor_nurse.png',
          'route': '/doctorCall'
        },
        {
          'title': 'Library',
          'imagePath': 'assets/images/library.png',
          'route': '/weeklyUpdates'
        },
        {
          'title': 'FAQ',
          'imagePath': 'assets/images/future_updates.png',
          'route': '/faq'
        },
        {
          'title': 'Doctor \n Appointment',
          'imagePath': 'assets/images/doctor_appointment.png',
          'route': '/doctor_list'
        },
        {
          'title': 'Government \n Schemes',
          'imagePath': 'assets/images/doctor_appointment.png',
          'route': '/schemes'
        },
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hi, User!",
                        style: GoogleFonts.quicksand(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 1, 113, 128),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.account_circle,
                            size: 40,
                            color: const Color.fromARGB(255, 1, 113, 128)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileDisplayPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      15, 0, 15, 80), // Added bottom padding for the button
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                    ),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, options[index]['route']);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                options[index]['imagePath'],
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue.shade200.withOpacity(0.3),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, options[index]['route']);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.white10.withOpacity(0.8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                    ),
                                    child: Text(
                                      options[index]['title'],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Floating Chatbot Button
          Positioned(
            bottom: 30, // Adjust this value to lift it up from the very bottom
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              child: Container(
                width: 70, // Slightly larger for better visibility
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/chatbot_icon.png'),
                    fit: BoxFit.contain,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
