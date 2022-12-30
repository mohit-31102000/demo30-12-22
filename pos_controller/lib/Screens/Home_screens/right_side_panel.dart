import 'package:flutter/material.dart';

class RightSidePanel extends StatefulWidget {
  const RightSidePanel({Key? key}) : super(key: key);

  @override
  State<RightSidePanel> createState() => _RightSidePanelState();
}

class _RightSidePanelState extends State<RightSidePanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              offset: Offset(3, 5), blurRadius: 10, color: Color(0xff000000))
        ],
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                    const EdgeInsets.symmetric(horizontal: 5)),
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
    );
  }
}
