import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // ಫೈರ್ಸ್‌ಟೋರ್ ಆಮದು

class DoctorInterfacePagek extends StatefulWidget {
  const DoctorInterfacePagek({super.key});

  @override
  _DoctorInterfacePageState createState() => _DoctorInterfacePageState();
}

class _DoctorInterfacePageState extends State<DoctorInterfacePagek> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _savedName = '';
  String _savedPhone = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // ಫೈರ್ಸ್‌ಟೋರ್ ಉದಾಹರಣೆ

  bool _showHistory = false; // ಫಾರ್ಮ್ ಮತ್ತು ಇತಿಹಾಸದ ದೃಶ್ಯವನ್ನು ಬದಲಾಯಿಸಲು
  List<Map<String, dynamic>> _historyData = []; // ಪಡೆದ ದತ್ತಾಂಶವನ್ನು ಸಂಗ್ರಹಿಸಲು

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ಫೈರ್ಸ್‌ಟೋರ್‌ಗೆ ದತ್ತಾಂಶ ಉಳಿಸಿ
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
          'timestamp': FieldValue.serverTimestamp(), // ಐಚ್ಛಿಕ: ಟೈಮ್‌ಸ್ಟ್ಯಾಂಪ್ ಸೇರಿಸಿ
        });

        // ದೃಢೀಕರಣ ಸಂದೇಶ ತೋರಿಸಿ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ವಿವರಗಳು ಯಶಸ್ವಿಯಾಗಿ ಉಳಿಸಲಾಗಿದೆ!')),
        );

        // ಉಳಿಸಿದ ನಂತರ ಪಠ್ಯ ಕ್ಷೇತ್ರಗಳನ್ನು ತೆರವುಗೊಳಿಸಿ
        _nameController.clear();
        _phoneController.clear();
      } catch (e) {
        print('ದತ್ತಾಂಶವನ್ನು ಉಳಿಸುವಲ್ಲಿ ದೋಷ: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ವಿವರಗಳನ್ನು ಉಳಿಸಲು ವಿಫಲವಾಗಿದೆ. ದಯವಿಟ್ಟು ಪುನಃ ಪ್ರಯತ್ನಿಸಿ.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ದಯವಿಟ್ಟು ಎಲ್ಲಾ ಕ್ಷೇತ್ರಗಳನ್ನು ಭರ್ತಿ ಮಾಡಿ.')),
      );
    }
  }

  // ಫೈರ್ಸ್‌ಟೋರ್‌ನಿಂದ ದತ್ತಾಂಶವನ್ನು ಹಿಂಪಡೆಯಿರಿ
  Future<void> _fetchHistory() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('doctors')
          .orderBy('timestamp', descending: true) // ಹೊಸದು ಮೊದಲು ತರುವಂತೆ ಶ್ರೇಣೀಕರಿಸಿ
          .get();

      setState(() {
        _historyData = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        _showHistory = true; // ಇತಿಹಾಸದ ದೃಶ್ಯಕ್ಕೆ ಬದಲಾಯಿಸಿ
      });
    } catch (e) {
      print('ಇತಿಹಾಸವನ್ನು ತರಲು ದೋಷ: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ಇತಿಹಾಸವನ್ನು ತರಲು ವಿಫಲವಾಗಿದೆ. ದಯವಿಟ್ಟು ಪುನಃ ಪ್ರಯತ್ನಿಸಿ.')),
      );
    }
  }

  // ಹಿಂದಕ್ಕೆ ಫಾರ್ಮ್ ದೃಶ್ಯಕ್ಕೆ ಬದಲಾಯಿಸಿ
  void _backToForm() {
    setState(() {
      _showHistory = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ಡಾಕ್ಟರ್ ಸಂಪರ್ಕಮುಖ'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _fetchHistory,
          ),
        ],
      ),
      backgroundColor: Colors.pink[50],
      body: _showHistory ? _buildHistoryView() : _buildFormView(),
    );
  }

  // ಫಾರ್ಮ್ ದೃಶ್ಯವನ್ನು ನಿರ್ಮಿಸಿ
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
                          labelText: 'ಡಾಕ್ಟರ್ ಹೆಸರು',
                        ),
                      ),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'ಫೋನ್ ಸಂಖ್ಯೆ',
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _saveData,
                        child: Text('ಸಂಗ್ರಹಿಸಿ'),
                      ),
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

  // ಇತಿಹಾಸದ ದೃಶ್ಯವನ್ನು ನಿರ್ಮಿಸಿ
  Widget _buildHistoryView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ಇತಿಹಾಸ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: _backToForm,
                child: Text('ಹಿಂದಕ್ಕೆ'),
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
                  title: Text(data['name'] ?? 'ಅಜ್ಞಾತ'),
                  subtitle: Text(data['phone'] ?? 'ಲಭ್ಯವಿಲ್ಲ'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
