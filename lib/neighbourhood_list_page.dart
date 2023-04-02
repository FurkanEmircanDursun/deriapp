import 'package:deriapp/widgets/location_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'neighbourhood_location_page.dart';

class NeighbourhoodPage extends StatefulWidget {
  @override
  State<NeighbourhoodPage> createState() => _NeighbourhoodPageState();
}

class _NeighbourhoodPageState extends State<NeighbourhoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahalleni seç'),
      ),
      body: ListViewFilter(),
    );
  }
}

class ListViewFilter extends StatefulWidget {
  @override
  _ListViewFilterState createState() => _ListViewFilterState();
}

class _ListViewFilterState extends State<ListViewFilter> {
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

  List<String> _filteredItems = [];

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = _listItems;
  }

  void _filterList(String text) {
    setState(() {
      _filteredItems = _listItems
          .where(
              (item) => item.toLowerCase().contains(text.toLowerCase().trim()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: (value) {
            _filterList(value);
          },
          decoration: InputDecoration(
            hintText: 'Ara...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        Container(

          child: Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        print(_filteredItems[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NeighbourhoodLocationPage(
                              _filteredItems[index],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            _filteredItems[index],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

      ],
    );
  }
}
