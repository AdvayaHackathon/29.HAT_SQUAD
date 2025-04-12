import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:maternalhealthcareapp/DASHBOARDENGLISH/dashboard_screen.dart';
import 'package:maternalhealthcareapp/DASHBOARDENGLISH/health_monitoring.dart';
import 'AUTHENTICATION/profile_page.dart';
import 'DASHBOARDENGLISH/doctorinterface.dart';

class PreDashboardPage extends StatelessWidget {
  const PreDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100, // Plain orange background
      body: Stack(
        children: [
          // Main Content
          Column(
            children: [
              // Back Arrow Button at the Top-Left Corner
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 350),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      color: const Color.fromARGB(255, 1, 113, 128)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              // "Tell us about yourself" Text
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  'Tell us about\n   yourself!!',
                  style: GoogleFonts.quicksand(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(
                        255, 1, 113, 128), // Darker pink color for the text
                  ),
                ),
              ),

              // Centered Buttons
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Doctor Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorInterfacePage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                          minimumSize: const Size(350, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/doctor_icon.png', // Correct path
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              'I am a Doctor',
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                                color: Colors.pink[900],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Pregnant Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                          minimumSize: const Size(350, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/patient_icon.png', // Correct path
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              'I am Pregnant',
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                                color: Colors.pink[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
