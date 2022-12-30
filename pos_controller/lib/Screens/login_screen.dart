// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_const

import 'package:flutter/material.dart';
import 'package:pos_controller/Screens/tab_screen.dart';
import 'package:pos_controller/Utilities/customtoast.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:pos_controller/services/apihelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameController.text = 'dev.infosparkles@gmail.com';
    passwordController.text = '1234567';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff141414),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width / 1.8,
              decoration: BoxDecoration(
                color: Color(0xff141414),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/login_back.png'),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 66,
                        width: 297,
                        // color: Colors.red,
                        child: Image.asset('assets/logos/logo1.png'),
                      ),
                      Text(
                        'Welcome To POS System',
                        style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'mfont_Semibold',
                            color: Color(0xffFFFFFF)),
                      ),
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'mfont_Regular',
                            color: Color(0xffFFFFFF)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 54),
                decoration: BoxDecoration(
                  color: Color(0xff141414),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/login_back2.png'),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 46,
                          fontFamily: 'mfont_Medium',
                          color: Color(0xffFFFFFF)),
                    ),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'mfont_Regular',
                          color: Color(0xffFFFFFF)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Username',
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'mfont_Light',
                          color: Color(0xffFFFFFF)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3, 5),
                              blurRadius: 10,
                              color: Color(0xff000000))
                        ],
                      ),
                      child: TextField(
                        controller: userNameController,
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
                          hintText: 'Enter your username',
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
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'mfont_Light',
                          color: Color(0xffFFFFFF)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3, 5),
                              blurRadius: 10,
                              color: Color(0xff000000))
                        ],
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: _passwordVisible,
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
                          hintText: 'Enter your password',
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
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: _passwordVisible
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
                            border: Border.all(
                                width: 0.5, color: Color(0xffAAAAAA)),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 8,
                                  color: Color(0xff000000))
                            ],
                          ),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(horizontal: 26),
                            onPressed: () {
                              isValidate();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(19)),
                            child: Text(
                              'Login',
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
              ),
            )
          ],
        ),
      ),
    );
  }

  //------------------------------------ For Validation ------------------------------------
  void isValidate() {
    if (userNameController.text.trim().isEmpty) {
      CustomToastHelper().showCustomToast('Username must be filled out', false);

      return;
    } else if (passwordController.text.trim().isEmpty) {
      CustomToastHelper().showCustomToast('Password must be filled out', false);
      return;
    } else {
      webservicelogin();
    }
  }

  //------------------------------------ For Login ------------------------------------
  void webservicelogin() async {
    Loader.show(
      context,
      progressIndicator: const CircularProgressIndicator(
        backgroundColor: Color(0xffF2D35A),
        //color:Colors.teal,
        valueColor: AlwaysStoppedAnimation(Colors.grey),
        strokeWidth: 8,
      ),
    );

    var jsonResponse = await ApiHelper.loginUserDetail(
      userNameController.text,
      passwordController.text,
    );

    debugPrint('Login Response - $jsonResponse');
    if (jsonResponse['status'].toString().toLowerCase() == 'true') {
      // user may already be registered
      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], true);

      print('id : ' + jsonResponse['data']['staff_id'].toString());
      print('User type : ' + jsonResponse['data']['user_type'].toString());
      print('User password : '+jsonResponse['data']['password'].toString());

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(
          'NSUD_staff_id', jsonResponse['data']['staff_id'].toString());
      pref.setString(
          'NSUD_staff_type', jsonResponse['data']['user_type'].toString());
      pref.setString(
          'NSUD_staff_password', jsonResponse['data']['password'].toString());

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => TabScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], false);
    }
  }

}
