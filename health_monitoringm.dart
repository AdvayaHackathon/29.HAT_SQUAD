import 'package:flutter/material.dart';

class healthMonitoringM extends StatefulWidget {
  @override
  _HealthMonitoringState createState() => _HealthMonitoringState();
}

class _HealthMonitoringState extends State<healthMonitoringM> {
  Map<String, TextEditingController> controllers = {
    "भ्रूण हृदय गती": TextEditingController(),
    "रक्तदाब (बी.पी)": TextEditingController(),
    "ग्लुकोज (जेवणापूर्वी)": TextEditingController(),
    "ग्लुकोज (जेवणानंतर)": TextEditingController(),
    "SPO2": TextEditingController(),
    "एम्नियोटिक द्रव": TextEditingController(),
    "सीरम फेरिटिन": TextEditingController(),
    "हीमेटोक्रिट": TextEditingController(),
    "हीमोग्लोबिन": TextEditingController(),
    "प्लेटलेट": TextEditingController(),
    "सीरम अल्बुमिन": TextEditingController(),
    "WBC संख्या": TextEditingController(),
    "सीरम क्रिएटिनिन": TextEditingController(),
    "कोलेस्टेरॉल": TextEditingController(),
    "फोलेट स्तर": TextEditingController(),
    "कॅल्शियम": TextEditingController(),
    "CRP": TextEditingController(),
    "विटामिन D": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "तपशील अपडेट करा",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("भ्रूणाचे मापन",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: controllers["भ्रूण हृदय गती"],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "भ्रूण हृदय गती",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("आईचे मापन",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...["रक्तदाब (बी.पी)", "ग्लुकोज (जेवणापूर्वी)", "ग्लुकोज (जेवणानंतर)", "SPO2"]
                .map((String key) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: controllers[key],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: key,
                    border: OutlineInputBorder(),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 16),
            Text("लॅब तपासणी",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...["एम्नियोटिक द्रव", "सीरम फेरिटिन", "हीमेटोक्रिट", "हीमोग्लोबिन", "प्लेटलेट",
              "सीरम अल्बुमिन", "WBC संख्या", "सीरम क्रिएटिनिन", "कोलेस्टेरॉल", "फोलेट स्तर", "कॅल्शियम", "CRP", "विटामिन D"]
                .map((String key) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: controllers[key],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: key,
                    border: OutlineInputBorder(),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Map<String, String> data = {};
                controllers.forEach((key, controller) {
                  data[key] = controller.text;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OutputPage(data: data),
                  ),
                );
              },
              child: Text("सबमिट करा"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade900,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.pink[50],
    );
  }
}
class OutputPage extends StatelessWidget {
  final Map<String, String> data;

  OutputPage({required this.data});

  final Map<String, Map<String, double>> normalRanges = {
    "भ्रूण हृदय दर": {"min": 110, "max": 160},
    "बी.पी": {"min": 70, "max": 120},
    "ग्लुकोज (जेवणापूर्वी)": {"min": 70, "max": 100},
    "ग्लुकोज (जेवणानंतर)": {"min": 100, "max": 140},
    "SPO2": {"min": 95, "max": 100},
    "ऍम्नियोटिक द्रव": {"min": 5, "max": 25},
    "सीरम फेरिटिन": {"min": 12, "max": 150},
    "हॅमाटोक्रिट": {"min": 36, "max": 46},
    "हीमोग्लोबिन": {"min": 12, "max": 16},
    "प्लेटलेट": {"min": 150, "max": 450},
    "सीरम अल्ब्युमिन": {"min": 3.5, "max": 5.0},
    "WBC संख्या": {"min": 4.0, "max": 11.0},
    "सीरम क्रिएटिनिन": {"min": 0.6, "max": 1.2},
    "कोलेस्ट्रॉल": {"min": 120, "max": 200},
    "फोलेट स्तर": {"min": 2.7, "max": 17.0},
    "कॅल्शियम": {"min": 8.5, "max": 10.2},
    "CRP": {"min": 0, "max": 10},
    "विटामिन D": {"min": 20, "max": 50},
  };

  Map<String, String> checkHealthStatus(double value, String key) {
    double min = normalRanges[key]!['min']!;
    double max = normalRanges[key]!['max']!;
    if (value < min) {
      return {"status": "कमी", "message": "⚠️ खूपच कमी"};
    } else if (value > max) {
      return {"status": "जास्त", "message": "⚠️ खूपच जास्त"};
    } else {
      return {"status": "सामान्य", "message": "✅ सर्व काही ठीक आहे"};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "आउटपुट",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("भ्रूणाचे वाचन",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (data["भ्रूण हृदय दर"]!.isNotEmpty)
              _buildOutputTile("भ्रूण हृदय दर", data["भ्रूण हृदय दर"]!),
            SizedBox(height: 16),
            Text("आईचे वाचन",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...["बी.पी", "ग्लुकोज (जेवणापूर्वी)", "ग्लुकोज (जेवणानंतर)", "SPO2"]
                .map((String key) {
              if (data[key]!.isEmpty) return SizedBox.shrink();
              return _buildOutputTile(key, data[key]!);
            }).toList(),
            SizedBox(height: 16),
            Text("लॅब वाचन",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...[
              "ऍम्नियोटिक द्रव",
              "सीरम फेरिटिन",
              "हॅमाटोक्रिट",
              "हीमोग्लोबिन",
              "प्लेटलेट",
              "सीरम अल्ब्युमिन",
              "WBC संख्या",
              "सीरम क्रिएटिनिन",
              "कोलेस्ट्रॉल",
              "फोलेट स्तर",
              "कॅल्शियम",
              "CRP",
              "विटामिन D"
            ].map((String key) {
              if (data[key]!.isEmpty) return SizedBox.shrink();
              return _buildOutputTile(key, data[key]!);
            }).toList(),
          ],
        ),
      ),
      backgroundColor: Colors.pink[50],
    );
  }

  Widget _buildOutputTile(String key, String value) {
    double parsedValue = double.tryParse(value) ?? 0;
    var status = checkHealthStatus(parsedValue, key);
    return ListTile(
      title: Text(key),
      subtitle: Text("मूल्य: $value - ${status["message"]}"),
    );
  }
}
