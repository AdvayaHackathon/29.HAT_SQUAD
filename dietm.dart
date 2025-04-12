import 'package:flutter/material.dart';

class DietP {
  static String getDietPlan(int week) {
    if (week >= 1 && week <= 12) {
      return 'दुखणे कमी करण्यासाठी पालक, मेथी, केळे, डाळी, अंडी, दूध, गूळ, रागी, बाजरी, नारळ, कोबी, गाजर आणि हलका आहार घ्या.';
    } else if (week >= 13 && week <= 26) {
      return 'दूध, दही, मासे, गूळ, हिरव्या पालेभाज्या, फळे, बदाम, दुग्धजन्य पदार्थ, संपूर्ण धान्य, डाळी, वाटाणा, ऊस, भोपळा, बीन्स आणि भरपूर पाणी प्या.';
    } else if (week >= 27 && week <= 40) {
      return 'संपूर्ण धान्याची पोळी, भात, तूप, पनीर, डाळी, पालेभाज्या, अंकुरलेले धान्य, उकडलेली अंडी, कोबी, रागी पोषणासाठी, सुके मेवे आणि नारळ पाणी घ्या.';
    } else {
      return 'कृपया वैध आठवडा (1-40) प्रविष्ट करा.';
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

class dietM extends StatefulWidget {
  const dietM({super.key});

  @override
  _DietState createState() => _DietState();
}

class _DietState extends State<dietM> {
  int week = 0;
  String dietPlan = 'कृपया आठवडा प्रविष्ट करा';
  List<String> imagePaths = [];

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
        title: Text("आहार योजना"),
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
              Text('गर्भधारणेचा आठवडा प्रविष्ट करा:',
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
                    onPressed: updateDietPlan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[900],
                    ),
                    child: Text(
                      'योजना मिळवा',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('आहार योजना:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(dietPlan,
                  style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
              SizedBox(height: 20),
              if (imagePaths.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
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
                'आरोग्य टिपा:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('- दररोज किमान 8-10 ग्लास पाणी प्या.', style: TextStyle(fontSize: 16)),
              Text('- तुमच्या डॉक्टरांनी सुचवलेले प्रेनेटल व्हिटॅमिन घ्या.', style: TextStyle(fontSize: 16)),
              Text('- हलका व्यायाम करा, स्ट्रेचिंग किंवा प्रेनेटल योग करा.', style: TextStyle(fontSize: 16)),
              Text('- पुरेशी झोप घ्या आणि तणाव नियंत्रणात ठेवा.', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink.shade900,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white, size: 40),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
