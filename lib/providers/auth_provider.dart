
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier{
  bool is_correct_email=false;
  bool is_correct_password=false;
  bool is_correct_password_confirm=false;
  String email="";
  String pass="";
  String pass_confirm="";
  bool login_mode=true;


  void setLoginMode(bool mode)
  {
    login_mode=mode;
    notifyListeners();

  }

  void setIsCorrectConfirmPassword(String pass)
  {
    if (pass.length>5) {
      is_correct_password_confirm=true;

    }  else{
      is_correct_password_confirm=false;
    }
    this.pass_confirm=pass;

    notifyListeners();
  }
  void setIsCorrectPassword(String pass)
  {
    if (pass.length>5) {
      is_correct_password=true;

    }  else{
      is_correct_password=false;
    }
    this.pass=pass;

    notifyListeners();
  }

  void setIsCorrectEmail(String email)
  {
    if (EmailValidator.validate(email)) {
      is_correct_email=true;

    }  else{
      is_correct_email=false;
    }
    this.email=email;
    notifyListeners();
  }


}