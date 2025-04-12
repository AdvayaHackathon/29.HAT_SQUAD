import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:video_player/video_player.dart';

class BabyHeadClassifier extends StatefulWidget {
  const BabyHeadClassifier({super.key});

  @override
  State<BabyHeadClassifier> createState() => _BabyHeadClassifierState();
}

class _BabyHeadClassifierState extends State<BabyHeadClassifier> {
  Interpreter? _interpreter;
  File? _image;
  String _result = "No image selected";
  final ImagePicker _picker = ImagePicker();
  List<String> _labels = ["Ideal Position", "Breech Position", "Junk Photo"];
  List<String> _idealPositionVideos = [
    'assets/videos/ideal1.mp4',
    'assets/videos/ideal2.mp4',
  ];
  List<String> _breechPositionVideos = [
    'assets/videos/breech1.mp4',
    'assets/videos/breech2.mp4',
  ];

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter =
          await Interpreter.fromAsset('assets/models/model_unquant.tflite');

      _labels = await _loadLabels('assets/models/labels.txt');
      setState(() {
        _result = "Model Loaded Successfully!";
      });
    } catch (e) {
      setState(() {
        _result = "Failed to load model: $e";
      });
    }
  }

  Future<List<String>> _loadLabels(String path) async {
    try {
      final data = await DefaultAssetBundle.of(context).loadString(path);
      return data.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    } catch (e) {
      return ["Ideal Position", "Breech Position", "Junk Photo"];
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _result = "Processing image...";
        });
        await _runModel(_image!);
      }
    } catch (e) {
      setState(() {
        _result = "Error picking image: $e";
      });
    }
  }

  List<List<List<List<double>>>> _preprocessImage(File imageFile) {
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
    if (image == null) throw Exception("Error decoding image");

    int inputSize = 224;
    image = img.copyResize(image, width: inputSize, height: inputSize);

    return List.generate(1, (_) => List.generate(inputSize, (y) => List.generate(inputSize, (x) {
      img.Pixel pixel = image!.getPixel(x, y);
      return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
    })));
  }

  Future<void> _runModel(File image) async {
    if (_interpreter == null) {
      setState(() {
        _result = "Model not loaded!";
      });
      return;
    }

    try {
      var input = _preprocessImage(image);
      var outputShape = _interpreter!.getOutputTensor(0).shape;
      var output = List.filled(outputShape.reduce((a, b) => a * b), 0.0).reshape(outputShape);

      _interpreter!.run(input, output);

      int index = 0;
      double maxScore = output[0][0];
      for (int i = 1; i < output[0].length; i++) {
        if (output[0][i] > maxScore) {
          maxScore = output[0][i];
          index = i;
        }
      }

      setState(() {
        _result = "Prediction: ${_labels[index]} (${(maxScore * 100).toStringAsFixed(1)}% confident)";
      });

      if (mounted) {
        if (index == 2) {
          _showJunkPhotoDialog();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                prediction: _labels[index],
                confidence: maxScore,
                videos: index == 0 ? _idealPositionVideos : _breechPositionVideos,
              ),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _result = "Error running model: $e";
      });
    }
  }

  void _showJunkPhotoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Inappropriate Image Detected"),
        content: const Text("The uploaded image isn't an ultrasound scan.Upload a proper ultrasound image."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Baby Head Position Classifier"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(_image!, height: 250, fit: BoxFit.cover),
                    )
                  : Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.image, size: 100, color: Colors.grey),
                    ),
              const SizedBox(height: 30),
              Text(
                _result,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Pick from Gallery"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Take a Photo"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_interpreter == null)
                OutlinedButton.icon(
                  onPressed: _loadModel,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Retry Loading Model"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
  final String prediction;
  final double confidence;
  final List<String> videos;

  const ResultPage({
    super.key,
    required this.prediction,
    required this.confidence,
    required this.videos,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  VideoPlayerController? _videoController;
  int _selectedVideoIndex = -1;
  bool _isVideoPlaying = false;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _playVideo(int index) async {
    if (_selectedVideoIndex == index && _videoController != null) {
      if (_videoController!.value.isPlaying) {
        await _videoController!.pause();
      } else {
        await _videoController!.play();
      }
      return;
    }

    _videoController?.dispose();
    setState(() {
      _selectedVideoIndex = index;
      _isVideoPlaying = false;
    });

    try {
      _videoController = VideoPlayerController.asset(widget.videos[index])
        ..addListener(() {
          if (_videoController!.value.isInitialized) {
            setState(() {
              _isVideoPlaying = _videoController!.value.isPlaying;
            });
          }
        })
        ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
        });
    } catch (e) {
      setState(() {
        _selectedVideoIndex = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prediction Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Diagnosis: ${widget.prediction}",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Educational Videos:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: widget.videos.length,
                itemBuilder: (context, index) {
                  final videoName = widget.videos[index].split('/').last.replaceAll('.mp4', '').replaceAll('_', ' ');
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => _playVideo(index),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_circle_fill,
                              color: _selectedVideoIndex == index ? Theme.of(context).primaryColor : Colors.grey,
                              size: 30,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(videoName, style: const TextStyle(fontSize: 16)),
                            ),
                            if (_selectedVideoIndex == index && _isVideoPlaying)
                              const Icon(Icons.volume_up, color: Colors.green),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_selectedVideoIndex != -1 && _videoController != null && _videoController!.value.isInitialized)
              Column(
                children: [
                  const SizedBox(height: 16),
                  AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: VideoPlayer(_videoController!),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(_isVideoPlaying ? Icons.pause : Icons.play_arrow, size: 36),
                        onPressed: () {
                          if (_isVideoPlaying) {
                            _videoController!.pause();
                          } else {
                            _videoController!.play();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.replay, size: 36),
                        onPressed: () {
                          _videoController!.seekTo(Duration.zero);
                          _videoController!.play();
                        },
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
