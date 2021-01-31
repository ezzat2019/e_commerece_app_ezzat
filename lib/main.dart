import 'package:e_commerece_app_ezzat/providers/auth_provider.dart';
import 'package:e_commerece_app_ezzat/screens/auth_sceen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider())
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: "Lato"
      ),
      home: AuthSceen()
    );
  }
}
