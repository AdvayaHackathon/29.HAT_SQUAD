import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maternalhealthcareapp/time.dart';
import 'package:maternalhealthcareapp/timeh.dart';

class DoctorListPageh extends StatelessWidget {
  final CollectionReference doctors =
      FirebaseFirestore.instance.collection('doctors');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('डॉक्टरों की सूची'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: doctors.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('कुछ गलत हो गया'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              var doctor = data.docs[index];

              return ListTile(
                title: Text(doctor['नाम']),
                subtitle: Text(doctor['फ़ोन नंबर']),
                trailing: IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimePageh(
                          doctorName: doctor['नाम'],
                          doctorPhone: doctor['फ़ोन नंबर'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
