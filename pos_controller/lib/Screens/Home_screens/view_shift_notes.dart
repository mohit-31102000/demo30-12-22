// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pos_controller/widgets.dart';
import 'package:date_time_format/date_time_format.dart';

class ViewShiftNotesScreen extends StatefulWidget {
  const ViewShiftNotesScreen({Key? key}) : super(key: key);

  @override
  State<ViewShiftNotesScreen> createState() => _ViewShiftNotesScreenState();
}

class _ViewShiftNotesScreenState extends State<ViewShiftNotesScreen> {
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xffF2D35A), // header background color
              onPrimary: Color(0xff141414), // header text color
              onSurface: Color(0xff141414), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        // dateController.text =
        //     "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

        dateController.text = (DateTimeFormat.format(
            DateTime.parse(selected.toString()),
            format: 'j-M-y'));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Notes',
            style: TextStyle(
                fontSize: 20,
                color: Color(0xffFFFFFF),
                fontFamily: 'mfont_Medium'),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            height: 1,
            color: Color(0xff707070),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            //height: 112,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff141414),
              borderRadius: BorderRadius.all(
                Radius.circular(08),
              ),
              border: Border.all(
                color: Color(0xffAAAAAA),
                width: 0.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Notes Date',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xffFFFFFF),
                      fontFamily: 'mfont_Medium'),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 38,
                          width: 280,
                          decoration: BoxDecoration(
                            color: Color(0xff000000),
                            borderRadius: BorderRadius.all(
                              Radius.circular(21),
                            ),
                          ),
                          child: TextField(
                            controller: dateController,
                            readOnly: true,
                            onTap: () {
                              _selectDate(context);
                            },
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'mfont_Regular',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your note date',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffAAAAAA),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFFBB00), width: 0.5),
                                borderRadius: BorderRadius.circular(21),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffAAAAAA), width: 0.5),
                                borderRadius: BorderRadius.circular(21),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 38,
                          // width: 38,
                          decoration: BoxDecoration(
                            color: Color(0xffFFBB00),
                            borderRadius: BorderRadius.all(
                              Radius.circular(19),
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
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(19)),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/search.png',
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Search',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff141414),
                                      fontFamily: 'mfont_Semibold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 38,
                      //width: 120,
                      decoration: BoxDecoration(
                        color: Color(0xffFFBB00),
                        borderRadius: BorderRadius.all(
                          Radius.circular(21),
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
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        onPressed: () {
                          showCustomDialog();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21)),
                        child: Row(
                          children: [
                            Icon(Icons.add, color: Color(0xff141414)),
                            Text(
                              'Add New Checks',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'mfont_Semibold',
                                  color: Color(0xff141414)),
                            ),
                          ],
                        ),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Notes list',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffFFFFFF),
                    fontFamily: 'mfont_Medium'),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: 10,
                // shrinkWrap: true,
                //  physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff141414),
                      borderRadius: BorderRadius.all(
                        Radius.circular(08),
                      ),
                      border: Border.all(
                        color: Color(0xffAAAAAA),
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lorem Ipsum is simply',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffFFFFFF),
                                    fontFamily: 'mfont_Medium'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xff828282),
                                    fontFamily: 'mfont_Medium'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '2/03/22',
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff828282),
                              fontFamily: 'mfont_Medium'),
                        ),
                      ],
                    ),
                  );
                }),
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

  showCustomDialog() {
    showDialog(context: context, builder: (ctx) => CustomAddNewCheckDialog());
  }
}

class CustomAddNewCheckDialog extends StatefulWidget {
  @override
  _CustomAddNewCheckDialogState createState() =>
      _CustomAddNewCheckDialogState();
}

