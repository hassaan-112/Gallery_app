import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
class Utils {

  static Scankbar(String title, String message){
    Get.snackbar(title, message);
  }


  static toast(String message,Color color){
    Fluttertoast.showToast(msg: message,toastLength: Toast.LENGTH_SHORT,backgroundColor: color);
  }

  static void fieldFocusChange(BuildContext context,FocusNode currentFocus,FocusNode nextFocus){

    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);

  }

}