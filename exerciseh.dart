import 'package:flutter/material.dart';

class PhysicalExercise {
  static String getExercisePlan(int week) {
    if (week >= 1 && week <= 3) {
      return 'रक्त संचार सुधारने और थकान कम करने के लिए हल्की सैर और हल्की चलना प्रतिदिन 10-15 मिनट तक करें।';
    } else if (week >= 4 && week <= 6) {
      return 'चलना जारी रखें और तनाव को कम करने के लिए गहरी साँस लेने के व्यायाम को शामिल करें।';
    } else if (week >= 7 && week <= 9) {
      return 'प्रसवपूर्व योग को शामिल करें जिससे लचीलापन और कोर शक्ति में सुधार हो। सही मुद्रा और साँस लेने की तकनीकों पर ध्यान दें।';
    } else if (week >= 10 && week <= 12) {
      return 'पेल्विक शक्ति को सहारा देने और पीठ दर्द को कम करने के लिए हल्के स्क्वाट और स्ट्रेचिंग करें।';
    } else if (week >= 13 && week <= 15) {
      return 'जोड़ों पर दबाव कम करने और सहनशक्ति बढ़ाने के लिए तैराकी या पानी में व्यायाम करें।';
    } else if (week >= 16 && week <= 18) {
      return 'स्थिर साइक्लिंग जैसे कम प्रभाव वाले कार्डियो को 15-20 मिनट तक करें।';
    } else if (week >= 19 && week <= 21) {
      return 'कोर और निचले शरीर की शक्ति बढ़ाने के लिए नियंत्रित स्क्वाट और संशोधित प्लैंक करें।';
    } else if (week >= 22 && week <= 24) {
      return 'मूत्राशय नियंत्रण और प्रसव को समर्थन देने के लिए कीगल जैसे पेल्विक फ्लोर व्यायाम का अभ्यास करें।';
    } else if (week >= 25 && week <= 27) {
      return 'मांसपेशियों की टोन बनाए रखने के लिए प्रतिरोधी बैंड का उपयोग कर हल्का प्रतिरोध प्रशिक्षण करें।';
    } else if (week >= 28 && week <= 30) {
      return 'कोर शक्ति और स्थिरता में सुधार करने के लिए प्रसवपूर्व पिलेट्स करें और नियंत्रित चालों पर ध्यान दें।';
    } else if (week >= 31 && week <= 33) {
      return 'प्रसव की तैयारी और तनाव कम करने के लिए हल्का स्ट्रेचिंग और गहरी साँस लें।';
    } else if (week >= 34 && week <= 36) {
      return 'लचीलापन और आराम को बढ़ाने के लिए विश्राम तकनीकों और हल्के योग मुद्राओं का अभ्यास करें।';
    } else if (week >= 37 && week <= 39) {
      return 'प्राकृतिक प्रसव की तैयारी को बढ़ावा देने के लिए हल्की सैर और स्क्वाटिंग व्यायाम करें।';
    } else if (week == 40) {
      return 'प्राकृतिक प्रसव की प्रगति को समर्थन देने के लिए विश्राम तकनीकों और छोटी सैर का अभ्यास करें।';
    } else {
      return 'कृपया मान्य सप्ताह (1-40) दर्ज करें।';
    }
  }
}

class ExercisePageh extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePageh> {
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
            Text('गर्भावस्था का सप्ताह दर्ज करें:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'सप्ताह (1-40)',
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
                    'योजना प्राप्त करें',
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
              'स्वास्थ्य सुझाव:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('- व्यायाम से पहले, दौरान और बाद में पानी पिएं।',
                style: TextStyle(fontSize: 16)),
            Text('- अपने शरीर को सुनें और अत्यधिक परिश्रम न करें।',
                style: TextStyle(fontSize: 16)),
            Text('- केवल डॉक्टर द्वारा स्वीकृत गतिविधियों में भाग लें।',
                style: TextStyle(fontSize: 16)),
            Text('- व्यायाम से पहले और बाद में हल्की सैर करें।',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
