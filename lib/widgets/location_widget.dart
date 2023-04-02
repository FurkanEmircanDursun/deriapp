import 'package:flutter/material.dart';
import 'package:location/location.dart';

class KonumWidget extends StatefulWidget {
  @override
  _KonumWidgetState createState() => _KonumWidgetState();
}

class _KonumWidgetState extends State<KonumWidget> {
  String _konum = '';

  void _konumGetir() async {
    var location = new Location();

    try {
      var currentLocation = await location.getLocation();
      setState(() {
        _konum =
        'Enlem: ${currentLocation.latitude}, Boylam: ${currentLocation.longitude}';
      });
    } catch (e) {
      print('Konum alınamadı: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MaterialButton(
          onPressed: _konumGetir,
          child: Text('Konumumu Getir'),
        ),
        Text(_konum),
      ],
    );
  }
}