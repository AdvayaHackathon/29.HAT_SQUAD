import 'package:flutter/material.dart';

class PhysicalExercise {
  static String getExercisePlan(int week) {
    if (week >= 1 && week <= 3) {
      return 'ಸುತ್ತೋಲೆ ಮತ್ತು ಹಗುರ ನಡಿಗೆ ದಿನಕ್ಕೆ 10-15 ನಿಮಿಷಗಳ ಕಾಲ ರಕ್ತಪ್ರವಾಹ ಸುಧಾರಿಸಲು ಮತ್ತು ದಣಿವು ಕಡಿಮೆ ಮಾಡಲು.';
    } else if (week >= 4 && week <= 6) {
      return 'ನಡಿಗೆಯನ್ನು ಮುಂದುವರಿಸಿ ಮತ್ತು ಆಳವಾದ ಉಸಿರಾಟದ ವ್ಯಾಯಾಮಗಳನ್ನು ಸೇರಿಸಿ ಒತ್ತಡ ನಿವಾರಣೆಗೆ ಸಹಾಯ.';
    } else if (week >= 7 && week <= 9) {
      return 'ಪ್ರಿನಾಟಲ್ ಯೋಗವನ್ನು ಸೇರಿಸಿ ನಮ್ಯತೆ ಮತ್ತು ಕೋರ್ ಶಕ್ತಿ ಸುಧಾರಿಸಿ. ಸರಿಯಾದ ಭಂಗಿ ಮತ್ತು ಉಸಿರಾಟ ತಂತ್ರಗಳ ಮೇಲೆ ಗಮನ.';
    } else if (week >= 10 && week <= 12) {
      return 'ಪೆಲ್ವಿಕ್ ಶಕ್ತಿ ಬೆಂಬಲಿಸಲು ಮತ್ತು ಕೆಳ ಬೆನ್ನಿನ ನೋವು ಕಡಿಮೆ ಮಾಡಲು ಹಗುರ ಸ್ಕ್ವಾಟ್ಗಳು ಮತ್ತು ಸ್ಟ್ರೆಚಿಂಗ್.';
    } else if (week >= 13 && week <= 15) {
      return 'ಜಂಟಿ ಒತ್ತಡ ಕಡಿಮೆ ಮಾಡಲು ಮತ್ತು ಸಹಿಷ್ಣುತೆ ಸುಧಾರಿಸಲು ಈಜು ಅಥವಾ ನೀರಿನ ವ್ಯಾಯಾಮ.';
    } else if (week >= 16 && week <= 18) {
      return 'ಸ್ಥಿರ ಸೈಕ್ಲಿಂಗ್ನಂತಹ ಕಡಿಮೆ ಪರಿಣಾಮದ ಕಾರ್ಡಿಯೋ 15-20 ನಿಮಿಷಗಳ ಕಾಲ.';
    } else if (week >= 19 && week <= 21) {
      return 'ಕೋರ್ ಮತ್ತು ಕೆಳ ದೇಹದ ಶಕ್ತಿ ಹೆಚ್ಚಿಸಲು ನಿಯಂತ್ರಿತ ಸ್ಕ್ವಾಟ್ಗಳು ಮತ್ತು ಮಾರ್ಪಡಿಸಿದ ಪ್ಲ್ಯಾಂಕ್ಗಳು.';
    } else if (week >= 22 && week <= 24) {
      return 'ಕೀಗಲ್ಸ್ನಂತಹ ಪೆಲ್ವಿಕ್ ಫ್ಲೋರ್ ವ್ಯಾಯಾಮಗಳನ್ನು ಅಭ್ಯಾಸ ಮಾಡಿ ಬ್ಲ್ಯಾಡರ್ ನಿಯಂತ್ರಣ ಮತ್ತು ಪ್ರಸವಕ್ಕೆ ಬೆಂಬಲ.';
    } else if (week >= 25 && week <= 27) {
      return 'ನಿರೋಧಕ ಬ್ಯಾಂಡ್ಗಳನ್ನು ಬಳಸಿ ಹಗುರ ನಿರೋಧಕ ತರಬೇತಿ ಸ್ನಾಯು ಟೋನ್ ನಿರ್ವಹಿಸಲು.';
    } else if (week >= 28 && week <= 30) {
      return 'ಪ್ರಿನಾಟಲ್ ಪಿಲೇಟ್ಸ್ ಕೋರ್ ಶಕ್ತಿ ಮತ್ತು ಸ್ಥಿರತೆ ಸುಧಾರಿಸಲು ನಿಯಂತ್ರಿತ ಚಲನೆಗಳ ಮೇಲೆ ಗಮನ.';
    } else if (week >= 31 && week <= 33) {
      return 'ಪ್ರಸವಕ್ಕೆ ತಯಾರಿ ಮತ್ತು ಒತ್ತಡ ಕಡಿಮೆ ಮಾಡಲು ಹಗುರ ಸ್ಟ್ರೆಚಿಂಗ್ ಮತ್ತು ಆಳವಾದ ಉಸಿರಾಟ.';
    } else if (week >= 34 && week <= 36) {
      return 'ನಮ್ಯತೆ ಮತ್ತು ಸೌಕರ್ಯ ಹೆಚ್ಚಿಸಲು ವಿಶ್ರಾಂತಿ ತಂತ್ರಗಳು ಮತ್ತು ಹಗುರ ಯೋಗ ಭಂಗಿಗಳನ್ನು ಅಭ್ಯಾಸ ಮಾಡಿ.';
    } else if (week >= 37 && week <= 39) {
      return 'ಸ್ವಾಭಾವಿಕ ಪ್ರಸವ ತಯಾರಿಗೆ ಪ್ರೋತ್ಸಾಹಿಸಲು ಹಗುರ ನಡಿಗೆ ಮತ್ತು ಸ್ಕ್ವಾಟಿಂಗ್ ವ್ಯಾಯಾಮಗಳು.';
    } else if (week == 40) {
      return 'ಸ್ವಾಭಾವಿಕ ಪ್ರಸವ ಪ್ರಗತಿಗೆ ಬೆಂಬಲಿಸಲು ವಿಶ್ರಾಂತಿ ತಂತ್ರಗಳು ಮತ್ತು ಕಿರು ನಡಿಗೆ.';
    } else {
      return 'ದಯವಿಟ್ಟು ಮಾನ್ಯ ವಾರ (1-40) ನಮೂದಿಸಿ.';
    }
  }
}

