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
      title: 'Ask anything about pregnancy',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();

  // Cohere API Key
  static const String COHERE_API_KEY =
      'WzaFJfYFDEJB1VmztiWFAcGeaTc4lrC5Vwlu85kq';

  // Backend API URL
  static const String BACKEND_URL = 'http://your-backend-url/translate';

  // Speech-to-Text and Text-to-Speech
  late stt.SpeechToText _speechToText;
  bool _isListening = false;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    // Add user message to the chat
    setState(() {
      _messages.insert(0, Message(text: text, isUser: true));
    });

    // Detect the language of the input
    String detectedLanguage = await _detectLanguage(text);

    // Generate a response from Cohere (in English)
    String response = await generateResponseFromCohere(text);

    // Translate the response to the detected language using Samanantar
    String translatedResponse =
        await _translateText(response, 'en', detectedLanguage);

    // Add bot response to the chat
    setState(() {
      _messages.insert(0, Message(text: translatedResponse, isUser: false));
    });

    // Speak the bot's response in the detected language
    await _speak(translatedResponse, detectedLanguage);
  }

  Future<String> generateResponseFromCohere(String prompt) async {
    final url = Uri.parse('https://api.cohere.ai/v1/generate');
    final headers = {
      'Authorization': 'Bearer $COHERE_API_KEY',
      'Content-Type': 'application/json',
      'Cohere-Version': '2022-12-06',
    };
    final body = jsonEncode({
      'prompt': prompt,
      'max_tokens': 200,
      'temperature': 0.9,
      'stop_sequences': ['--'],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['generations'][0]['text'].trim();
      } else {
        print('Error: ${response.statusCode}');
        return 'Sorry, I encountered an error.';
      }
    } catch (e) {
      print('Exception: $e');
      return 'Sorry, I encountered an exception.';
    }
  }

  // Detect the language of the input text (simple heuristic for demonstration)
  Future<String> _detectLanguage(String text) async {
    // Replace this with a proper language detection library or API
    if (text.contains(RegExp(r'[a-zA-Z]'))) {
      return 'en'; // Assume English if text contains Latin characters
    } else if (text.contains(RegExp(r'[अ-ह]'))) {
      return 'hi'; // Hindi
    } else if (text.contains(RegExp(r'[க-ஹ]'))) {
      return 'ta'; // Tamil
    } else {
      return 'en'; // Default to English
    }
  }

  // Translate text using Samanantar (via backend)
  Future<String> _translateText(
      String text, String srcLang, String tgtLang) async {
    final url = Uri.parse(BACKEND_URL);
    final body = jsonEncode({
      'text': text,
      'src_lang': srcLang,
      'tgt_lang': tgtLang,
    });
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['translated_text'];
      } else {
        print('Error translating text: ${response.statusCode}');
        return text; // Return original text if translation fails
      }
    } catch (e) {
      print('Exception translating text: $e');
      return text; // Return original text if an error occurs
    }
  }

  // Start listening for voice input
  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              _controller.text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speechToText.stop();
    }
  }

  // Speak the given text using text-to-speech
  Future<void> _speak(String text, String languageCode) async {
    await _flutterTts.setLanguage(languageCode); // Set the detected language
    await _flutterTts.setPitch(1.0); // Adjust pitch
    await _flutterTts.speak(text);
  }

  // Stop TTS and clear input
  Future<void> _stopTtsAndClearInput() async {
    await _flutterTts.stop(); // Stop TTS
    _controller.clear(); // Clear input field
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatbot"),
        backgroundColor: const Color.fromARGB(255, 243, 33, 187),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageWidget(message: message);
              },
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  onPressed: _listen,
                  color: const Color.fromARGB(255, 231, 75, 166),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration.collapsed(
                      hintText: "Type or speak a message",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: _stopTtsAndClearInput,
                  color: const Color.fromARGB(255, 243, 11, 139),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  color: const Color.fromARGB(255, 243, 33, 163),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isUser ? const Color.fromARGB(255, 240, 44, 217) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message.text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}