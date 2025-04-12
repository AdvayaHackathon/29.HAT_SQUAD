import 'package:flutter/material.dart';

class HealthMonitoringk extends StatefulWidget {
  const HealthMonitoringk({super.key});

  @override
  _HealthMonitoringState createState() => _HealthMonitoringState();
}

class _HealthMonitoringState extends State<HealthMonitoringk> {
  Map<String, TextEditingController> controllers = {
    "ಭ್ರೂಣ ಹೃದಯ ದರ": TextEditingController(),
    "ಬಿ.ಪಿ": TextEditingController(),
    "ಗ್ಲೂಕೋಸ್ (ಊಟದ ಮೊದಲು)": TextEditingController(),
    "ಗ್ಲೂಕೋಸ್ (ಊಟದ ನಂತರ)": TextEditingController(),
    "SPO2": TextEditingController(),
    "ಅಮ್ನಿಯೋಟಿಕ್ ದ್ರವ": TextEditingController(),
    "ಸೀರಮ್ ಫೆರಿಟಿನ್": TextEditingController(),
    "ಹೆಮಟೋಕ್ರಿಟ್": TextEditingController(),
    "ಹೀಮೋಗ್ಲೋಬಿನ್": TextEditingController(),
    "ಪ್ಲೇಟ್ಲೆಟ್": TextEditingController(),
    "ಸೀರಮ್ ಆಲ್ಬುಮಿನ್": TextEditingController(),
    "WBC ಎಣಿಕೆ": TextEditingController(),
    "ಸೀರಮ್ ಕ್ರಿಯಾಟಿನ್": TextEditingController(),
    "ಕೊಲೆಸ್ಟ್ರಾಲ್": TextEditingController(),
    "ಫೋಲೇಟ್ ಮಟ್ಟಗಳು": TextEditingController(),
    "ಕ್ಯಾಲ್ಸಿಯಂ": TextEditingController(),
    "CRP": TextEditingController(),
    "ವಿಟಮಿನ್ D": TextEditingController(),
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
          "ವಿವರಗಳನ್ನು ನವೀಕರಿಸಿ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("ಭ್ರೂಣದ ಓದುಗಳು",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: controllers["ಭ್ರೂಣ ಹೃದಯ ದರ"],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "ಭ್ರೂಣ ಹೃದಯ ದರ",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("ತಾಯಿಯ ಓದುಗಳು",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...["ಬಿ.ಪಿ", "ಗ್ಲೂಕೋಸ್ (ಊಟದ ಮೊದಲು)", "ಗ್ಲೂಕೋಸ್ (ಊಟದ ನಂತರ)", "SPO2"]
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
            }),
            SizedBox(height: 16),
            Text("ಲ್ಯಾಬ್ ಓದುಗಳು",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...[
              "ಅಮ್ನಿಯೋಟಿಕ್ ದ್ರವ",
              "ಸೀರಮ್ ಫೆರಿಟಿನ್",
              "ಹೆಮಟೋಕ್ರಿಟ್",
              "ಹೀಮೋಗ್ಲೋಬಿನ್",
              "ಪ್ಲೇಟ್ಲೆಟ್",
              "ಸೀರಮ್ ಆಲ್ಬುಮಿನ್",
              "WBC ಎಣಿಕೆ",
              "ಸೀರಮ್ ಕ್ರಿಯಾಟಿನ್",
              "ಕೊಲೆಸ್ಟ್ರಾಲ್",
              "ಫೋಲೇಟ್ ಮಟ್ಟಗಳು",
              "ಕ್ಯಾಲ್ಸಿಯಂ",
              "CRP",
              "ವಿಟಮಿನ್ D"
            ].map((String key) {
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
            }),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade900,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text("ನಮೂದಿಸಿ"),
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

  OutputPage({super.key, required this.data});

  final Map<String, Map<String, double>> normalRanges = {
    "ಭ್ರೂಣ ಹೃದಯ ದರ": {"min": 110, "max": 160},
    "ಬಿ.ಪಿ": {"min": 70, "max": 120},
    "ಗ್ಲೂಕೋಸ್ (ಊಟದ ಮೊದಲು)": {"min": 70, "max": 100},
    "ಗ್ಲೂಕೋಸ್ (ಊಟದ ನಂತರ)": {"min": 100, "max": 140},
    "SPO2": {"min": 95, "max": 100},
    "ಅಮ್ನಿಯೋಟಿಕ್ ದ್ರವ": {"min": 5, "max": 25},
    "ಸೀರಮ್ ಫೆರಿಟಿನ್": {"min": 12, "max": 150},
    "ಹೆಮಟೋಕ್ರಿಟ್": {"min": 36, "max": 46},
    "ಹೀಮೋಗ್ಲೋಬಿನ್": {"min": 12, "max": 16},
    "ಪ್ಲೇಟ್ಲೆಟ್": {"min": 150, "max": 450},
    "ಸೀರಮ್ ಆಲ್ಬುಮಿನ್": {"min": 3.5, "max": 5.0},
    "WBC ಎಣಿಕೆ": {"min": 4.0, "max": 11.0},
    "ಸೀರಮ್ ಕ್ರಿಯಾಟಿನ್": {"min": 0.6, "max": 1.2},
    "ಕೊಲೆಸ್ಟ್ರಾಲ್": {"min": 120, "max": 200},
    "ಫೋಲೇಟ್ ಮಟ್ಟಗಳು": {"min": 2.7, "max": 17.0},
    "ಕ್ಯಾಲ್ಸಿಯಂ": {"min": 8.5, "max": 10.2},
    "CRP": {"min": 0, "max": 10},
    "ವಿಟಮಿನ್ D": {"min": 20, "max": 50},
  };

  Map<String, String> checkHealthStatus(double value, String key) {
    double min = normalRanges[key]!["min"]!;
    double max = normalRanges[key]!["max"]!;
    if (value < min) {
      return {"status": "ಕಡಿಮೆ", "message": "⚠️ ತುಂಬಾ ಕಡಿಮೆ"};
    } else if (value > max) {
      return {"status": "ಹೆಚ್ಚು", "message": "⚠️ ತುಂಬಾ ಹೆಚ್ಚು"};
    } else {
      return {"status": "ಸಾಮಾನ್ಯ", "message": "✅ ಎಲ್ಲವೂ ಚೆನ್ನಾಗಿದೆ"};
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
          "ಔಟ್ಪುಟ್",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("ಭ್ರೂಣದ ಓದುಗಳು",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (data["ಭ್ರೂಣ ಹೃದಯ ದರ"]!.isNotEmpty)
              _buildOutputTile("ಭ್ರೂಣ ಹೃದಯ ದರ", data["ಭ್ರೂಣ ಹೃದಯ ದರ"]!),
            SizedBox(height: 16),
            Text("ತಾಯಿಯ ಓದುಗಳು",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...["ಬಿ.ಪಿ", "ಗ್ಲೂಕೋಸ್ (ಊಟದ ಮೊದಲು)", "ಗ್ಲೂಕೋಸ್ (ಊಟದ ನಂತರ)", "SPO2"]
                .map((String key) {
              if (data[key]!.isEmpty) return SizedBox.shrink();
              return _buildOutputTile(key, data[key]!);
            }),
            SizedBox(height: 16),
            Text("ಲ್ಯಾಬ್ ಓದುಗಳು",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...[
              "ಅಮ್ನಿಯೋಟಿಕ್ ದ್ರವ",
              "ಸೀರಮ್ ಫೆರಿಟಿನ್",
              "ಹೆಮಟೋಕ್ರಿಟ್",
              "ಹೀಮೋಗ್ಲೋಬಿನ್",
              "ಪ್ಲೇಟ್ಲೆಟ್",
              "ಸೀರಮ್ ಆಲ್ಬುಮಿನ್",
              "WBC ಎಣಿಕೆ",
              "ಸೀರಮ್ ಕ್ರಿಯಾಟಿನ್",
              "ಕೊಲೆಸ್ಟ್ರಾಲ್",
              "ಫೋಲೇಟ್ ಮಟ್ಟಗಳು",
              "ಕ್ಯಾಲ್ಸಿಯಂ",
              "CRP",
              "ವಿಟಮಿನ್ D"
            ].map((String key) {
              if (data[key]!.isEmpty) return SizedBox.shrink();
              return _buildOutputTile(key, data[key]!);
            }),
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
      subtitle: Text("ಮೌಲ್ಯ: $value - ${status["message"]}"),
    );
  }
}
