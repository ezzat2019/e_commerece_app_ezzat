import 'package:e_commerece_app_ezzat/providers/auth_provider.dart';
import 'package:e_commerece_app_ezzat/providers/store_provider.dart';
import 'package:e_commerece_app_ezzat/screens/auth_screen.dart';
import 'package:e_commerece_app_ezzat/screens/store_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AuthProvider()),
    ChangeNotifierProvider.value(value: StoreProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  Future<Widget> getHome() async {
    Widget main_home;
    await FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user != null) {
        main_home = StoreScreen();
      } else {
        main_home = AuthSceen();
      }
    });
    return main_home;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: "Lato"),
        home: FutureBuilder<Widget>(
          future: getHome(),
          builder: (_, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Container();
            } else {
              return snap.data;
            }
          },
        ));
  }
}
