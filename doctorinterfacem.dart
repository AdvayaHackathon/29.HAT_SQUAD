import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore आयात करा

class DoctorInterfacePageM extends StatefulWidget {
  @override
  _DoctorInterfacePageMState createState() => _DoctorInterfacePageMState();
}

class _DoctorInterfacePageMState extends State<DoctorInterfacePageM> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _savedName = '';
  String _savedPhone = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore उदाहरण

  bool _showHistory = false; // फॉर्म आणि इतिहास दृश्य दरम्यान टॉगल करण्यासाठी
  List<Map<String, dynamic>> _historyData = []; // डेटा साठवण्यासाठी

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // डेटा Firestore मध्ये सेव्ह करा
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
          'timestamp': FieldValue.serverTimestamp(), // ऐच्छिक: टाइमस्टॅम्प जोडा
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('तपशील यशस्वीरित्या जतन केले!')),
        );

        // सेव्ह केल्यानंतर फील्ड साफ करा
        _nameController.clear();
        _phoneController.clear();
      } catch (e) {
        print('डेटा सेव्ह करताना त्रुटी: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('तपशील सेव्ह करण्यात अयशस्वी. कृपया पुन्हा प्रयत्न करा.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कृपया सर्व फील्ड भरा.')),
      );
    }
  }

  // Firestore मधून डेटा मिळवा
  Future<void> _fetchHistory() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('doctors')
          .orderBy('timestamp', descending: true) // नवीनतम डेटा आधी दाखवा
          .get();

      setState(() {
        _historyData = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        _showHistory = true; // इतिहास दृश्यावर जा
      });
    } catch (e) {
      print('इतिहास मिळवताना त्रुटी: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('इतिहास मिळवण्यात अयशस्वी. कृपया पुन्हा प्रयत्न करा.')),
      );
    }
  }

  // परत फॉर्म दृश्यावर जा
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
            onPressed: _fetchHistory, // इतिहास लोड करण्यासाठी
          ),
        ],
      ),
      backgroundColor: Colors.pink[50], // हलका गुलाबी पार्श्वभूमी
      body: _showHistory ? _buildHistoryView() : _buildFormView(),
    );
  }

  // फॉर्म दृश्य तयार करा
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
                          labelText: 'डॉक्टरचे नाव',
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
                        child: Text('जतन करा'),
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
                          'जतन केलेली माहिती:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('डॉक्टरचे नाव: $_savedName'),
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

  // इतिहास दृश्य तयार करा
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
                child: Text('परत जा'),
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
                  title: Text(data['नाव']), // डॉक्टरचे नाव
                  subtitle: Text(data['फोन नंबर']), // फोन नंबर
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
