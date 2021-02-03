import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class AuthHelper {
  static final AuthHelper instace = AuthHelper.name();
  FirebaseAuth auth;

  static bool isEmptyFiled(String text, String msg, BuildContext context) {
    if (text.isEmpty) {
      Toast.show(msg, context);
      return true;
    } else {
      return false;
    }
  }


  factory AuthHelper() {
    return instace;
  }

  AuthHelper.name() {
    auth = FirebaseAuth.instance;
  }
}
