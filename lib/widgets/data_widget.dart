import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseUserDataWidget extends StatelessWidget {
  final String uid;

  FirebaseUserDataWidget({required this.uid});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('kullanıcılar');

    return      FutureBuilder<DocumentSnapshot>(
        future: users.doc(uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Bir hata oluştu: ${snapshot.error}");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Veriler yükleniyor...");
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Kullanıcı adı: ${data['name']}"),
              Text("E-posta: ${data['e-mail']}"),
              Text("Telefon: ${data['phone number']}"),
              Text("Kullanıcı tipi: ${data['type']}"),
            ],
          );
        });
  }
}