class _CustomAddNewCheckDialogState extends State<CustomAddNewCheckDialog>
    with SingleTickerProviderStateMixin {
  var containerSize = 450.00;
  var tabIndex = 0;

  TabController? _tabController;

  var selectedTableColor = [];
  bool taxExemptStatus = false;
  bool mandatoryGratuityStatus = false;

  final guestDropdownCtrl = TextEditingController();
  final seatedDropdownCtrl = TextEditingController();
  final locationDropdownCtrl = TextEditingController();

  final List<String> guestlist = [
    '1-5',
    '5-10',
    '10-15',
    '15-20',
  ];

  final List<String> seatedlist = [
    '1-5',
    '5-10',
    '10-15',
    '15-20',
  ];

  final List<String> locationlist = [
    '1-5',
    '5-10',
    '10-15',
    '15-20',
  ];

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController!.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 540,
          height: containerSize,
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
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xff141414),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: SizedBox(
                        width: 100,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: Image.asset('assets/icons/close.png'),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'New Check',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'mfont_Medium',
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                    Container(
                      height: 32,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xffFFBB00),
                        borderRadius: BorderRadius.all(
                          Radius.circular(21),
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
                        padding: EdgeInsets.all(0),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21)),
                        child: Center(
                          child: DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 14,
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
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.redAccent,
                  //   tabs: myTabs,
                  onTap: (index) {
                    debugPrint(index.toString());
                    switch (index) {
                      case 0:
                        setState(() {
                          tabIndex = 0;
                          containerSize = 450;
                        });
                        break;
                      case 1:
                        setState(() {
                          tabIndex = 1;
                          containerSize = 533;
                        });
                        break;
                      case 2:
                        setState(() {
                          tabIndex = 2;
                          containerSize = 665;
                        });
                        break;
                      case 3:
                        setState(() {
                          tabIndex = 3;
                        });
                        break;
                    }
                  },
                  indicator: BoxDecoration(),
                  tabs: [
                    Tab(
                      height: 74,
                      child: Container(
                        height: 74,
                        width: 74,
                        decoration: BoxDecoration(
                            color: tabIndex == 0 ? Color(0xff141414) : null,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: tabIndex == 0
                                ? Border.all(
                                    width: 0.5,
                                    color: Color(0xffAAAAAA),
                                  )
                                : null),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 48,
                              width: 48,
                              child: Image.asset(
                                'assets/icons/tables.png',
                                color: tabIndex == 0
                                    ? Color(0xffFFBB00)
                                    : Color(0xff828282),
                              ),
                            ),
                            Text(
                              'Tables',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: tabIndex == 0
                                    ? Color(0xffFFBB00)
                                    : Color(0xff828282),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      height: 74,
                      child: Container(
                        height: 74,
                        width: 74,
                        decoration: BoxDecoration(
                            color: tabIndex == 1 ? Color(0xff141414) : null,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: tabIndex == 1
                                ? Border.all(
                                    width: 0.5,
                                    color: Color(0xffAAAAAA),
                                  )
                                : null),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 48,
                              width: 48,
                              child: Image.asset(
                                'assets/icons/tab.png',
                                color: tabIndex == 1
                                    ? Color(0xffFFBB00)
                                    : Color(0xff828282),
                              ),
                            ),
                            Text(
                              'Tab',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: tabIndex == 1
                                    ? Color(0xffFFBB00)
                                    : Color(0xff828282),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      height: 74,
                      child: Container(
                        height: 74,
                        width: 74,
                        decoration: BoxDecoration(
                            color: tabIndex == 2 ? Color(0xff141414) : null,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: tabIndex == 2
                                ? Border.all(
                                    width: 0.5,
                                    color: Color(0xffAAAAAA),
                                  )
                                : null),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 48,
                              width: 48,
                              child: Image.asset(
                                'assets/icons/to_go.png',
                                color: tabIndex == 2
                                    ? Color(0xffFFBB00)
                                    : Color(0xff828282),
                              ),
                            ),
                            Text(
                              'To Go',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: tabIndex == 2
                                    ? Color(0xffFFBB00)
                                    : Color(0xff828282),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      height: 74,
                      child: Container(
                        height: 74,
                        width: 74,
                        decoration: BoxDecoration(
                            color: tabIndex == 3 ? Color(0xff141414) : null,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: tabIndex == 3
                                ? Border.all(
                                    width: 0.5,
                                    color: Color(0xffAAAAAA),
                                  )
                                : null),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 48,
                              width: 48,
                              child: Image.asset(
                                'assets/icons/delivery.png',
                                color: tabIndex == 3
                                    ? Color(0xffFFBB00)
                                    : Color(0xff828282),
                              ),
                            ),
                            Text(
                              'Delivery',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: tabIndex == 3
                                    ? Color(0xffFFBB00)
                                    : Color(0xff828282),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 0.5,
                color: Color(0xff828282),
              ),
              Center(
                child: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            'Select a table',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Wrap(
                          //  spacing: 10,
                          runSpacing: 8,
                          children: List.generate(
                            8,
                            (index) {
                              selectedTableColor.add(false);
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedTableColor[index] =
                                        !selectedTableColor[index];
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  height: 40,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    color: selectedTableColor[index]
                                        ? Color(0xffFFBB00)
                                        : Color(0xff141414),
                                    border: Border.all(
                                        width: 0.5, color: Color(0xffAAAAAA)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'mfont_Medium',
                                        color: selectedTableColor[index]
                                            ? Color(0xff141414)
                                            : Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 42,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter first name',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffAAAAAA),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFFBB00), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffAAAAAA), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 42,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter last name',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffAAAAAA),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFFBB00), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffAAAAAA), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                color: Color(0xffAAAAAA), width: 0.5),
                          ),
                          child: CustomDropdown(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            fillColor: Colors.black,
                            hintText: 'Enter guest',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffAAAAAA),
                            ),
                            listItemStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xff000000),
                            ),
                            items: guestlist,
                            controller: guestDropdownCtrl,
                            excludeSelected: false,
                            selectedStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffFFBB00)),
                            fieldSuffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xffAAAAAA),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                color: Color(0xffAAAAAA), width: 0.5),
                          ),
                          child: CustomDropdown(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            fillColor: Colors.black,
                            hintText: 'Enter seated',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffAAAAAA),
                            ),
                            listItemStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xff000000),
                            ),
                            items: seatedlist,
                            controller: seatedDropdownCtrl,
                            excludeSelected: false,
                            selectedStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffFFBB00)),
                            fieldSuffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xffAAAAAA),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                color: Color(0xffAAAAAA), width: 0.5),
                          ),
                          child: CustomDropdown(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            fillColor: Colors.black,
                            hintText: 'Enter zone',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffAAAAAA),
                            ),
                            listItemStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xff000000),
                            ),
                            items: locationlist,
                            controller: locationDropdownCtrl,
                            excludeSelected: false,
                            selectedStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffFFBB00)),
                            fieldSuffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xffAAAAAA),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Tax Exempt',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'mfont_Medium',
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                FlutterSwitch(
                                  width: 32.0,
                                  height: 18.0,
                                  toggleSize: 10.0,
                                  value: taxExemptStatus,
                                  borderRadius: 30.0,
                                  toggleColor: Color(0xff000000),
                                  activeToggleColor: Color(0xffFFBB00),
                                  inactiveToggleColor: Colors.white,
                                  activeSwitchBorder: Border.all(
                                    color: Color(0xffFFBB00),
                                    width: 0.5,
                                  ),
                                  inactiveSwitchBorder: Border.all(
                                    color: Colors.white,
                                    width: 0.5,
                                  ),
                                  activeColor: Color(0xff000000),
                                  inactiveColor: Color(0xff000000),
                                  onToggle: (val) {
                                    setState(() {
                                      taxExemptStatus = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Mandatory Gratuity',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'mfont_Medium',
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                FlutterSwitch(
                                  width: 32.0,
                                  height: 18.0,
                                  toggleSize: 10.0,
                                  value: mandatoryGratuityStatus,
                                  borderRadius: 30.0,
                                  toggleColor: Color(0xff000000),
                                  activeToggleColor: Color(0xffFFBB00),
                                  inactiveToggleColor: Colors.white,
                                  activeSwitchBorder: Border.all(
                                    color: Color(0xffFFBB00),
                                    width: 0.5,
                                  ),
                                  inactiveSwitchBorder: Border.all(
                                    color: Colors.white,
                                    width: 0.5,
                                  ),
                                  activeColor: Color(0xff000000),
                                  inactiveColor: Color(0xff000000),
                                  onToggle: (val) {
                                    setState(() {
                                      mandatoryGratuityStatus = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 42,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter phone number',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffAAAAAA),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFFBB00), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffAAAAAA), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 42,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter email',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffAAAAAA),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFFBB00), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffAAAAAA), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 42,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter first name',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffAAAAAA),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFFBB00), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffAAAAAA), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 42,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter last name',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffAAAAAA),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFFBB00), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffAAAAAA), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 42,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter address 1',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffAAAAAA),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFFBB00), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffAAAAAA), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 42,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter last name',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffAAAAAA),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFFBB00), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffAAAAAA), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 42,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter first name',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffAAAAAA),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFFBB00), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffAAAAAA), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 42,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter last name',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffAAAAAA),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFFBB00), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffAAAAAA), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(),
                ][_tabController!.index],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
