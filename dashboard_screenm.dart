import 'package:flutter/material.dart';

class DashboardScreenM extends StatelessWidget {
  List<Map<String, dynamic>> get options => [
        {
          'title': 'आरोग्य देखरेख',
          'imagePath': 'assets/images/health_monitoring.png',
          'route': '/healthMonitoringm'
        },
        {
          'title': 'आहार',
          'imagePath': 'assets/images/diet.png',
          'route': '/dietm'
        },
        {
          'title': 'व्यायाम',
          'imagePath': 'assets/images/exercise.png',
          'route': '/ExercisePageM'
        },
        {
          'title': 'प्रिस्क्रिप्शन',
          'imagePath': 'assets/images/prescription.png',
          'route': '/firstpage'
        },
        {
          'title': 'डॉक्टर \n अपॉइंटमेंट',
          'imagePath': 'assets/images/doctor_appointment.png',
          'route': '/DoctorListPageM'
        },
        {
          'title': 'लसीकरण',
          'imagePath': 'assets/images/vaccination.png',
          'route': '/vaccineM'
        },
        {
          'title': 'एसओएस',
          'imagePath': 'assets/images/sos.png',
          'route': '/SosM'
        },
        {
          'title': 'डॉक्टर/नर्सला कॉल करा',
          'imagePath': 'assets/images/call_doctor_nurse.png',
          'route': '/doctorCallM'
        },
        {
          'title': 'ग्रंथालय',
          'imagePath': 'assets/images/library.png',
          'route': '/weeklyUpdates'
        },
        {
          'title': 'भविष्यातील \n सुधारणा',
          'imagePath': 'assets/images/future_updates.png',
          'route': '/future'
        },
        {
          'title': 'सामान्य प्रश्न (FAQ)',
          'icon': Icons.live_help,
          'route': '/faqm'
        }
      ];

  const DashboardScreenM({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("नमस्कार, वापरकर्ता!"),
        backgroundColor: Colors.pink.shade900,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.pink.shade50,
      body: GridView.builder(
        padding: const EdgeInsets.all(20.0),
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
                  // पार्श्वभूमी प्रतिमा
                  Image.asset(
                    options[index]['imagePath'],
                    fit: BoxFit.cover,
                  ),
                  // पारदर्शक ओव्हरले
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.pink.shade200.withOpacity(0.3),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  // बटण (खालील बाजूस मध्यभागी)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, options[index]['route']);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white10.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 1),
                        ),
                        child: Text(
                          options[index]['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
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
    );
  }
}
