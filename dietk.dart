import 'package:flutter/material.dart';

class DietP {
  static String getDietPlan(int week) {
    if (week >= 1 && week <= 12) {
      return 'ನೋವನ್ನು ನಿರ್ವಹಿಸಲು ಸೊಪ್ಪು, ಮೇಜ, ಬಾಳೆಹಣ್ಣು, ಕಾಳುಗಳು, ಎಗ್ಸ್, ಹಾಲು, ಜಗ್ಗರಿ, ರಾಗಿ, ಬಜ್ರಾ, ತೆಂಗು, ಎಲೆಕೋಸು, ಕಾರಟ್ ಮತ್ತು ಸಣ್ಣ ಆಹಾರವನ್ನು ತಿನ್ನಿ.';
    } else if (week >= 13 && week <= 26) {
      return 'ಹಾಲು, ಮೊಸರ, ಮೀನು, ಜಗ್ಗರಿ, ಹಸಿರು ಎಲೆಗಳ ತರಕಾರಿಗಳು, ಹಣ್ಣುಗಳು, ಆಲ್ಮಂಡ್ಸ್ ಮತ್ತು ಹಾಲು ಪಟಕಗಳು, ಒಟ್ಟು ಗೋಧಿ, ದಾಲ್, ಬಟಾಣಿ, ಕಬ್ಬು, ಕುಂಬಳಕಾಯಿ, ಬಿಂದು ಮತ್ತು ಬಹುತೇಕ ನೀರನ್ನು ಕುಡಿಯಿರಿ.';
    } else if (week >= 27 && week <= 40) {
      return 'ಹೋಲ್ ವೈಟ್ ರೊಟಿಯನ್ನು, ಅಕ್ಕಿ, ತುಪ್ಪ, ಪನೀರ್, ದಾಲ್, ಎಲೆಹಣ್ಣು, ಸ್ಫೌಟೆಡ್ ಧಾನ್ಯಗಳು, ಬೇಕಿದ್ದ ಮೊಟ್ಟೆ, ಎಲೆಕೋಸು, ರಾಗಿ ಪೋಷಣೆ, ಹಿನ್ನಲೆ ನಗದ ಹಣ್ಣುಗಳು ಮತ್ತು ನಾರಿಯ ನೀರು ಸೇವಿಸಿ.';
    } else {
      return 'ದಯವಿಟ್ಟು ಮಾನ್ಯವಾದ ವಾರವನ್ನು ನಮೂದಿಸಿ (1-40).';
    }
  }

  static List<String> getImagePaths(int week) {
    if (week >= 1 && week <= 12) {
      return [
        'assets/images/egg.jpg',
        'assets/images/milk.jpg',
        'assets/images/spinach.jpg',
        'assets/images/banana.jpg',
        'assets/images/peanuts.jpg',
        'assets/images/lentils.jpg',
      ];
    } else if (week >= 13 && week <= 26) {
      return [
        'assets/images/second_trimester_1.jpg',
        'assets/images/second_trimester_2.jpg',
        'assets/images/second_trimester_3.jpg',
        'assets/images/second_trimester_4.jpg',
        'assets/images/second_trimester_5.jpg',
        'assets/images/second_trimester_6.jpg',
      ];
    } else if (week >= 27 && week <= 40) {
      return [
        'assets/images/third_trimester_1.jpg',
        'assets/images/third_trimester_2.jpg',
        'assets/images/third_trimester_3.jpg',
        'assets/images/third_trimester_4.jpg',
        'assets/images/third_trimester_5.jpg',
        'assets/images/third_trimester_6.jpg',
      ];
    } else {
      return [];
    }
  }
}

class Dietk extends StatefulWidget {
  const Dietk({super.key});

  @override
  _DietState createState() => _DietState();
}

class _DietState extends State<Dietk> {
  int week = 0;
  String dietPlan = 'ದಯವಿಟ್ಟು ವಾರವನ್ನು ನಮೂದಿಸಿ';
  List<String> imagePaths = []; // ಖಾಲಿ ಪಟ್ಟಿಯೊಂದಿಗೆ ಪ್ರಾರಂಭಿಸು

  void updateDietPlan() {
    setState(() {
      dietPlan = DietP.getDietPlan(week);
      imagePaths = DietP.getImagePaths(week);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ಆಹಾರ ಯೋಜನೆ"),
        backgroundColor: Colors.pink.shade900,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.pink.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('ಗರ್ಭವತಿಗೆ ವಾರವನ್ನು ನಮೂದಿಸಿ:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    onPressed: updateDietPlan,
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
              Text('ಆಹಾರ ಯೋಜನೆ:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(dietPlan,
                  style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
              SizedBox(height: 20),
              // ಚಿತ್ರಗಳನ್ನು ಪ್ರದರ್ಶಿಸಲು GridView
              if (imagePaths
                  .isNotEmpty) // ಚಿತ್ರಗಳು ಇದ್ದರೆ ಮಾತ್ರ GridView ತೋರಿಸು
                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // ಸ್ಕ್ರೋಲಿಂಗ್ ರದ್ದುಪಡಿಸು
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // ಎರಡು ಚಿತ್ರಗಳನ್ನು ಪ್ರತಿಯೊಂದರಲ್ಲಿ
                    crossAxisSpacing: 10, // ಕಾಲಮ್‌ಗಳ ನಡುವೆ ಸ್ಥಳ
                    mainAxisSpacing: 10, // ಸಾಲುಗಳ ನಡುವೆ ಸ್ಥಳ
                    childAspectRatio: 1, // ಚೌಕ ಚಿತ್ರಗಳು
                  ),
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imagePaths[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              SizedBox(height: 20),
              Divider(),
              Text(
                'ಆರೋಗ್ಯ ಸಲಹೆಗಳು:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('- ಪ್ರತಿದಿನವೂ ಕನಿಷ್ಠ 8–10 ಗ್ಲಾಸ್ ನೀರು ಕುಡಿಯಿರಿ.',
                  style: TextStyle(fontSize: 16)),
              Text(
                  '- ನಿಮ್ಮ ವೈದ್ಯರಿಂದ ಸೂಚಿಸಲಾದ ಪ್ರೆನೇಟಲ್ ವಯಿಟಮಿನ್ಗಳನ್ನು ತೆಗೆದುಕೊಳ್ಳಿ.',
                  style: TextStyle(fontSize: 16)),
              Text(
                  '- ಲಘು ವ್ಯಾಯಾಮಗಳನ್ನು ಮಾಡಿ, ಹಾರಿದಲು ಅಥವಾ ಪ್ರೆನೇಟಲ್ ಯೋಗವನ್ನು ಮಾಡಿ.',
                  style: TextStyle(fontSize: 16)),
              Text('- ಸಾಕಷ್ಟು ನಿದ್ರೆ ಮಾಡಿ ಮತ್ತು ಒತ್ತಡವನ್ನು ನಿಯಂತ್ರಿಸಿ.',
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
      // ನೆಲದ ಹತ್ತಿರ ಬಾಟ್‌ಮ್‌ನ್ಯಾವಿಗೇಷನ್‌ಬಾರ್ ಸೇರಿಸಿ
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink.shade900, // ಆಪ್‌ಗಾಗಿ ಥೀಮ್‌ನೊಂದಿಗೆ ಹೊಂದಿಸಿ
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.home,
                  color: Colors.white, size: 40), // ದೊಡ್ಡ ಐಕಾನ್ ಗಾತ್ರ
              onPressed: () {
                // ಹೋಮ್ ಸ್ಕ್ರೀನ್‌ಗೆ ಹಿಂತಿರುಗಿ
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
