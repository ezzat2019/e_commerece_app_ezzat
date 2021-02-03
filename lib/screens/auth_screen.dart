import 'dart:math';

import 'package:e_commerece_app_ezzat/helpers/auth_helper.dart';
import 'package:e_commerece_app_ezzat/providers/auth_provider.dart';
import 'package:e_commerece_app_ezzat/widgets/auth_login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spin;
import 'package:provider/provider.dart';

class AuthSceen extends StatefulWidget {
  @override
  _AuthSceenState createState() => _AuthSceenState();
}

class _AuthSceenState extends State<AuthSceen>
    with SingleTickerProviderStateMixin {
  var width;
  final globalKey = GlobalKey<ScaffoldState>();
  var height;
  AnimationController animationController;
  Animation<double> fade_anim;
  final auth_helper = AuthHelper();
  FirebaseAuth auth;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    fade_anim = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    var myAuthProvider = Provider.of<AuthProvider>(context, listen: false);
    var myAuthProviderLive = Provider.of<AuthProvider>(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.width;
    return Scaffold(
      key: globalKey,
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
            if (myAuthProviderLive.showLoad)
              spin.SpinKitWave(
                color: Colors.white,
                size: 50.0,
              ),
            AuthLoginWidgetState(width, animationController, auth, fade_anim,
                auth_helper, globalKey)
          ],
        ),
      ),
    );
  }
}
