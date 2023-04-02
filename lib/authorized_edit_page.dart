import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_info_page.dart';

class AuthEditPage extends StatefulWidget {
  const AuthEditPage({Key? key}) : super(key: key);

  @override
  State<AuthEditPage> createState() => _AuthEditPageState();
}

class _AuthEditPageState extends State<AuthEditPage> {
  late Stream<QuerySnapshot> _usersStream;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _usersStream =
        FirebaseFirestore.instance.collection('kullanıcılar').snapshots();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (text) {
            setState(() {
              _searchText = text.toLowerCase();
            });
          },
          decoration: InputDecoration(
            hintText: 'Ara..',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          final filteredUsers = snapshot.data!.docs
              .where((doc) =>
                  doc['name'].toLowerCase().contains(_searchText) ||
                  doc['phone number'].toLowerCase().contains(_searchText) ||
                  doc['type'].toLowerCase().contains(_searchText))
              .toList();
          return _buildList(context, filteredUsers);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final user = data.data() as Map<String, dynamic>;
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color: Colors.grey.shade300),
            ),
          ),
          child: Icon(Icons.person, color: Colors.grey),
        ),
        title: Text(
          user['name'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(user['phone number']),
        trailing: Text(user['type']),
        onTap: () {
          switch (user['type']) {
            case 'Kullanıcı':
              FirebaseFirestore.instance
                  .collection('kullanıcılar')
                  .doc(user['uid'])
                  .update({
                'type': 'Yetkili',
              });
              break;
            case 'Yetkili':
              FirebaseFirestore.instance
                  .collection('kullanıcılar')
                  .doc(user['uid'])
                  .update({
                'type': 'Kullanıcı',
              });
              break;
          }
        },
        onLongPress: () {
          print("uzun tıklandı");
          if (user['type'] == 'Yetkili') {
            print("yetkili paneline ulaşıldı");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AuthInfo(user['uid'], user['name'],
                        user['phone number'], user['yetkili bolgeler'])));
          }
        },
      ),
    );
  }
}
