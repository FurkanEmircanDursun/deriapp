

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'background.dart';
import 'home_menu_page.dart';

class LoginPage extends StatelessWidget {
  @override
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                decoration: InputDecoration(labelText: "Şifre"),
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: MaterialButton(
                onPressed: () {
                  login(context);
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
                    "GİRİŞ YAP",
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

  Future login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeMenuPage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == "invalid-email") {
        errorMessage = "Geçersiz e-posta adresi formatı";
      } else if (e.code == "user-disabled") {
        errorMessage = "Hesap devre dışı bırakılmış";
      } else if (e.code == "user-not-found") {
        errorMessage = "Hesap bulunamadı";
      } else if (e.code == "wrong-password") {
        errorMessage = "Yanlış şifre girildi";
      } else {
        errorMessage = "Bir hata oluştu: ${e.toString()}";
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Giriş Hatası"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Tamam"),
              ),
            ],
          );
        },
      );
    }
  }


}
