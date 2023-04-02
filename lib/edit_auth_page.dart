
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditAuthPage extends StatefulWidget {
  @override
  State<EditAuthPage> createState() => _EditAuthPageState();


  final String uid;


  EditAuthPage(this.uid);
}

class _EditAuthPageState extends State<EditAuthPage> {
  List<String> _selectedItems = [];

  final List<String> _listItems = [
    "AKÇAKÖY",
    "AKPINAR",
    "AKTAŞ",
    "AŞAĞI",
    "BALÇIKHİSAR",
    "BAYAT",
    "BEKİRLİ",
    "BELENCE",
    "BEYDİLLİ",
    "BEYKÖY",
    "BOZDAĞ",
    "BUCAK",
    "BULGURLAR",
    "CABAR",
    "CUMALAR",
    "ÇAĞLAYAN",
    "ÇAKALLAR",
    "ÇANDIR",
    "ÇAPAK",
    "ÇARŞI",
    "ÇATLAR",
    "ÇAYIR",
    "ÇETİNLER",
    "ÇITAK",
    "DÜZBEL",
    "EMİRCİK",
    "GÖKGÖL",
    "GÜMÜŞSU",
    "GÜRPINAR",
    "HAMAM",
    "HAYDAN",
    "IRGILLI",
    "IŞIKLI",
    "İĞDİR",
    "İMRALLI",
    "İNCEKÖY",
    "İSHAKLI",
    "KARABEDİRLER",
    "KARAHACILI",
    "KARALAR",
    "KARAMANLI",
    "KARAYAHŞİLER",
    "KAVAKALANI",
    "KAVAKKÖY",
    "KIRALAN",
    "KIZILCASÖĞÜT",
    "KIZILCAYER",
    "KOCAYAKA",
    "KOÇAK",
    "MENTEŞ",
    "OSMANKÖY",
    "ÖMERLİ",
    "ÖZDEMİRCİ",
    "REŞADİYE",
    "SARAY",
    "SARIBEYLİ",
    "SARILAR",
    "SAVRAN",
    "SERASERLİ",
    "SOMAK",
    "SÖKMEN",
    "STADYUM",
    "SUNDURLU",
    "SÜNGÜLLÜ",
    "ŞEHİTLER",
    "ŞENKÖY",
    "TEKKE",
    "TOKÇA",
    "TUĞLU",
    "YAHYALI",
    "YAKACIK",
    "YALINLI",
    "YAMANLAR",
    "YASSIHÜYÜK",
    "YUKARI",
    "YUKARI ÇAPAK",
    "YUVAKÖY"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mahalle Yetkisi Ata"),
      ),
      body: ListView.builder(
        itemCount: _listItems.length,
        itemBuilder: (context, index) {
          final item = _listItems[index];
          return CheckboxListTile(
            title: Text(item),
            value: _selectedItems.contains(item),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  _selectedItems.add(item);
                } else {
                  _selectedItems.remove(item);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {


          // Doküman referansı
          final DocumentReference<Map<String, dynamic>> docRef =
          FirebaseFirestore.instance.collection('kullanıcılar').doc(widget.uid);
          await docRef.update({
            'yetkili bolgeler': FieldValue.delete()// Diziyi güncelle
          });
          // Dizi alanını güncelle
          await docRef.update({
            'yetkili bolgeler': FieldValue.arrayUnion(_selectedItems)// Diziyi güncelle
          });
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Yeni Yetk"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _selectedItems
                      .map((item) => Text("- $item"))
                      .toList(),
                ),
              );
            },
          );
        },
        child: Icon(Icons.list),
      ),
    );
  }
}


