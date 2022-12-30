// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:pos_controller/Utilities/customtoast.dart';
import 'package:pos_controller/services/api.dart';
import 'package:pos_controller/services/apihelper.dart';
import 'package:pos_controller/services/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _newPasswordVisible = true;
  bool _confirmPasswordVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Color(0xff000000),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(3, 5), blurRadius: 10, color: Color(0xff000000))
          ],
        ),
        child: ListView(
          children: [
        Column(
         //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Password',
                  style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'mfont_Light',
                      color: Color(0xffFFFFFF)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 550,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(3, 5),
                          blurRadius: 10,
                          color: Color(0xff000000))
                    ],
                  ),
                  child: TextField(
                    controller: currentPasswordController,
                    cursorColor: const Color(0xffFFBB00),
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'mfont_Semibold',
                      color: const Color(0xffFFBB00),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xff000000),
                      filled: true,
                      hintText: 'Enter current password',
                      hintStyle: TextStyle(
                        color: Color(0xffA4A4A4),
                        fontSize: 18,
                        fontFamily: 'mfont_Medium',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                            color: Color(0xffAAAAAA), width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                            color: Color(0xffAAAAAA), width: 0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Password',
                  style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'mfont_Light',
                      color: Color(0xffFFFFFF)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 550,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(3, 5),
                          blurRadius: 10,
                          color: Color(0xff000000))
                    ],
                  ),
                  child: TextField(
                    controller: newPasswordController,
                    obscureText: _newPasswordVisible,
                    cursorColor: const Color(0xffFFBB00),
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'mfont_Semibold',
                      color: const Color(0xffFFBB00),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xff000000),
                      filled: true,
                      hintText: 'Enter new password',
                      hintStyle: TextStyle(
                        color: Color(0xffA4A4A4),
                        fontSize: 18,
                        fontFamily: 'mfont_Medium',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                            color: Color(0xffAAAAAA), width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                            color: Color(0xffAAAAAA), width: 0.5),
                      ),
                      suffixIcon: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            splashColor: Colors.grey,
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                _newPasswordVisible = !_newPasswordVisible;
                              });
                            },
                            icon: _newPasswordVisible
                                ? Image.asset(
                                    "assets/icons/eye_open.png",
                                    height: 28,
                                  )
                                : Image.asset(
                                    "assets/icons/eye_close.png",
                                    color: Color(0xffA4A4A4),
                                    height: 28,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirm Password',
                  style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'mfont_Light',
                      color: Color(0xffFFFFFF)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 550,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(3, 5),
                          blurRadius: 10,
                          color: Color(0xff000000))
                    ],
                  ),
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: _confirmPasswordVisible,
                    cursorColor: const Color(0xffFFBB00),
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'mfont_Semibold',
                      color: const Color(0xffFFBB00),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xff000000),
                      filled: true,
                      hintText: 'Enter confirm password',
                      hintStyle: TextStyle(
                        color: Color(0xffA4A4A4),
                        fontSize: 18,
                        fontFamily: 'mfont_Medium',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                            color: Color(0xffAAAAAA), width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                            color: Color(0xffAAAAAA), width: 0.5),
                      ),
                      suffixIcon: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            splashColor: Colors.grey,
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                _confirmPasswordVisible =
                                    !_confirmPasswordVisible;
                              });
                            },
                            icon: _confirmPasswordVisible
                                ? Image.asset(
                                    "assets/icons/eye_open.png",
                                    height: 28,
                                  )
                                : Image.asset(
                                    "assets/icons/eye_close.png",
                                    color: Color(0xffA4A4A4),
                                    height: 28,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 52,
                  // width: 38,
                  decoration: BoxDecoration(
                    color: Color(0xffFFBB00),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border:
                        Border.all(width: 0.5, color: Color(0xffAAAAAA)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: 8,
                          color: Color(0xff000000))
                    ],
                  ),
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    onPressed: () {
                      isValidate();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19)),
                    child: Text(
                      'Update',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff141414),
                          fontFamily: 'mfont_Semibold'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
          ],
        ),
      ),
    );
  }

  //------------------------------------ For Validation ------------------------------------
  void isValidate() {
    if (currentPasswordController.text.trim().isEmpty) {
      CustomToastHelper()
          .showCustomToast('Current password must be filled out', false);

      return;
    } else if (newPasswordController.text.trim().isEmpty) {
      CustomToastHelper()
          .showCustomToast('New password must be filled out', false);

      return;
    } else if (confirmPasswordController.text.trim().isEmpty) {
      CustomToastHelper()
          .showCustomToast('Confirm password must be filled out', false);

      return;
    } else if (newPasswordController.text != confirmPasswordController.text) {
      CustomToastHelper().showCustomToast(
          'New password and confirm password must be same', false);
    } else {
      changePassword();
    }
  }

  //------------------------------------ For change password ------------------------------------

  void changePassword() async {
    Loader.show(
      context,
      progressIndicator: const CircularProgressIndicator(
        backgroundColor: Color(0xffF2D35A),
        //color:Colors.teal,
        valueColor: AlwaysStoppedAnimation(Colors.grey),
        strokeWidth: 8,
      ),
    );

    var jsonResponse = await ApiHelper.changePassword(
        currentPasswordController.text.toString(),
        newPasswordController.text.toString(),
        confirmPasswordController.text.toString());

    debugPrint('Change password response - $jsonResponse');
    if (jsonResponse['status'].toString().toLowerCase() == 'true') {
      CustomToastHelper().showCustomToast(jsonResponse['message'], true);

      print('User password : ' + jsonResponse['password'].toString());

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(
          'NSUD_staff_password', jsonResponse['password'].toString());

      Loader.hide();
    } else {
      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], false);
    }
  }
}
