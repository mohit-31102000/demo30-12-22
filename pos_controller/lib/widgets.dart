// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

//hello

//-------------------Marquee Widget---------------------
class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;

  const MarqueeWidget({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 6000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: Curves.ease,
        );
      }
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          0.0,
          duration: widget.backDuration,
          curve: Curves.easeOut,
        );
      }
    }
  }
}

//-------------------Custom Drawer Widget---------------------
class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isUserLoggedIn = false;
  final List<String> drawerName = [];
  //final List<String> drawerIcon = [];

  @override
  void initState() {
    // TODO: implement initState

    print('Calling Open Drawer');

    super.initState();
  }

  var loaderValue = 'Loading...';

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Drawer(
        key: _scaffoldKey,
        backgroundColor: Color(0xff141414),
        child: Container(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                    padding: const EdgeInsets.symmetric(
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
        ));
  }

/*
  void _showConfirmationAlertDialog(mycontext) {
    // flutter defined function
    showDialog(
      context: mycontext,
      //context: mynavigatorKey.currentState!.context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text(
            "Logout Confirmation",
            style:
                TextStyle(fontFamily: 'ProductSans', color: Color(0xff002E5E)),
          ),
          content: const Text(
            "Are you sure you want to logout now?",
            style: TextStyle(
              fontFamily: 'ProductSans',
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Please let us know your gender:'),
                    ListTile(
                      leading: Radio<String>(
                        value: 'male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Male'),
                    ),
                    ListTile(
                      leading: Radio<String>(
                        value: 'female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            print('khan');
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Female'),
                    ),
                    const SizedBox(height: 25),
                    Text(_selectedGender == 'male'
                        ? 'Hello gentlement!'
                        : 'Hi lady!')
                  ],
                )),

            // usually buttons at the bottom of the dialog
            /* FlatButton(
              color: Colors.grey[300],
              child: const Text(
                " CANCEL ",
                style: TextStyle(
                  fontFamily: 'ProductSans',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: const Color(0xff002E5E),
              child: const Text(
                " PROCEED ",
                style:
                    TextStyle(fontFamily: 'ProductSans', color: Colors.white),
              ),
              onPressed: () {
                // clearallprefrenceonlogout(mycontext);
              },
            ),*/
          ],
        );
      },
    );
  }


void clearallprefrenceonlogout(mycontext) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.clear();

  Navigator.pushAndRemoveUntil(mycontext, PageRouteBuilder(pageBuilder:
      (BuildContext context, Animation animation, secondaryAnimation) {
    return LoginScreen();
  }), (Route route) => false);
}*/

/*
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel".toUpperCase()),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue".toUpperCase()),
      onPressed: () {
        gotoScreen(context, const LoginScreen());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure want to logout ?"),
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
*/
  /*
  void gotoScreen(BuildContext context, var name) {
    Navigator.push(
      context,
      PageTransition(type: PageTransitionType.fade, child: name),
    );
    // Navigator.push(
    //   context,
    //   PageTransition(
    //     type: PageTransitionType.rightToLeft,
    //     child: name,
    //   ),
    // );
  }*/
}
