import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ask anything about Exercise!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Exercise(),
    );
  }
}

class Exercise extends StatefulWidget {
  const Exercise({super.key});

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    _initializeTts();
  }

  void _initializeSpeech() async {
    bool available = await _speech.initialize();
    if (!available) {
      print("Speech recognition not available on this device.");
    }
  }

  void _initializeTts() async {
    await _flutterTts.setLanguage("en-US"); // Set language for text-to-speech
  }

  Future<void> sendMessage(String message) async {
    setState(() {
      messages.add({"type": "user", "text": message});
    });
    // Call Co:here API to get exercise recommendation
    String exerciseRecommendation = await getExerciseRecommendation(message);
    setState(() {
      messages.add({"type": "bot", "text": exerciseRecommendation});
    });
    // Speak the bot's response
    await _flutterTts.speak(exerciseRecommendation);
  }

  Future<String> getExerciseRecommendation(String week) async {
    final String apiKey = 'uziKmpzc4aOCI1f2tIiUrjJGkqnPOXXpJHvc4hNv';
    final String endpoint = 'https://api.cohere.ai/v1/chat';
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'message':
            'Suggest safe physical exercises for a pregnant woman in week $week.',
        'model': 'command', // Use the appropriate Co:here model
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['text'];
    } else {
      return 'Sorry, I could not fetch the exercise recommendation.';
    }
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              setState(() {
                _controller.text = result.recognizedWords;
              });
              sendMessage(result.recognizedWords);
            }
          },
        );
      }
    }
  }

  void _stopListening() {
    if (_isListening) {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  void _stopReading() async {
    await _flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ask about Pregnancy Exercise',
          style: TextStyle(color: Color(0xFF0D70A1), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange[100], // Orange shade 100
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isListening ? Icons.mic : Icons.mic_off, color: Color(0xFF0D70A1)),
            onPressed: () {
              if (_isListening) {
                _stopListening();
              } else {
                _startListening();
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange[100]!, Colors.orange[100]!], // Orange shade 100
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(10),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Align(
                    alignment: message["type"] == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white, // White background for chat bubbles
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        message["text"]!,
                        style: TextStyle(
                          color: Color(0xFF0D70A1), // Blue-green text color
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // White background for input field
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Enter the week of pregnancy',
                            hintStyle: TextStyle(color: Color(0xFF0D70A1).withOpacity(0.6)),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Color(0xFF0D70A1)), // Blue-green text color
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: Color(0xFF0D70A1)),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          sendMessage(_controller.text);
                          _controller.clear();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.stop, color: Color(0xFF0D70A1)),
                      onPressed: _stopReading,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}