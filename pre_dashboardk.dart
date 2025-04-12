import 'package:flutter/material.dart';
import 'package:maternalhealthcareapp/AUTHENTICATION/login_page.dart';
import 'package:maternalhealthcareapp/DASHBOARDENGLISH/dashboard_screen.dart';
import 'package:maternalhealthcareapp/DASHBOARDKANNADA/dashboard_screenk.dart';
import 'DASHBOARDKANNADA/doctorinterfacek.dart'; // Import the DoctorInterfacePage

class PreDashboardPagek extends StatelessWidget {
  const PreDashboardPagek({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Remove the title by setting it to an empty Container
        title: Container(),
        backgroundColor:
            Colors.pink[50], // Set AppBar background color to light pink
      ),
      backgroundColor: Colors.pink[
          50], // Set the background color of the entire page to light pink
      body: Column(
        children: [
          // Add "Tell us about yourself" text at the lower top of the page
          Padding(
            padding:
                EdgeInsets.only(top: 50, bottom: 10), // Reduced bottom padding
            child: Text(
              'ನಿಮ್ಮ ಬಗ್ಗೆ ನಮಗೆ ತಿಳಿಸಿ!!',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.pink[800], // Darker pink color for the text
              ),
            ),
          ),
          // Center the buttons vertically
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Doctor Interface
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DoctorInterfacePagek()), // Updated line
                      );
                      print(
                          'ಡಾಕ್ಟರ್ ಇಂಟರ್ಫೇಸ್ಗೆ ನ್ಯಾವಿಗೇಟ್ ಆಗುತ್ತಿದೆ'); // Kannada print statement
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20), // Increased padding
                      minimumSize: Size(350, 80), // Larger button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Slightly larger border radius
                      ),
                      backgroundColor:
                          Colors.white, // Set button background color to white
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/doctor_icon.png', // Correct path
                          width: 100, // Larger image size
                          height: 100, // Larger image size
                        ),
                        SizedBox(
                            width:
                                15), // Increased space between image and text
                        Text(
                          'ನಾನು ಡಾಕ್ಟರ್',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.pink[
                                  900]), // Larger font size and pink text color
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30), // Increased space between buttons
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Patient Interface
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DashboardScreenK()), // Updated line
                      );
                      print(
                          'ರೋಗಿ ಇಂಟರ್ಫೇಸ್ಗೆ ನ್ಯಾವಿಗೇಟ್ ಆಗುತ್ತಿದೆ'); // Kannada print statement
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20), // Increased padding
                      minimumSize: Size(350, 80), // Larger button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Slightly larger border radius
                      ),
                      backgroundColor:
                          Colors.white, // Set button background color to white
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/patient_icon.png', // Correct path
                          width: 100, // Larger image size
                          height: 100, // Larger image size
                        ),
                        SizedBox(
                            width:
                                15), // Increased space between image and text
                        Text(
                          'ನಾನು ಗರ್ಭಿಣಿ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.pink[
                                  900]), // Larger font size and pink text color
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
    );
  }
}

class DoctorLoginPage extends StatelessWidget {
  const DoctorLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ಡಾಕ್ಟರ್ ಲಾಗಿನ್'),
      ),
      body: Center(
        child: Text('ಡಾಕ್ಟರ್ ಲಾಗಿನ್ ಪುಟ ವಿಷಯ'),
      ),
    );
  }
}

class PatientLoginPage extends StatelessWidget {
  const PatientLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ರೋಗಿ ಲಾಗಿನ್'),
      ),
      body: Center(
        child: Text('ರೋಗಿ ಲಾಗಿನ್ ಪುಟ ವಿಷಯ'),
      ),
    );
  }
}
