import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_auth_page.dart';

class AuthInfo extends StatefulWidget {
  @override
  State<AuthInfo> createState() => _AuthInfoState();


  final String uid;
  final String name;
  final String phoneNumber;
  final List<dynamic> mahalleler;

  AuthInfo(this.uid, this.name, this.phoneNumber, this.mahalleler);
}



class _AuthInfoState extends State<AuthInfo> {


  @override
  Widget build(BuildContext context) {


    return  SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 32,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 16),
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 28,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 16),
                          Text(
                            widget.phoneNumber,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 28,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Yetkili Olduğu Mahalleler",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 100,
                                  child: ListView.builder(
                                    itemCount: widget.mahalleler.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Text("- ${widget.mahalleler[index]}");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);

                  Navigator.push(context, MaterialPageRoute(builder: (_)=>EditAuthPage(widget.uid)));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Buton arkaplan rengi
                  onPrimary: Colors.white, // Buton yazı rengi
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1), // Buton içi padding
                ),
                child: Text(
                  'Mahalle Düzenle',
                  style: TextStyle(fontSize: 18), // Buton yazı stilini belirleme
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