class ExercisePagek extends StatefulWidget {
  const ExercisePagek({super.key});

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePagek> {
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
        title: Text("ವ್ಯಾಯಾಮ"),
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
            Text('ಗರ್ಭಧಾರಣೆಯ ವಾರ ನಮೂದಿಸಿ:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ವಾರ (1-40)',
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[900],
                  ),
                  child: Text(
                    'ಯೋಜನೆ ಪಡೆಯಿರಿ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('ವ್ಯಾಯಾಮ ಯೋಜನೆ:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(exercisePlan,
                style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            SizedBox(height: 20),
            Divider(),
            Text(
              'ಆರೋಗ್ಯ ಸಲಹೆಗಳು:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('- ವ್ಯಾಯಾಮದ ಮೊದಲು, ಸಮಯದಲ್ಲಿ ಮತ್ತು ನಂತರ ನೀರು ಕುಡಿಯಿರಿ.',
                style: TextStyle(fontSize: 16)),
            Text('- ನಿಮ್ಮ ದೇಹಕ್ಕೆ ಕೇಳಿ ಮತ್ತು ಅತಿಯಾದ ಶ್ರಮ ತೆಗೆದುಕೊಳ್ಳಬೇಡಿ.',
                style: TextStyle(fontSize: 16)),
            Text('- ನಿಮ್ಮ ವೈದ್ಯರಿಂದ ಅನುಮೋದಿತ ಚಟುವಟಿಕೆಗಳಲ್ಲಿ ತೊಡಗಿಸಿಕೊಳ್ಳಿ.',
                style: TextStyle(fontSize: 16)),
            Text('- ವ್ಯಾಯಾಮದ ಮೊದಲು ಮತ್ತು ನಂತರ ಸುತ್ತೋಲೆ ಮಾಡಿ.',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
