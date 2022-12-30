// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pos_controller/widgets.dart';

class PrintCheckoutReportScreen extends StatefulWidget {
  const PrintCheckoutReportScreen({Key? key}) : super(key: key);

  @override
  State<PrintCheckoutReportScreen> createState() =>
      _PrintCheckoutReportScreenState();
}

class _PrintCheckoutReportScreenState extends State<PrintCheckoutReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'checkout report',
            style: TextStyle(
                fontSize: 20,
                color: Color(0xffFFFFFF),
                fontFamily: 'mfont_Medium'),
          ),
          Text(
            'Laura L. McKim July 10, 2020',
            style: TextStyle(
                fontSize: 14,
                color: Color(0xff828282),
                fontFamily: 'mfont_Medium'),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            height: 1,
            color: Color(0xff707070),
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  //height: 100,
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Role',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                ': Waiter',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffFFFFFF),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Shift',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                ': 1',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffFFFFFF),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Clock-in',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: MarqueeWidget(
                                direction: Axis.horizontal,
                                animationDuration: Duration(milliseconds: 2500),
                                child: Text(
                                  ': July 10 - 2020, 10 : 00 AM',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'mfont_Regular'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Clock-out',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: MarqueeWidget(
                                direction: Axis.horizontal,
                                animationDuration: Duration(milliseconds: 2500),
                                child: Text(
                                  ': July 10 - 2020, 7 : 00 PM',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'mfont_Regular'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Paid Hours',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: MarqueeWidget(
                                direction: Axis.horizontal,
                                animationDuration: Duration(milliseconds: 2500),
                                child: Text(
                                  ': 9 . 00',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'mfont_Regular'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  //height: 100,
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Break Time',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                ': 0 . 00',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffFFFFFF),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Cash Owed To House',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                ': \$ 20 . 02',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffFFFFFF),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Total Tips',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: MarqueeWidget(
                                direction: Axis.horizontal,
                                animationDuration: Duration(milliseconds: 2500),
                                child: Text(
                                  ': \$ 0 . 00',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'mfont_Regular'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Total Auto Grat',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: MarqueeWidget(
                                direction: Axis.horizontal,
                                animationDuration: Duration(milliseconds: 2500),
                                child: Text(
                                  ': \$ 2 . 43',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'mfont_Regular'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            height: 1,
            color: Color(0xff707070),
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  //height: 100,
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Gross Sales',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: MarqueeWidget(
                                direction: Axis.horizontal,
                                animationDuration: Duration(milliseconds: 2500),
                                child: Text(
                                  ': \$ 17 . 59',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'mfont_Regular'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Food',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: MarqueeWidget(
                                direction: Axis.horizontal,
                                animationDuration: Duration(milliseconds: 2500),
                                child: Text(
                                  ': \$ 13 . 59',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'mfont_Regular'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Beverage',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: MarqueeWidget(
                                direction: Axis.horizontal,
                                animationDuration: Duration(milliseconds: 2500),
                                child: Text(
                                  ': \$ 4 . 00',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'mfont_Regular'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  //height: 100,
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Net Sales',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                ': \$ 16 . 18',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffFFFFFF),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Food',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: MarqueeWidget(
                                direction: Axis.horizontal,
                                animationDuration: Duration(milliseconds: 2500),
                                child: Text(
                                  ': \$ 12 . 59',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'mfont_Regular'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Beverage',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffAAAAAA),
                                    fontFamily: 'mfont_Regular'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: MarqueeWidget(
                                direction: Axis.horizontal,
                                animationDuration: Duration(milliseconds: 2500),
                                child: Text(
                                  ': \$ 3 . 00',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'mfont_Regular'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            height: 1,
            color: Color(0xff707070),
          ),
          SizedBox(
            height: 20,
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
              onPressed: () {
                showCustomPrintDialog();
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
                    'Print',
                  ),
                ),
              ),
            ),
          )
        ],
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
