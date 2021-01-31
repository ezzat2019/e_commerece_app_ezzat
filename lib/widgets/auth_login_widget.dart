import 'package:e_commerece_app_ezzat/helpers/auth_helper.dart';
import 'package:e_commerece_app_ezzat/providers/auth_provider.dart';
import 'package:e_commerece_app_ezzat/screens/store_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AuthLoginWidgetState extends StatelessWidget {
  final double width;
  var height;
  AnimationController animationController;
  Animation<double> fade_anim;
  final auth_helper;

  FirebaseAuth auth;
  final GlobalKey<ScaffoldState> globalKey;
  var kk;

  AuthLoginWidgetState(
    this.width,
    this.animationController,
    this.auth,
    this.fade_anim,
    this.auth_helper,
    this.globalKey,
  ) {
    this.kk = globalKey.currentState;
  }

  @override
  Widget build(BuildContext context) {
    var myAuthProvider = Provider.of<AuthProvider>(context, listen: false);
    var myAuthProviderLive = Provider.of<AuthProvider>(context);
    Future<UserCredential> login(AuthProvider myAuthProvider) async {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: myAuthProvider.email, password: myAuthProvider.pass);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        myAuthProvider.setShowLoad(false);
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          kk.showSnackBar(
              SnackBar(content: Text('No user found for that email.')));
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          kk.showSnackBar(SnackBar(
              content: Text('Wrong password provided for that user.')));
        }
        return null;
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Card(
          elevation: 12,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    myAuthProvider.setIsCorrectEmail(value);
                  },
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                          fontSize: 22, color: Theme.of(context).primaryColor),
                      hintText: "enter your email",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: myAuthProviderLive.is_correct_email
                                  ? Colors.greenAccent
                                  : Colors.redAccent)),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: myAuthProviderLive.is_correct_email
                                  ? Colors.greenAccent
                                  : Theme.of(context).primaryColor)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      hintStyle: TextStyle(color: Colors.black26)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  textInputAction: myAuthProviderLive.login_mode
                      ? TextInputAction.done
                      : TextInputAction.next,
                  onChanged: (value) {
                    myAuthProvider.setIsCorrectPassword(value);
                  },
                  maxLines: 1,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                          fontSize: 22, color: Theme.of(context).primaryColor),
                      hintText: "enter password",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: myAuthProviderLive.is_correct_password
                                  ? Colors.greenAccent
                                  : Colors.redAccent)),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: myAuthProviderLive.is_correct_password
                                  ? Colors.greenAccent
                                  : Theme.of(context).primaryColor)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      hintStyle: TextStyle(color: Colors.black26)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              AnimatedContainer(
                constraints: myAuthProviderLive.login_mode
                    ? BoxConstraints(maxHeight: 0, maxWidth: 0)
                    : BoxConstraints(maxHeight: 60, maxWidth: width),
                duration: Duration(milliseconds: 500),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    myAuthProvider.setIsCorrectConfirmPassword(value);
                  },
                  maxLines: 1,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      fontSize: 22, color: Theme.of(context).primaryColor),
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(
                          fontSize: 22, color: Theme.of(context).primaryColor),
                      hintText: "enter confirm password",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  myAuthProviderLive.is_correct_password_confirm
                                      ? Colors.greenAccent
                                      : Colors.redAccent)),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  myAuthProviderLive.is_correct_password_confirm
                                      ? Colors.greenAccent
                                      : Theme.of(context).primaryColor)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      hintStyle: TextStyle(color: Colors.black26)),
                ),
              ),
              if (!myAuthProviderLive.login_mode)
                SizedBox(
                  height: 30,
                ),
              RaisedButton(
                onPressed: () {
                  if (AuthHelper.isEmptyFiled(myAuthProvider.email,
                      "please enter your email first", context)) {
                    return;
                  }
                  if (!myAuthProvider.is_correct_email) {
                    Toast.show("enter correct email first", context);
                    return;
                  }
                  if (AuthHelper.isEmptyFiled(myAuthProvider.pass,
                      "please enter your password", context)) {
                    return;
                  }
                  if (!myAuthProvider.is_correct_password) {
                    Toast.show("enter correct password > 6 letters", context);
                    return;
                  }

                  if (!myAuthProvider.login_mode) {
                    if (AuthHelper.isEmptyFiled(myAuthProvider.pass_confirm,
                        "please enter confirm password", context)) {
                      return;
                    }

                    if (myAuthProvider.pass_confirm != myAuthProvider.pass) {
                      Toast.show(
                          "confirm password not same with password try agin!",
                          context);
                      return;
                    }
                  }
                  myAuthProvider.setShowLoad(true);
                  if (myAuthProvider.login_mode) {
                    login(myAuthProvider).then((value) {
                      if (value != null) {
                        kk.showSnackBar(SnackBar(content: Text('successed')));
                        Navigator.of(globalKey.currentContext)
                            .pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return StoreScreen();
                          },
                        ));
                      }

                      myAuthProvider.setShowLoad(false);
                    });
                  } else {
                    try {
                      auth
                          .createUserWithEmailAndPassword(
                              email: myAuthProvider.email,
                              password: myAuthProvider.pass)
                          .then((value) {
                        myAuthProvider.setShowLoad(false);
                        Navigator.of(globalKey.currentContext)
                            .pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return StoreScreen();
                          },
                        ));
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        myAuthProvider.setShowLoad(false);
                        print('The password provided is too weak.');
                        kk.showSnackBar(SnackBar(
                            content:
                                Text('The password provided is too weak.')));
                      } else if (e.code == 'email-already-in-use') {
                        myAuthProvider.setShowLoad(false);
                        print('The account already exists for that email.');
                        kk.showSnackBar(SnackBar(
                            content: Text(
                                'The account already exists for that email.')));
                      }
                    } catch (e) {
                      myAuthProvider.setShowLoad(false);
                      print(e);
                      kk.showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Theme.of(context).primaryColor,
                child: Text(
                  myAuthProvider.login_mode ? "LOGIN" : "SIGN UP",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                child: FlatButton(
                  child: Text(
                    myAuthProviderLive.login_mode
                        ? "SIGNUP INSTEAD"
                        : "LOGIN INSTEAD",
                    style: TextStyle(
                        fontSize: 18, color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    if (myAuthProvider.login_mode) {
                      animationController.animateTo(1.0);
                    } else {
                      animationController.animateTo(0.0);
                    }

                    myAuthProvider.setLoginMode(!myAuthProvider.login_mode);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
