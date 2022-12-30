// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pos_controller/Screens/Home_screens/right_side_panel.dart';

class MainDiningRoom extends StatefulWidget {
  const MainDiningRoom({Key? key}) : super(key: key);

  @override
  State<MainDiningRoom> createState() => _MainDiningRoomState();
}

class _MainDiningRoomState extends State<MainDiningRoom> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    'Main Dining Room',
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
                          border:
                              Border.all(width: 2, color: Color(0xffFFBB00)),
                        ),
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          onPressed: () {
                            //showCustomDialog();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21)),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffFFBB00)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: List.generate(
                              15,
                              (index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      // showZonesScreen = true;
                                    });
                                  },
                                  child: Container(
                                    //  padding: EdgeInsets.symmetric(vertical: 15),
                                    // height: 180,
                                    width: 140,
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
                                          width: 0.5, color: Color(0xffAAAAAA)),
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
                                        SizedBox(
                                          height: 60,
                                          width: 60,
                                          child: Image.asset(
                                              'assets/icons/main_dining_room_table.png'),
                                        ),
                                        Text(
                                          'Tables',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff828282),
                                              fontFamily: 'mfont_Medium'),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 42,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icons/main_dining_room_bg.png'),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                            (index + 1).toString(),
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Color(0xff000000),
                                                  fontFamily: 'mfont_Semibold'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
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
