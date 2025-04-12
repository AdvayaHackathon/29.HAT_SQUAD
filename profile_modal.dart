import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileModal extends StatelessWidget {
  final Map<String, dynamic>? profileData;
  final bool isLoading;
  final VoidCallback onLogout;

  const ProfileModal({
    Key? key,
    required this.profileData,
    required this.isLoading,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: GoogleFonts.quicksand(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink[900],
              ),
            ),
            const SizedBox(height: 10),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (profileData == null)
              Text('No profile data found.')
            else ...[
              Text('Name: ${profileData!['name']}'),
              Text('Date of Birth: ${profileData!['dob']}'),
              Text('Contact: ${profileData!['contact']}'),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the modal
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                'Close',
                style: GoogleFonts.quicksand(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onLogout, // Logout functionality
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.quicksand(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}