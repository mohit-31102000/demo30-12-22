// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pos_controller/Screens/Home_screens/right_side_panel.dart';
import 'package:pos_controller/Screens/Table%20Screens/main_dining_room.dart';

class Zones extends StatefulWidget {
  const Zones({Key? key}) : super(key: key);

  @override
  State<Zones> createState() => _ZonesState();
}

class _ZonesState extends State<Zones> {
  var showMainDiningRoomScreen = false;

  @override
  Widget build(BuildContext context) {
    return showMainDiningRoomScreen
        ? MainDiningRoom()
        : Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xff000000),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(3, 5),
                            blurRadius: 10,
                            color: Color(0xff000000))
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Zones',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xffFFFFFF),
                              fontFamily: 'mfont_Medium'),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Color(0xff707070),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '0 of 20 Tables Occupied',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff828282),
                                    fontFamily: 'mfont_Medium'),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      width: 2,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                ),
                                width: 1,
                                height: 20,
                              ),
                              Text(
                                '2 Total Guests (0 at Tables)',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff828282),
                                    fontFamily: 'mfont_Medium'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 38,
                              //width: 120,
                              decoration: BoxDecoration(
                                // color: Color(0xffFFBB00),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(21),
                                ),
                                border: Border.all(
                                    width: 2, color: Color(0xff828282)),
                              ),
                              child: MaterialButton(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                onPressed: () {
                                  //showCustomDialog();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(21)),
                                child: Text(
                                  'Mine',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'mfont_Medium',
                                      color: Color(0xff828282)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 38,
                              //width: 120,
                              decoration: BoxDecoration(
                                color: Color(0xffFFBB00),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(21),
                                ),
                              ),
                              child: MaterialButton(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                onPressed: () {
                                  //showCustomDialog();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(21)),
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'mfont_Medium',
                                      color: Color(0xffFFFFFF)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Expanded(
                          child: ListView(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: List.generate(
                                    3,
                                    (index) {
                                      return InkWell(
                                          onTap: () {
                                            setState(() {
                                              showMainDiningRoomScreen = true;
                                            });
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.symmetric(vertical: 15),
                                            // height: 180,
                                            width: 220,
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
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: Color(0xffAAAAAA)),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(3, 5),
                                                    blurRadius: 10,
                                                    color: Color(0xff000000))
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 90,
                                                  width: 90,
                                                  child: Image.asset(
                                                      'assets/icons/tables.png'),
                                                ),
                                                Text(
                                                  'Main Dining Room',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xffFFFFFF),
                                                      fontFamily: 'mfont_Medium'),
                                                ),
                                                Text(
                                                  '12 Vacant',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xffCFCFCF),
                                                      fontFamily: 'mfont_Medium'),
                                                ),
                                              ],
                                            ),
                                          ));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                //-------------------------------- Right Side Panel --------------------------------
                RightSidePanel(),
              ],
            ),
          );
  }
}
