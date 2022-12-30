// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pos_controller/Screens/chagnge_password.dart';
import 'package:pos_controller/Screens/check_screen.dart';
import 'package:pos_controller/Screens/Home_screens/home_screen.dart';
import 'package:pos_controller/Screens/Table%20Screens/table_screen.dart';
import 'package:pos_controller/Screens/edit_profile.dart';
import 'package:pos_controller/Utilities/customtoast.dart';
import 'package:pos_controller/main.dart';
import 'package:pos_controller/services/apihelper.dart';
import 'package:pos_controller/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;

  String userName = '';
  String userType = '';
  String userImage = '';

  var _showLoading = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void getProfileDetail() async {
    setState(() {
      _showLoading = true;
    });

    var jsonData = await ApiHelper.getUserProfileData();
    // jsonData =  jsonData['data'];
    print('Get profile data - $jsonData');

    if (jsonData['status'] == true) {
      var splitrestaurantname = jsonData['data']['restaurant_name'];

      SharedPreferences pref = await SharedPreferences.getInstance();

      setState(() {
        userName = jsonData['data']['staff_name'].toString();
       userType = jsonData['data']['user_type'].toString();
        
        userImage = jsonData['data']['staff_image'].toString();
      });

      print('User name : ' + userName.toString());
      print('User type : ' + userType.toString());
      print('User image : ' + userImage.toString());

      setState(() {
        _showLoading = false;
      });
    } else {
      setState(() {
        _showLoading = false;
      });
      print(jsonData['message']);

      CustomToastHelper().showCustomToast(jsonData['message'], false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: Color(0xff141414),
      endDrawer: const CustomDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top + 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 80,
            width: double.infinity,
            //  color: Colors.red,
            decoration: BoxDecoration(
              //  color: Colors.red,

              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff333333),
                  Color(0xff141414),
                ],
              ),
              border: Border.all(width: 0.5, color: Color(0xffAAAAAA)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(3, 5),
                    blurRadius: 10,
                    color: Color(0xff000000))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: 230,
                  child: Image.asset('assets/logos/logo1.png'),
                ),
                Expanded(
                    child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset('assets/icons/clock.png'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '12 : 30 AM',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'mfont_Medium',
                            color: Color(0xffFFBB00)),
                      ),
                    ],
                  ),
                )),
                _showLoading
                    ? Text(
                        'Loading....',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'mfont_Medium',
                          color: Color(0xffFFFFFF),
                        ),
                      )
                    : Row(
                        children: [
                          Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                                //  color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(userImage),
                                ),
                                border: Border.all(
                                  width: 2,
                                  color: Color(0xffFFBB00),
                                ),
                                ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'mfont_Medium',
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              Text(
                                userType.toString(),
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 14,
                                  fontFamily: 'mfont_Regular',
                                  color: Color(0xffAAAAAA),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                SizedBox(
                  width: 15,
                ),
                PopupMenuButton(
                  color: Colors.black,
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.note_alt_sharp,
                            color: Color(0xffFFFFFF),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Shift Notes',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 100;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: Color(0xffFFFFFF),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 101;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.key,
                            color: Color(0xffFFFFFF),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        print('Log out');
                         setState(() {
                       // showAlertDialog(mainNavigatorKey.currentContext!);
                      });

                        
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Color(0xffFFFFFF),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //-------------------------------- Left Side Menu --------------------------------
                  Container(
                    width: 120,
                    decoration: BoxDecoration(
                      //  color: Colors.red,

                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff333333),
                          Color(0xff141414),
                        ],
                      ),
                      border: Border.all(width: 0.5, color: Color(0xffAAAAAA)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(3, 5),
                            blurRadius: 10,
                            color: Color(0xff000000))
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.all(0),
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = 0;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/icons/home.png',
                                        height: 42,
                                        width: 42,
                                        color: _selectedIndex == 0
                                            ? Color(0xffFFBB00)
                                            : Color(0xff828282),
                                      ),
                                      Text(
                                        'Home',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: _selectedIndex == 0
                                                ? Color(0xffFFBB00)
                                                : Color(0xff828282),
                                            fontFamily: 'mfont_Medium'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = 1;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/icons/checks.png',
                                        height: 42,
                                        width: 42,
                                        color: _selectedIndex == 1
                                            ? Color(0xffFFBB00)
                                            : Color(0xff828282),
                                      ),
                                      Text(
                                        'Checks',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: _selectedIndex == 1
                                                ? Color(0xffFFBB00)
                                                : Color(0xff828282),
                                            fontFamily: 'mfont_Medium'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              /*
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = 2;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/icons/tables.png',
                                        height: 42,
                                        width: 42,
                                        color: _selectedIndex == 2
                                            ? Color(0xffFFBB00)
                                            : Color(0xff828282),
                                      ),
                                      Text(
                                        'Tables',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: _selectedIndex == 2
                                                ? Color(0xffFFBB00)
                                                : Color(0xff828282),
                                            fontFamily: 'mfont_Medium'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = 3;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/icons/quick_serve.png',
                                        height: 42,
                                        width: 42,
                                        color: _selectedIndex == 3
                                            ? Color(0xffFFBB00)
                                            : Color(0xff828282),
                                      ),
                                      Text(
                                        'Quick Serve',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: _selectedIndex == 3
                                                ? Color(0xffFFBB00)
                                                : Color(0xff828282),
                                            fontFamily: 'mfont_Medium'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = 4;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/icons/switch_user.png',
                                        height: 42,
                                        width: 42,
                                        color: _selectedIndex == 4
                                            ? Color(0xffFFBB00)
                                            : Color(0xff828282),
                                      ),
                                      Text(
                                        'Switch User',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: _selectedIndex == 4
                                                ? Color(0xffFFBB00)
                                                : Color(0xff828282),
                                            fontFamily: 'mfont_Medium'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              */
                              // Expanded(
                              //   child: SizedBox(),
                              // ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = 5;
                                  });
                                },
                                child: Container(
                                      margin: EdgeInsets.only(top: 15),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/icons/help.png',
                                        height: 42,
                                        width: 42,
                                        color: _selectedIndex == 5
                                            ? Color(0xffFFBB00)
                                            : Color(0xff828282),
                                      ),
                                      Text(
                                        'Help',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: _selectedIndex == 5
                                                ? Color(0xffFFBB00)
                                                : Color(0xff828282),
                                            fontFamily: 'mfont_Medium'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),

                  //-------------------------------- Home Screen --------------------------------
                  _selectedIndex == 0
                      ? HomeScreen()
                      : //-------------------------------- Check Screen --------------------------------
                      _selectedIndex == 1
                          ? CheckScreen()
                          ://-------------------------------- Table Screen --------------------------------
                          _selectedIndex == 2
                              ? TableScreen(orderId: '17',)
                              : SizedBox(),
                  //-------------------------------- Profile Screen --------------------------------
                  _selectedIndex == 100 ? EditProfileScreen() : SizedBox(),

                  //-------------------------------- Change password Screen --------------------------------
                  _selectedIndex == 101 ? ChangePasswordScreen() : SizedBox(),

                  // //-------------------------------- Logout PopUp --------------------------------
                  // _selectedIndex == 102 ? showCustomPrintDialog() : SizedBox(),

                  /*
                  SizedBox(
                    width: 15,
                  ),
                  //-------------------------------- Right Side Panel --------------------------------
                
                  MaterialButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                    child: Text(
                      'Click here ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  )
                
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff333333),
                          Color(0xff141414),
                        ],
                      ),
                      border: Border.all(width: 0.5, color: Color(0xffAAAAAA)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(3, 5),
                            blurRadius: 10,
                            color: Color(0xff000000))
                      ],
                    ),
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shift notes',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'mfont_Medium',
                                  color: Color(0xffFFFFFF)),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '10',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'mfont_Medium',
                                        color: Color(0xffFFBB00)),
                                  ),
                                  TextSpan(
                                    text: ' notes',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'mfont_Medium',
                                        color: Color(0xffCFCFCF)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: 3,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Color(0xff000000),
                                  border: Border(
                                    left: BorderSide(
                                      color: Color(0xffFFBB00),
                                      width: 5,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Lorem Ipsum is simply',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'mfont_Medium',
                                                color: Color(0xffFFFFFF)),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '2/03/22',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'mfont_Medium',
                                                color: Color(0xff828282)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'mfont_Regular',
                                          color: Color(0xff828282)),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        height: 30,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              primary: Colors.yellow,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5)),
                                          child: Text(
                                            'Read more',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'mfont_Medium',
                                                color: Color(0xffFFBB00)),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                  )
                  */
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

  showCustomPrintDialog() {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: Container(
          height: 200,
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff333333),
                Color(0xff141414),
              ],
            ),
            border: Border.all(width: 0.5, color: Color(0xffAAAAAA)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(3, 5),
                  blurRadius: 10,
                  color: Color(0xff000000))
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'mfont_Medium',
                    color: Color(0xffFFFFFF)),
                child: Text(
                  'Are you sure you want to \nclock-out?',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 38,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Color(0xff828282),
                      borderRadius: BorderRadius.all(
                        Radius.circular(21),
                      ),
                    ),
                    child: MaterialButton(
                      padding: EdgeInsets.all(0),

                      onPressed: () {
                        Navigator.pop(context, true);
                      }, // passing true

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21)),
                      child: Center(
                        child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'mfont_Semibold',
                              color: Color(0xff141414)),
                          child: Text(
                            'Cancel',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 38,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Color(0xffFFBB00),
                      borderRadius: BorderRadius.all(
                        Radius.circular(21),
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 8,
                            color: Color(0xff000000))
                      ],
                    ),
                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21)),
                      child: Center(
                        child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'mfont_Semibold',
                              color: Color(0xff141414)),
                          child: Text(
                            "I'm sure",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


}
