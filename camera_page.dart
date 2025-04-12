import 'dart:io';
import 'dart:math'; // For pi constant
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'text_recognition_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraReady = false; // Track whether the camera is ready
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller.initialize().then((_) {
        setState(() {
          _isCameraReady = true; // Mark the camera as ready
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error initializing camera: $e')),
      );
    }
  }

  Future<void> _captureImage(BuildContext context) async {
    if (!_isCameraReady) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera is not ready yet.')),
      );
      return;
    }

    try {
      await _initializeControllerFuture;

      // Capture the image
      final XFile image = await _controller.takePicture();
      print("Image captured at: ${image.path}");

      // Navigate to the text recognition page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TextRecognitionPage(
            imagePath: image.path,
            imageUrl: '',
            isFromGallery: true,
          ),
        ),
      );
    } catch (e) {
      print("Error capturing image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    try {
      // Pick an image from the gallery
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        print("Image selected from gallery: ${image.path}");

        // Navigate to the text recognition page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TextRecognitionPage(
              imagePath: image.path,
              imageUrl: '',
              isFromGallery: true,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected.')),
        );
      }
    } catch (e) {
      print("Error picking image from gallery: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Camera Preview (Fixed in the middle with natural aspect ratio)
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Get the natural aspect ratio of the camera
                  final aspectRatio = _controller.value.aspectRatio;

                  return Center(
                    child: RotatedBox(
                      quarterTurns: 1, // Rotate 90 degrees clockwise
                      child: AspectRatio(
                        aspectRatio:
                            aspectRatio, // Use the camera's natural aspect ratio
                        child: CameraPreview(_controller),
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          // Shutter Button (Positioned just below the camera preview)
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: _isCameraReady
                      ? () => _captureImage(context)
                      : null, // Disable button if camera is not ready
                  child: Icon(Icons.camera),
                ),
                FloatingActionButton(
                  onPressed: () => _pickImageFromGallery(context),
                  child: Icon(Icons.photo_library),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
