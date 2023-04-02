import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

class NeighbourhoodLocationPage extends StatefulWidget {
  @override
  State<NeighbourhoodLocationPage> createState() =>
      _NeighbourhoodLocationPageState();
  final String Neighbourhood;

  NeighbourhoodLocationPage(this.Neighbourhood);
}

class _NeighbourhoodLocationPageState extends State<NeighbourhoodLocationPage> {
  void launchWhatsApp(String tel) async {
    final location = Location();

    final currentLocation = await location.getLocation();

    print(currentLocation.latitude);
    print(currentLocation.longitude);

    final message =
        "Merhaba Kurban Derim var Konumum burası https://maps.google.com/?q=${currentLocation.latitude},${currentLocation.longitude}";

    final whatsappUrl = "https://wa.me/+90$tel?text=${Uri.encodeFull(message)}";

    //  Uri whatsappUrl= Uri.parse('https://wa.me/$tel');

    if (await canLaunch(whatsappUrl.toString())) {
      await launch(whatsappUrl.toString());
    } else {
      throw 'WhatsApp açılamadı';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.Neighbourhood} Mahallesi'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Yetkilinizi seçiniz",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('kullanıcılar')
                .where('type', isEqualTo: 'Yetkili')
                .where('yetkili bolgeler', arrayContains: widget.Neighbourhood)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final users = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = users[index].data() as Map<String, dynamic>;

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          launchWhatsApp(user['phone number']);
                        },
                        leading: CircleAvatar(
                          child: Text(user['name'][0]),
                          backgroundColor: Colors.blueGrey[100],
                        ),
                        title: Text(
                          user['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          user['phone number'],
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: Icon(Icons.message, color: Colors.green),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );

  }
}
