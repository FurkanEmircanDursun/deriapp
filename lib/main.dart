import 'package:deriapp/home_menu_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("kullanıcı var  ");
            print(snapshot); 
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blueGrey,
              ),
              home: HomeMenuPage(),
            );
          } else {
            print("kullanıcı yok");
            return MaterialApp(

              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blueGrey,
              ),
              home: MyHomePage(),
            );
          }
        });
  }
}
