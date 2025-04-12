import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'text_recognition_page.dart';

class GalleryPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

 GalleryPage({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final file = File(pickedFile.path);
      await storageRef.putFile(file);
      final imageUrl = await storageRef.getDownloadURL();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            var isFromGallery;
            return TextRecognitionPage(
              imagePath: pickedFile.path,
              imageUrl: imageUrl,
              isFromGallery: isFromGallery,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _pickImage(context),
            child: Text('Pick Image from Gallery'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('images').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final documents = snapshot.data!.docs;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final imageUrl = documents[index]['url'];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TextRecognitionPage(
                              imagePath: '',
                              imageUrl: imageUrl,
                              isFromGallery: true,
                            ),
                          ),
                        );
                      },
                      child: Image.network(imageUrl, fit: BoxFit.cover),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
