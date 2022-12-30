// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:pos_controller/Screens/Home_screens/manage_your_tips.dart';
import 'package:pos_controller/Screens/Home_screens/print_checkout_report.dart';
import 'package:pos_controller/Screens/Home_screens/view_shift_notes.dart';
import 'package:pos_controller/Screens/login_screen.dart';
import 'package:pos_controller/Utilities/customtoast.dart';
import 'package:pos_controller/services/apihelper.dart';
import 'package:pos_controller/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedHomeItemIndex = 0;
  String? selectedValue;
  String dropdownValue = '1-5';

  String userName = '';
  String userLoginTime = '';
  String userImage =
      'https://dev.infosparkles.com/pos/public/assets/images/place-holder.png';

  final jobRoleDropdownCtrl = TextEditingController();

  final List<String> list = [
    '1-5',
    '5-10',
    '10-15',
    '15-20',
  ];

  var names = [
    'Take a Break',
    'View/Print Your Checkout Report',
    'Manage Your Tips',
    'Check Gift Card Balances',
    'Enter Training Mode',
    'View Shift Notes',
    'Switch Users',
    'Contact Support',
  ];

  var icons = [
    'assets/icons/take_break.png',
    'assets/icons/print.png',
    'assets/icons/manage_tips.png',
    'assets/icons/check_gift.png',
    'assets/icons/enter_training.png',
    'assets/icons/view_shift.png',
    'assets/icons/switch_user2.png',
    'assets/icons/contact_support.png',
  ];

  void getProfileDetail() async {
    // setState(() {
    //   _showLoading = true;
    // });

    Loader.show(
      context,
      progressIndicator: const CircularProgressIndicator(
        backgroundColor: Color(0xffF2D35A),
        //color:Colors.teal,
        valueColor: AlwaysStoppedAnimation(Colors.grey),
        strokeWidth: 8,
      ),
    );

    var jsonData = await ApiHelper.getUserProfileData();
    // jsonData =  jsonData['data'];
    print('Get profile data - $jsonData');

    if (jsonData['status'] == true) {
      setState(() {
        userName = jsonData['data']['staff_name'].toString();
        userLoginTime = jsonData['data']['login_time'].toString();
        userImage = jsonData['data']['staff_image'].toString();
      });

      Loader.hide();
    } else {
      print(jsonData['message']);

      CustomToastHelper().showCustomToast(jsonData['message'], false);
      Loader.hide();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1), () {
      getProfileDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
        child: _selectedHomeItemIndex == 0
            ? // Home Screen
            ListView(
                padding: EdgeInsets.all(0),
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                   <--- left side
                          color: Color(0xff707070),
                          width: 1,
                        ),
                      ),
                    ),
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      onPressed: () {
                        showCustomPrintDialog();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  //color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                  border: Border.all(
                                    width: 2,
                                    color: Color(0xffFFBB00),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(userImage),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Clock-Out',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'mfont_Medium',
                                      color: Color(0xffFFFFFF),
                                    ),
                                  ),
                                  Text(
                                    '$userName (Server) Clocked-in $userLoginTime',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 12,
                                      fontFamily: 'mfont_Regular',
                                      color: Color(0xffAAAAAA),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                //                   <--- left side
                                color: Color(0xff707070),
                                width: 1,
                              ),
                            ),
                          ),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            onPressed: () {
                              switch (index) {
                                case 0:
                                  showCustomDialog();
                                  break;
                                case 1:
                                  setState(() {
                                    _selectedHomeItemIndex = 1;
                                  });
                                  break;
                                case 2:
                                  setState(() {
                                    _selectedHomeItemIndex = 2;
                                  });
                                  break;
                                case 5:
                                  setState(() {
                                    _selectedHomeItemIndex = 5;
                                  });
                                  break;
                              }
                            },
                            //    splashColor: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: Image.asset(icons[index]),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      // 'Take a Break',
                                      names[index].toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'mfont_Medium',
                                        color: Color(0xffFFFFFF),
                                      ),
                                    )
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        );
                      })
                ],
              )
            : _selectedHomeItemIndex == 1
                ? //-------------------------------- View/Print checkout Screen --------------------------------
                PrintCheckoutReportScreen()
                : _selectedHomeItemIndex == 2
                    ? //-------------------------------- Manage yor tips Screen --------------------------------
                    ManageYourTips()
                    : _selectedHomeItemIndex == 5
                        ? //-------------------------------- View shift notes Screen --------------------------------
                        ViewShiftNotesScreen()
                        : SizedBox(),
      ),
    );
  }

  showCustomDialog() {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: Container(
          height: 280,
          width: 540,
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
                    fontSize: 24,
                    fontFamily: 'mfont_Medium',
                    color: Color(0xffFFFFFF)),
                child: Text(
                  'Begin Your Break?',
                ),
              ),
              DefaultTextStyle(
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'mfont_Medium',
                    color: Color(0xff828282)),
                child: Text(
                  'Pleas select your break time',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Material(
                color: Colors.transparent,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 70),
                  decoration: BoxDecoration(
                      color: Color(0xff000000),
                      border: Border.all(color: Color(0xffAAAAAA), width: 0.5),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(3, 5),
                            blurRadius: 10,
                            color: Color(0xB3000000))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  height: 40,
                  child: CustomDropdown(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    fillColor: Colors.black,
                    hintText: 'Select time',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'mfont_Medium',
                      color: Color(0xff707070),
                    ),
                    listItemStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'mfont_Medium',
                      color: Color(0xff000000),
                    ),
                    items: list,
                    controller: jobRoleDropdownCtrl,
                    excludeSelected: false,
                    selectedStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'mfont_Medium',
                        color: Colors.yellow),
                    fieldSuffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 38,
                width: 120,
                decoration: BoxDecoration(
                  color: Color(0xffFFBB00),
                  borderRadius: BorderRadius.all(
                    Radius.circular(21),
                  ),
                  border: Border.all(width: 0.5, color: Color(0xffAAAAAA)),
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
                          fontFamily: 'mfont_Bold',
                          color: Color(0xff141414)),
                      child: Text(
                        'Save',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
                      onPressed: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
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
