import 'package:flutter/material.dart';

class PhysicalExercise {
  static String getExercisePlan(int week) {
    if (week >= 1 && week <= 3) {
      return 'रक्ताभिसरण सुधारण्यासाठी आणि थकवा कमी करण्यासाठी हलकी चाल आणि हलके व्यायाम दररोज 10-15 मिनिटे करा.';
    } else if (week >= 4 && week <= 6) {
      return 'चालत राहा आणि तणाव कमी करण्यासाठी खोल श्वास घेण्याचे व्यायाम जोडा.';
    } else if (week >= 7 && week <= 9) {
      return 'गर्भवती योगाभ्यास करा ज्यामुळे लवचिकता आणि कोर शक्ती सुधारते. योग्य आसन आणि श्वास घेण्याच्या तंत्रांवर लक्ष द्या.';
    } else if (week >= 10 && week <= 12) {
      return 'पेल्विक स्नायूंना बळकटी देण्यासाठी आणि पाठदुखी कमी करण्यासाठी हलकी स्क्वाट्स आणि स्ट्रेचिंग करा.';
    } else if (week >= 13 && week <= 15) {
      return 'सांध्यांवरील दाब कमी करण्यासाठी आणि सहनशक्ती वाढवण्यासाठी पोहणे किंवा पाण्यातील व्यायाम करा.';
    } else if (week >= 16 && week <= 18) {
      return '15-20 मिनिटे स्थिर सायकलिंग करा जे कमी प्रभावाचे कार्डिओ व्यायाम आहे.';
    } else if (week >= 19 && week <= 21) {
      return 'कोर आणि खालच्या शरीराची ताकद वाढवण्यासाठी नियंत्रित स्क्वाट्स आणि सुधारित प्लँक करा.';
    } else if (week >= 22 && week <= 24) {
      return 'मूत्राशय नियंत्रण सुधारण्यासाठी आणि प्रसूतीस मदत करण्यासाठी कीगल पेल्विक फ्लोर व्यायाम करा.';
    } else if (week >= 25 && week <= 27) {
      return 'स्नायूंची टोनिंग टिकवण्यासाठी प्रतिकार बँडसह हलके प्रतिरोध प्रशिक्षण करा.';
    } else if (week >= 28 && week <= 30) {
      return 'कोर शक्ती आणि स्थिरता सुधारण्यासाठी प्रसूतीपूर्व पिलेट्स करा.';
    } else if (week >= 31 && week <= 33) {
      return 'प्रसूतीसाठी तयारी करण्यासाठी आणि तणाव कमी करण्यासाठी सौम्य स्ट्रेचिंग आणि खोल श्वास घ्या.';
    } else if (week >= 34 && week <= 36) {
      return 'लवचिकता आणि विश्रांती वाढवण्यासाठी योगासन आणि विश्रांती तंत्रे अवलंबा.';
    } else if (week >= 37 && week <= 39) {
      return 'सहज प्रसूतीसाठी सौम्य चालणे आणि स्क्वाटिंग करा.';
    } else if (week == 40) {
      return 'सहज प्रसूतीसाठी विश्रांती तंत्रांचा सराव करा आणि थोडेसे चालत राहा.';
    } else {
      return 'कृपया वैध आठवडा (1-40) निवडा.';
    }
  }
}

class ExercisePageM extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePageM> {
  int week = 0;
  String exercisePlan = '';

  void updateExercisePlan() {
    setState(() {
      exercisePlan = PhysicalExercise.getExercisePlan(week);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("व्यायाम"),
        backgroundColor: Colors.pink.shade900,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.pink.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('गर्भधारणेचा आठवडा निवडा:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'आठवडा (1-40)',
                    ),
                    onChanged: (value) {
                      setState(() {
                        week = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: updateExercisePlan,
                  child: Text(
                    'योजना मिळवा',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('व्यायाम योजना:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(exercisePlan,
                style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            SizedBox(height: 20),
            Divider(),
            Text(
              'आरोग्य सूचना:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('- व्यायामाच्या आधी, दरम्यान आणि नंतर भरपूर पाणी प्या.',
                style: TextStyle(fontSize: 16)),
            Text('- आपल्या शरीराचे ऐका आणि जास्त मेहनत टाळा.',
                style: TextStyle(fontSize: 16)),
            Text('- फक्त डॉक्टरांनी मान्यता दिलेले व्यायाम करा.',
                style: TextStyle(fontSize: 16)),
            Text('- व्यायामाच्या आधी आणि नंतर सौम्य चाल करा.',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}