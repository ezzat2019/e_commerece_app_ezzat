import 'dart:math';

import 'package:e_commerece_app_ezzat/widgets/auth_login_widget.dart';
import 'package:flutter/material.dart';

class AuthSceen extends StatelessWidget {
  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).primaryColor.withOpacity(.7),
              Theme.of(context).accentColor.withOpacity(.8)
            ])),
        child: ListView(
          children: [
            Container(
              width: width,
              transform: Matrix4.rotationZ(-10 * (pi / 180))..translate(-20.0),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
              margin: EdgeInsets.only(left: 0, right: 30, top: width * .30),
              child: Text(
                "My Shop",
                style: TextStyle(
                    fontFamily: "Anton",
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            AuthLoginWidget(width)
          ],
        ),
      ),
    );
  }
}
