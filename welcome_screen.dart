import 'package:flutter/material.dart';
import 'package:maternalhealthcareapp/WELCOME_SCREEN/chatbot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this import for Google Fonts

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _selectedLanguage = 'English';

  final Map<String, String> _languageMap = {
    'English': 'Get Started',
    'हिंदी': 'शुरू करें',
    'ಕನ್ನಡ': 'ಪ್ರಾರಂಭಿಸಿ',
    'मराठी': 'सुरू करा',
  };

  final Map<String, String> _languageRoutes = {
    'English': '/pre_dashboard',
    'हिंदी': '/pre_dashboardh',
    'ಕನ್ನಡ': '/pre_dashboardk',
    'मराठी': '/pre_dashboardm',
  };

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  void _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString('language') ?? 'English';
    setState(() {
      _selectedLanguage = savedLang;
    });
  }

  void _setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
    setState(() {
      _selectedLanguage = lang;
    });
  }

  void _showLanguageMenu(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(overlay.size.width - 50, 80, 20, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: _languageMap.keys.map((lang) {
        return PopupMenuItem<String>(
          value: lang,
          child: Text(
            lang,
            style: GoogleFonts.quicksand(
              color: Colors.pink.shade900,
              fontSize: 16,
            ),
          ),
        );
      }).toList(),
    ).then((value) {
      if (value != null && _languageMap.containsKey(value)) {
        _setLanguage(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background.jpg'), // Replace with your image path
                fit: BoxFit.cover, // Ensures the image covers the entire screen
              ),
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon/icon.gif',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 10),
                Text(
                  "Chiguru",
                  style: GoogleFonts.quicksand(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0D70A1),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Ensuring safety for moms & babies.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 1, 85, 127),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 139, 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      _languageRoutes[_selectedLanguage]!,
                    );
                  },
                  child: Text(
                    _languageMap[_selectedLanguage]!,
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Language selector at top-right
          Positioned(
            top: 40,
            right: 20,
            child: InkWell(
              onTap: () => _showLanguageMenu(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 139, 12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedLanguage,
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // About button
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  );
                },
                child: Text(
                  "About",
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 243, 139, 12),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pink.shade900,
      ),
      backgroundColor: Colors.pink.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Maternal Healthcare App",
              style: GoogleFonts.quicksand(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade900,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Ensuring safety and care for mothers and babies.",
              style: GoogleFonts.quicksand(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const Divider(height: 30),
            Text(
              "Key Features:",
              style: GoogleFonts.quicksand(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade900,
              ),
            ),
            const SizedBox(height: 10),
            _buildFeature("User Management & Profiles",
                "Separate profiles for mothers and doctors."),
            _buildFeature("Multi-Language Support",
                "Supports English, Kannada, Hindi, Marathi."),
            _buildFeature("Vaccination Tracking & Scheduling",
                "Timely reminders for vaccinations."),
            _buildFeature("AI-Based Health Monitoring",
                "Tracks BP, weight, symptoms, and postpartum recovery."),
            _buildFeature("Doctor & Hospital Integration",
                "Book appointments and e-prescriptions."),
            _buildFeature("Emergency Support",
                "Quick SOS calls, hospital locators, and community support."),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• $title",
            style: GoogleFonts.quicksand(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
