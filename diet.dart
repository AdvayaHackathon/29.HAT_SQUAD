import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class ChatScreen1 extends StatefulWidget {
  const ChatScreen1({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen1> {
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
    await _flutterTts.setLanguage("en-US");
  }

  Future<void> sendMessage(String message) async {
    setState(() {
      messages.add({"role": "user", "message": message});
    });

    String dietRecommendation = await getDietRecommendation(message);

    setState(() {
      messages.add({"role": "bot", "message": dietRecommendation});
    });

    await _flutterTts.speak(dietRecommendation);
  }

  Future<String> getDietRecommendation(String week) async {
    final String apiKey = 'uziKmpzc4aOCI1f2tIiUrjJGkqnPOXXpJHvc4hNv';
    final String endpoint = 'https://api.cohere.ai/v1/chat';

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'message': 'Suggest a diet for a pregnant woman in week $week.',
        'model': 'command',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['text'];
    } else {
      return 'Sorry, I could not fetch the diet recommendation.';
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

  void _stopTtsAndClearInput() async {
    await _flutterTts.stop();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask anything about Diet!'),
        backgroundColor: Colors.orange[300],
        elevation: 0,
      ),
      body: Container(
        color: Colors.orange[100],
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Align(
                    alignment: message["role"] == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: message["role"] == "user"
                            ? Colors.white
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message["message"]!,
                        style: TextStyle(
                          color: Color(0xFF0D70A1), 
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
                  color: Colors.white,
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
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Color(0xFF0D70A1),),
                        ),
                      ),
                    ),
                    // Send Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send, color: Color(0xFF0D70A1),),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            sendMessage(_controller.text);
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 4),
                    // Mic Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          _isListening ? Icons.mic : Icons.mic_off,
                         color: Color(0xFF0D70A1), size: 40
                        ),
                        onPressed: () {
                          if (_isListening) {
                            _stopListening();
                          } else {
                            _startListening();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 4),
                    // Stop Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.stop, color: Color(0xFF0D70A1), size: 40),
                        onPressed: _stopTtsAndClearInput,
                      ),
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
