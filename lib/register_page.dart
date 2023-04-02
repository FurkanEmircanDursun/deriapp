import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deriapp/home_menu_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'background.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Ad Soyad"),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText:
                        "Telefon Numarası örnek:5329344811 "),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "E-Mail"),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Şifre en az 6 hane"),
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: MaterialButton(
                onPressed: () {
                  signIn();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.8,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "KAYIT OL",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
 if( phoneNumberController.text.length==10){

   try {
     UserCredential userCredential =
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: emailController.text.trim(),
       password: passwordController.text.trim(),
     );

     final docUser = FirebaseFirestore.instance
         .collection("kullanıcılar")
         .doc(FirebaseAuth.instance.currentUser?.uid);
     final json = {
       'name': nameController.text.trim(),
       'phone number': phoneNumberController.text.trim(),
       'e-mail': emailController.text.trim(),
       'password': passwordController.text.trim(),
       'type': 'Kullanıcı',
       'uid': FirebaseAuth.instance.currentUser?.uid,
       'yetkili bolgeler': []
     };
     await docUser.set(json);

     Navigator.pop(context);
     Navigator.push(
         context, MaterialPageRoute(builder: (_) => HomeMenuPage()));
   } on FirebaseAuthException catch (e) {
     String errorMessage;
     if (e.code == 'weak-password') {
       errorMessage = 'Şifre zayıf. Daha güçlü bir şifre deneyin.';
     } else if (e.code == 'email-already-in-use') {
       errorMessage = 'Bu e-posta adresi zaten kullanılıyor.';
     } else {
       errorMessage = 'Kayıt olurken bir hata oluştu.';
     }

     showDialog(
       context: context,
       builder: (context) => AlertDialog(
         title: Text('Kayıt Başarısız'),
         content: Text(errorMessage),
         actions: [
           TextButton(
             onPressed: () {
               Navigator.pop(context);
             },
             child: Text('Tamam'),
           ),
         ],
       ),
     );
   } catch (e) {
     print(e);
   }
 }else{
   showDialog(
     context: context,
     builder: (context) => AlertDialog(
       title: Text('Kayıt Başarısız'),
       content: Text('Telefon numarası doğru formatta değil'),
       actions: [
         TextButton(
           onPressed: () {
             Navigator.pop(context);
           },
           child: Text('Tamam'),
         ),
       ],
     ),
   );
 }
 }

}
