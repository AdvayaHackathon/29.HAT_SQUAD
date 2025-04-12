import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maternalhealthcareapp/time.dart';

class DoctorListPagek extends StatelessWidget {
  final CollectionReference doctors =
      FirebaseFirestore.instance.collection('doctors');

   DoctorListPagek({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ವೈದ್ಯರ ಪಟ್ಟಿ'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: doctors.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
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
                title: Text(doctor['name']),
                subtitle: Text(doctor['phone']),
                trailing: IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimePage(
                          doctorName: doctor['name'],
                          doctorPhone: doctor['phone'],
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
