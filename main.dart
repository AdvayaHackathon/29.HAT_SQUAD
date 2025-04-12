import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maternalhealthcareapp/AUTHENTICATION/login_page.dart';
import 'package:maternalhealthcareapp/DASHBOARDHINDI/dashboard_screenh.dart';
import 'package:maternalhealthcareapp/DASHBOARDHINDI/doctorh.dart';
import 'package:maternalhealthcareapp/pre_dashboardh.dart';
import 'package:maternalhealthcareapp/predashboardm.dart';
import 'package:maternalhealthcareapp/supabase_client.dart';
import 'package:maternalhealthcareapp/DASHBOARDKANNADA/dashboard_screenk.dart';
import 'package:maternalhealthcareapp/DASHBOARDKANNADA/dietk.dart';
import 'package:maternalhealthcareapp/DASHBOARDKANNADA/doctork.dart';
import 'package:maternalhealthcareapp/DASHBOARDKANNADA/exercisek.dart';
import 'package:maternalhealthcareapp/health_monitoringk.dart';
import 'package:maternalhealthcareapp/DASHBOARDKANNADA/sosk.dart';
import 'package:maternalhealthcareapp/DASHBOARDKANNADA/vaccinationk.dart';
import 'package:maternalhealthcareapp/DASHBOARDKANNADA/weekly_updates_screenk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'DASHBOARDENGLISH/faq.dart';
import 'DASHBOARDHINDI/doctorinterfaceh.dart';
import 'DASHBOARDHINDI/exerciseh.dart';
import 'DASHBOARDHINDI/faqh.dart';
import 'DASHBOARDHINDI/health_monitoringh.dart';
import 'DASHBOARDHINDI/sosh.dart';
import 'DASHBOARDHINDI/vaccinationh.dart';
import 'DASHBOARDKANNADA/faqk.dart';
import 'DASHBOARDMARATHI/dietm.dart';
import 'DASHBOARDMARATHI/faqm.dart';
import 'DASHBOARDMARATHI/health_monitoringm.dart';
import 'DASHBOARDMARATHI/vaccinationm.dart';
import 'WELCOME_SCREEN/welcome_screen.dart';
import 'DASHBOARDENGLISH/dashboard_screen.dart';
import 'DASHBOARDENGLISH/health_monitoring.dart';
import 'DASHBOARDENGLISH/weekly_updates_screen.dart';
import 'DASHBOARDENGLISH/doctor.dart';
import 'DASHBOARDENGLISH/sos.dart';
import 'DASHBOARDENGLISH/diet.dart';
import 'DASHBOARDENGLISH/vaccination.dart';
import 'DASHBOARDENGLISH/exercise.dart';
import 'DASHBOARDENGLISH/doctor_call.dart';
import 'doc_prescription/first_page.dart';
import 'WELCOME_SCREEN/chatbot.dart';
import 'firebase_options.dart';
import 'predashboard.dart';
import 'DASHBOARDENGLISH/doctorinterface.dart';
import 'doctorlist.dart';
import 'pre_dashboardk.dart';
import 'DASHBOARDHINDI/dieth.dart';
import 'DASHBOARDHINDI/doctorcallh.dart';
import 'DASHBOARDHINDI/sosh.dart';
import 'schemes.dart';
import 'ml.dart';
import 'DASHBOARDMARATHI/sosm.dart';
import 'DASHBOARDMARATHI/exercisem.dart';
import 'DASHBOARDMARATHI/doctorcallm.dart';

void main() async {
  // Ensure that the binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch available cameras
  List<CameraDescription> cameras = [];
  try {
    cameras = await availableCameras();
    print('Cameras fetched successfully');
  } catch (e) {
    print('Failed to fetch cameras: $e');
  }

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }

  // Initialize Supabase
  try {
    await Supabase.initialize(
      url:
          'https://niosoyktbupufcwtcrhc.supabase.co', // Replace with your Supabase Project URL
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5pb3NveWt0YnVwdWZjd3RjcmhjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE5MzAyNzcsImV4cCI6MjA1NzUwNjI3N30.55_g81NozaYMac1_Ek0gLj07VVXLMH_SXJkDzlO7iHo', // Replace with your Supabase Anon Key
    );
    print('Supabase initialized successfully');
  } catch (e) {
    print('Failed to initialize Supabase: $e');
  }

  // Run the app
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maternal Healthcare App',
      theme: ThemeData(
        primaryColor:
            const Color.fromARGB(255, 255, 255, 255), // Green primary color
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF880E4F), // Blue accent color
        ),
        fontFamily: 'Roboto', // Use a custom font if available
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        'about': (context) => About(),
        '/pre_dashboard': (context) => PreDashboardPage(),
        '/pre_dashboardh': (context) => PreDashboardPageh(),
        '/pre_dashboardm': (context) => PreDashboardPagem(),
        '/doctor_login_page': (context) => DoctorInterfacePage(),
        '/login_screen': (context) => LoginPage(),
        '/dashboard': (context) => DashboardScreen(),
        '/dashboardk': (context) => DashboardScreenK(),
        '/dashboardh': (context) => DashboardScreenH(),
        '/weeklyUpdates': (context) => PregnancyRecommendationsApp(),
        '/doctorAppointment': (context) => DoctorAppointment(),
        '/chatbot': (context) => ChatScreen(),
        '/sos': (context) => Sos(),
        '/healthMonitoring': (context) => HealthMonitoring(),
        '/ml': (context) => BabyHeadClassifier(),
        '/diet': (context) => ChatScreen1(),
        '/schemes': (context) => BabyCareOptionsPage(),
        '/vaccine': (context) => VaccinationPage(),
        '/exercise': (context) => Exercise(),
        '/doctorCall': (context) => DoctorCall(),
        '/doctor_list': (context) => DoctorListPage(),
        '/firstpage': (context) => HomePage(),
        '/pre_dashboardk': (context) => PreDashboardPagek(),
        '/healthMonitoringk': (context) => HealthMonitoringk(),
        '/exercisek': (context) => ExercisePagek(),
        '/doctorAppointmentk': (context) => DoctorListPagek(),
        '/vaccinek': (context) => VaccinationPagek(),
        '/sosk': (context) => Sosk(),
        '/weeklyUpdatesk': (context) => WeeklyUpdatesScreenk(),
        '/dietk': (context) => Dietk(),
        '/dieth': (context) => Dieth(),
        '/vaccineh': (context) => VaccinationPageh(),
        '/doctorCallh': (context) => DoctorCallh(),
        '/healthMonitoringh': (context) => HealthMonitoringh(),
        '/doctor_login_page': (context) => DoctorInterfacePageh(),
        '/exerciseh': (context) => ExercisePageh(),
        '/sosh': (context) => Sosh(),
        '/faq': (Context) => FAQPage(),
        '/faqh': (Context) => FAQPageh(),
        '/healthMonitoringm': (context) => healthMonitoringM(),
        '/sosm': (context) => SosM(),
        '/vaccineM': (context) => VaccinationPagem(),
        '/exerciseM': (context) => ExercisePageM(),
        '/dietM': (context) => dietM(),
        '/DoctorListPageh': (context) => DoctorAppointmenth(),
        '/faqm': (Context) => FAQPagem(),
        '/doctorCallm': (context) => DoctorCallM(),
        '/faqk': (Context) => FAQPagek(),
      },
    );
  }
}
