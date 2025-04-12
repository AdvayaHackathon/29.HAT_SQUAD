import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maternalhealthcareapp/time.dart';
import 'package:maternalhealthcareapp/timem.dart';

class DoctorListPageM extends StatelessWidget {
  final CollectionReference doctors =
      FirebaseFirestore.instance.collection('doctors');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('डॉक्टरांची यादी'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: doctors.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('काहीतरी चूक झाली आहे'));
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
                title: Text(doctor['डॉक्टरांचे नाव']), // डॉक्टरांचे नाव
                subtitle: Text(doctor['डॉक्टरांचा फोन नंबर']), // डॉक्टरांचा फोन नंबर
                trailing: IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimePagem(
                          doctorName: doctor['डॉक्टरांचे नाव'],
                          doctorPhone: doctor['डॉक्टरांचा फोन नंबर'],
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
