import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maternalhealthcareapp/AUTHENTICATION/profile_page.dart';
import 'package:maternalhealthcareapp/DASHBOARDENGLISH/dashboard_screen.dart';
import 'package:maternalhealthcareapp/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController =
      TextEditingController(text: '+91');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  // Check if the user is already logged in
  Future<void> _checkSession() async {
    final session = supabaseClient.auth.currentSession;
    if (session != null) {
      // User is already logged in, navigate to DashboardScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    }
  }

  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty || phone == '+91') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number')),
      );
      return;
    }

    // Validate phone number format (10 digits after +91)
    if (!RegExp(r'^\+91[0-9]{10}$').hasMatch(phone)) {
      _showErrorDialog('Invalid Phone Number',
          'Please enter a valid 10-digit phone number after +91.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await supabaseClient.auth.signInWithOtp(phone: phone);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpPage(phone: phone)),
      );
    } catch (e) {
      _showErrorDialog('Error', 'Failed to send OTP: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color(0xFFFCE4EC),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                      Text(
                        'Login/Sign Up',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: Colors.pink[900],
                                ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(136, 14, 79, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Enter your phone number',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: Icon(Icons.phone),
                              iconColor: Color.fromARGB(255, 255, 255, 255),
                            ),
                            onChanged: (value) {
                              // Ensure +91 is always present
                              if (!value.startsWith('+91')) {
                                _phoneController.value = TextEditingValue(
                                  text: '+91' +
                                      value.replaceAll(RegExp(r'[^0-9]'),
                                          ''), // Remove non-digits
                                  selection: TextSelection.collapsed(
                                      offset: '+91'.length + value.length),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _sendOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    'Next',
                                    style: TextStyle(fontSize: 18),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtpPage extends StatefulWidget {
  final String phone;

  const OtpPage({Key? key, required this.phone}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

Future<void> _verifyOtp() async {
  final otp = _otpController.text.trim();
  if (otp.isEmpty || otp.length != 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    final response = await supabaseClient.auth.verifyOTP(
      phone: widget.phone,
      token: otp,
      type: OtpType.sms,
    );

    if (response.session != null) {
      // Navigate to ProfilePage after successful verification
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PregnantProfilePage()),
      );
    } else {
      _showErrorDialog('Error', 'OTP verification failed');
    }
  } catch (e) {
    _showErrorDialog('Error', 'Failed to verify OTP: ${e.toString()}');
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Verification Code',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Enter the 6-digit code sent to ${widget.phone}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 30),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _otpController,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeFillColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                  selectedColor: Theme.of(context).colorScheme.secondary,
                  inactiveColor: Colors.grey[300],
                ),
                onChanged: (value) {},
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Confirm',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
