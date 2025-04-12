import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore इम्पोर्ट करें

class DoctorInterfacePageh extends StatefulWidget {
  @override
  _DoctorInterfacePageState createState() => _DoctorInterfacePageState();
}

class _DoctorInterfacePageState extends State<DoctorInterfacePageh> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _savedName = '';
  String _savedPhone = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore उदाहरण

  bool _showHistory = false; // फ़ॉर्म और इतिहास दृश्य के बीच टॉगल करने के लिए
  List<Map<String, dynamic>> _historyData = []; // डेटा संग्रहीत करने के लिए

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // डेटा Firestore में सेव करें
  void _saveData() async {
    final String name = _nameController.text.trim();
    final String phone = _phoneController.text.trim();

    if (name.isNotEmpty && phone.isNotEmpty) {
      setState(() {
        _savedName = name;
        _savedPhone = phone;
      });

      try {
        await _firestore.collection('doctors').add({
          'name': name,
          'phone': phone,
          'timestamp': FieldValue.serverTimestamp(), // वैकल्पिक: टाइमस्टैम्प जोड़ें
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('विवरण सफलतापूर्वक सहेजा गया!')),
        );

        // सेव करने के बाद फ़ील्ड साफ़ करें
        _nameController.clear();
        _phoneController.clear();
      } catch (e) {
        print('डेटा सहेजने में त्रुटि: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('विवरण सहेजने में विफल। कृपया पुनः प्रयास करें।')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कृपया सभी फ़ील्ड भरें।')),
      );
    }
  }

  // Firestore से डेटा प्राप्त करें
  Future<void> _fetchHistory() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('doctors')
          .orderBy('timestamp', descending: true) // नवीनतम डेटा पहले दिखाएं
          .get();

      setState(() {
        _historyData = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        _showHistory = true; // इतिहास दृश्य में स्विच करें
      });
    } catch (e) {
      print('इतिहास प्राप्त करने में त्रुटि: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('इतिहास प्राप्त करने में विफल। कृपया पुनः प्रयास करें।')),
      );
    }
  }

  // वापस फ़ॉर्म दृश्य पर जाएं
  void _backToForm() {
    setState(() {
      _showHistory = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('डॉक्टर इंटरफेस'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _fetchHistory, // इतिहास लाने के लिए
          ),
        ],
      ),
      backgroundColor: Colors.pink[50], // हल्का गुलाबी बैकग्राउंड
      body: _showHistory ? _buildHistoryView() : _buildFormView(),
    );
  }

  // फ़ॉर्म दृश्य बनाएं
  Widget _buildFormView() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 5,
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'डॉक्टर का नाम',
                        ),
                      ),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'फोन नंबर',
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _saveData,
                        child: Text('सहेजें'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_savedName.isNotEmpty && _savedPhone.isNotEmpty)
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'सहेजी गई जानकारी:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('डॉक्टर का नाम: $_savedName'),
                        Text('फोन नंबर: $_savedPhone'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // इतिहास दृश्य बनाएं
  Widget _buildHistoryView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'इतिहास',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: _backToForm,
                child: Text('वापस जाएं'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _historyData.length,
            itemBuilder: (context, index) {
              final data = _historyData[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(data['नाम']),
                  subtitle: Text(data['फ़ोन नंबर']),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
