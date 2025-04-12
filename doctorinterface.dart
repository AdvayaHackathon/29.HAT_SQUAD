import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorInterfacePage extends StatefulWidget {
  const DoctorInterfacePage({super.key});

  @override
  _DoctorInterfacePageState createState() => _DoctorInterfacePageState();
}

class _DoctorInterfacePageState extends State<DoctorInterfacePage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _savedName = '';
  String _savedPhone = '';

  bool _showHistory = false;
  List<Map<String, dynamic>> _historyData = [];

  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Get current location
  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location services are disabled.')),
      );
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied.')),
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied.')),
      );
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  // Save data to Supabase
  Future<void> _saveData() async {
    final String name = _nameController.text.trim();
    final String phone = _phoneController.text.trim();

    if (name.isNotEmpty && phone.isNotEmpty) {
      final position = await _getCurrentLocation();

      if (position == null) return;

      setState(() {
        _savedName = name;
        _savedPhone = phone;
      });

      try {
        await _supabase.from('doctors').insert({
          'name': name,
          'phone': phone,
          'latitude': position.latitude,
          'longitude': position.longitude,
          'timestamp': DateTime.now().toIso8601String(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Details saved successfully!')),
        );

        _nameController.clear();
        _phoneController.clear();
      } catch (e) {
        print('Error saving data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save details. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  Future<void> _fetchHistory() async {
    try {
      final response = await _supabase
          .from('doctors')
          .select()
          .order('timestamp', ascending: false);

      setState(() {
        _historyData = List<Map<String, dynamic>>.from(response);
        _showHistory = true;
      });
    } catch (e) {
      print('Error fetching history: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch history. Please try again.')),
      );
    }
  }

  void _backToForm() {
    setState(() {
      _showHistory = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Interface'),
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
                        decoration: InputDecoration(labelText: 'Doctor Name'),
                      ),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _saveData,
                        child: Text('Save'),
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
                        Text('Saved Information:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Doctor Name: $_savedName'),
                        Text('Phone Number: $_savedPhone'),
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

  Widget _buildHistoryView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: _backToForm,
                child: Text('Back'),
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
                  title: Text(data['name'] ?? ''),
                  subtitle: Text(
                    'Phone: ${data['phone'] ?? ''}\n'
                    'Lat: ${data['latitude']?.toStringAsFixed(4) ?? 'N/A'}, '
                    'Lng: ${data['longitude']?.toStringAsFixed(4) ?? 'N/A'}',
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
