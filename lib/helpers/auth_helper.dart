import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class AuthHelper{
   static  bool isEmptyFiled(String text,String msg,BuildContext context)
  {
    if (text.isEmpty) {
      Toast.show(msg, context);
      return true;
    }
    else
      {
        return false;
      }


  }
}