import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deriapp/authorized_edit_page.dart';
import 'package:deriapp/neighbourhood_list_page.dart';
import 'package:deriapp/widgets/data_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'background.dart';
import 'home_page.dart';

class HomeMenuPage extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('kullanıcılar');


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              FirebaseUserDataWidget(
                uid: FirebaseAuth.instance.currentUser!.uid,
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => NeighbourhoodPage()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                        child: Column(children: [
                          Text(
                            "MAHALLELER",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ]),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.blue[600],
                        ),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () async {
                        final FirebaseFirestore _firestore = FirebaseFirestore.instance;

                        var data =await _firestore.collection('kullanıcılar').where('e-mail',isEqualTo: 'admin@gmail.com').get();

                        const message = "Merhaba Çivril Kurban Derisi Yetkilisine Ulaşmak İçin Yazıyorum";
                        var tel =data.docs.first['phone number'];

                        final whatsappUrl = "https://wa.me/$tel?text=${Uri.encodeFull(message)}";

                        //  Uri whatsappUrl= Uri.parse('https://wa.me/$tel');

                        if (await canLaunch(whatsappUrl.toString())) {
                        await launch(whatsappUrl.toString());
                        } else {
                        throw 'WhatsApp açılamadı';
                        }

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black,
                        ),
                        child: Column(children: [
                          Text("İLETİŞİM",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ]),
                      )),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {

                       var data =await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
                      if(data['type']=='Admin'){
                         Navigator.push(context, MaterialPageRoute(builder: (_) => AuthEditPage()));

                      }


                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                        child: Column(children: [
                          Text(
                            "YETKİLİ DÜZENLE",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ]),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.red,
                        ),
                      )),
                  SizedBox(
                    width: 20,
                  ),

                ],
              ),
              SizedBox(height: 80),
              Container(
                height: 60.0,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red[900]),
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MyHomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text(
                    'ÇIKIŞ YAP',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
