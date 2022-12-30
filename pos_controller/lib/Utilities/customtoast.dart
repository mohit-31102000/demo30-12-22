import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToastHelper {
  void showCustomToast(String msg, bool issuccesstoast) {
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor:
            issuccesstoast ?   Color(0xffFFBB00) : const Color(0xff141414),
        textColor: issuccesstoast ? Colors.black : Colors.white,
        fontSize: 17);
  }
}
