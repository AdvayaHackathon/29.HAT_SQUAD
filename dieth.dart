import 'package:flutter/material.dart';

class DietP {
  static String getDietPlan(int week) {
    if (week >= 1 && week <= 12) {
      return 'दर्द को कम करने के लिए पालक, मेथी, केला, दालें, अंडे, दूध, गुड़, रागी, बाजरा, नारियल, पत्ता गोभी, गाजर और हल्का भोजन खाएं।';
    } else if (week >= 13 && week <= 26) {
      return 'दूध, दही, मछली, गुड़, हरी पत्तेदार सब्जियां, फल, बादाम और दूध उत्पाद, साबुत अनाज, दालें, मटर, गन्ना, कद्दू, बीन्स और खूब पानी पिएं।';
    } else if (week >= 27 && week <= 40) {
      return 'साबुत अनाज की रोटी, चावल, घी, पनीर, दालें, पत्तेदार सब्जियां, अंकुरित अनाज, उबले अंडे, पत्ता गोभी, रागी से पोषण, सूखे मेवे और नारियल पानी लें।';
    } else {
      return 'कृपया मान्य सप्ताह (1-40) दर्ज करें।';
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

class Dieth extends StatefulWidget {
  const Dieth({super.key});

  @override
  _DietState createState() => _DietState();
}

class _DietState extends State<Dieth> {
  int week = 0;
  String dietPlan = 'कृपया सप्ताह दर्ज करें';
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
              Text('गर्भावस्था का सप्ताह दर्ज करें:',
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
                    onPressed: updateDietPlan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[900],
                    ),
                    child: Text(
                      'योजना प्राप्त करें',
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
                'स्वास्थ्य सुझाव:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('- हर दिन कम से कम 8-10 गिलास पानी पिएं।',
                  style: TextStyle(fontSize: 16)),
              Text('- अपने डॉक्टर द्वारा सुझाए गए प्रेनेटल विटामिन लें।',
                  style: TextStyle(fontSize: 16)),
              Text('- हल्के व्यायाम करें, स्ट्रेचिंग या प्रेनेटल योग करें।',
                  style: TextStyle(fontSize: 16)),
              Text('- पर्याप्त नींद लें और तनाव को नियंत्रित करें।',
                  style: TextStyle(fontSize: 16)),
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