// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:pos_controller/Screens/Table%20Screens/table_screen.dart';
import 'package:pos_controller/Screens/tab_screen.dart';
import 'package:pos_controller/Utilities/customtoast.dart';
import 'package:pos_controller/services/apihelper.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  // Initial Selected Value
  //String dropdownvalue = 'All';
  String dropdownvalue2 = 'Desc';

  int _selectedHomeItemIndex = 0;

  var orderId;

  var _tabTextIndexSelected = 2;
  var _tabTextIndexSelected2 = 0;

  String? openCloseStatus = '';
  String? onlineWalkingStatus = '';

  //String? searchValue = '';
  String? sortBy = '';

  TextEditingController searchValueController = TextEditingController();

  // List of items in our dropdown menu
  // var items = [
  //   'Desc',
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  //   'Item 5',
  // ];
  var items2 = [
    'Desc',
    'Asc',
    'A to Z',
    'Z to A',
  ];

  final _listTextTabToggle = ["Open", "Closed", "All"];
  final _listTextTabToggle2 = ["Walking", "Online Ordering"];

  List<CheckListModelClass> _checkList = []; //mk

  void getCheckList(
    getopenCloseStatus,
    getonlineWalkingStatus,
    gertsearchValue,
    getsortBy,
  ) async {
    Loader.show(
      context,
      progressIndicator: const CircularProgressIndicator(
        backgroundColor: Color(0xffF2D35A),
        //color:Colors.teal,
        valueColor: AlwaysStoppedAnimation(Colors.grey),
        strokeWidth: 8,
      ),
    );

    var jsonData = await ApiHelper.getCheckList(
      getopenCloseStatus,
      getonlineWalkingStatus,
      gertsearchValue,
      getsortBy,
    );
    // jsonData =  jsonData['data'];
    print('Get check list data - $jsonData');

    if (jsonData['status'] == true) {
      setState(() {
        _checkList = jsonData['data']
            .map<CheckListModelClass>(
                (json) => CheckListModelClass.fromJson(json))
            .toList();
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
      getCheckList(
        openCloseStatus,
        onlineWalkingStatus,
        searchValueController.text,
        //  searchValue,
        sortBy,
      );
    });
  }

  callback(mOrderId, mIndex) {
    setState(() {
      orderId = mOrderId;
      _selectedHomeItemIndex = mIndex;
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
            Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    runSpacing: 15,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xffAAAAAA),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(19))),
                        child: FlutterToggleTab(
                          width: 20,
                          borderRadius: 19,
                          height: 40,
                          selectedIndex: _tabTextIndexSelected,
                          selectedBackgroundColors: [
                            Color(0xffFFBB00),
                            Color(0xffFFBB00),
                            Color(0xffFFBB00),
                          ],
                          unSelectedBackgroundColors: [
                            Color(0xff141414),
                            Color(0xff141414),
                            Color(0xff141414),
                          ],
                          selectedTextStyle: TextStyle(
                              color: Color(0xff141414),
                              fontSize: 14,
                              fontFamily: 'mfont_Semibold'),
                          unSelectedTextStyle: TextStyle(
                              color: Color(0xff828282),
                              fontSize: 14,
                              fontFamily: 'mfont_Semibold'),
                          labels: _listTextTabToggle,
                          selectedLabelIndex: (index) {
                            setState(() {
                              _tabTextIndexSelected = index;

                              switch (index) {
                                case 0:
                                  openCloseStatus = 'open';
                                  getCheckList(
                                    openCloseStatus,
                                    onlineWalkingStatus,
                                    searchValueController.text,
                                    // searchValue,
                                    sortBy,
                                  );
                                  break;
                                case 1:
                                  openCloseStatus = 'close';
                                  getCheckList(
                                    openCloseStatus,
                                    onlineWalkingStatus,
                                    searchValueController.text,
                                    // searchValue,
                                    sortBy,
                                  );
                                  break;
                                case 2:
                                  openCloseStatus = 'all';
                                  getCheckList(
                                    openCloseStatus,
                                    onlineWalkingStatus,
                                    searchValueController.text,
                                    //searchValue,
                                    sortBy,
                                  );
                                  break;
                              }

                              print('OpenClose Status : ' +
                                  openCloseStatus.toString());
                            });
                          },
                          isScroll: false,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xffAAAAAA),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(19))),
                        child: FlutterToggleTab(
                          width: 30,
                          borderRadius: 19,
                          height: 40,
                          selectedIndex: _tabTextIndexSelected2,
                          selectedBackgroundColors: [
                            Color(0xffFFBB00),
                            Color(0xffFFBB00),
                          ],
                          unSelectedBackgroundColors: [
                            Color(0xff141414),
                            Color(0xff141414),
                          ],
                          selectedTextStyle: TextStyle(
                              color: Color(0xff141414),
                              fontSize: 14,
                              fontFamily: 'mfont_Semibold'),
                          unSelectedTextStyle: TextStyle(
                              color: Color(0xff828282),
                              fontSize: 14,
                              fontFamily: 'mfont_Semibold'),
                          labels: _listTextTabToggle2,
                          selectedLabelIndex: (index) {
                            setState(() {
                              _tabTextIndexSelected2 = index;

                              switch (index) {
                                case 0:
                                  onlineWalkingStatus = 'walking';
                                  getCheckList(
                                    openCloseStatus,
                                    onlineWalkingStatus,
                                    searchValueController.text,
                                    //  searchValue,
                                    sortBy,
                                  );
                                  break;
                                case 1:
                                  onlineWalkingStatus = 'onlineordering ';
                                  getCheckList(
                                    openCloseStatus,
                                    onlineWalkingStatus,
                                    searchValueController.text,
                                    //searchValue,
                                    sortBy,
                                  );
                                  break;
                              }

                              print('onlineWalking Status : ' +
                                  onlineWalkingStatus.toString());
                            });
                          },
                          isScroll: false,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        height: 38,
                        width: 200,
                        child: TextField(
                          controller: searchValueController,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'mfont_Regular',
                            color: Color(0xffFFBB00),
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Search by id',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Regular',
                              color: Color(0xff707070),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
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
                        width: 10,
                      ),
                      Container(
                        height: 38,
                        width: 38,
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
                          padding: EdgeInsets.all(5),
                          onPressed: () {
                            getCheckList(
                              openCloseStatus,
                              onlineWalkingStatus,
                              searchValueController.text,
                              //  searchValue,
                              sortBy,
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Image.asset('assets/icons/search.png'),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 38,
                        width: 38,
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
                          padding: EdgeInsets.all(5),
                          onPressed: () {
                            setState(() {
                              openCloseStatus = 'all';
                              onlineWalkingStatus = '';
                              searchValueController.text = '';

                              sortBy = 'dsc';
                              dropdownvalue2 = 'Desc';

                              _tabTextIndexSelected = 2;
                            });

                            getCheckList(
                              openCloseStatus,
                              onlineWalkingStatus,
                              searchValueController.text,
                              //  searchValue,
                              sortBy,
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.refresh),
                        ),
                      ),
                      // Expanded(child: SizedBox()),
                      Row(
                        children: [
                          Container(
                            height: 38,
                            //width: 120,
                            decoration: BoxDecoration(
                              color: Color(0xffFFBB00),
                              borderRadius: BorderRadius.all(
                                Radius.circular(21),
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
                  SizedBox(
                    height: 30,
                  ),
                  _checkList.isNotEmpty
                      ? Expanded(
                          child: ListView(
                            padding: EdgeInsets.all(0),
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Sort by -',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'mfont_Regular',
                                          color: Color(0xff828282),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      DropdownButton(
                                        // Initial Value
                                        alignment: AlignmentDirectional.center,
                                        value: dropdownvalue2,
                                        underline: SizedBox(),

                                        // Down Arrow Icon
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Color(0xffFFBB00),
                                        ),
                                        dropdownColor: Colors.black,

                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'mfont_Regular',
                                          // color:
                                          //     Color(0xff141414),
                                          color: Color(0xffFFBB00),
                                        ),
                                        // Array list of items
                                        items: items2.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue2 = newValue!;
                                          });
                                          print('Sort by value : ' +
                                              dropdownvalue2.toString());

                                          setState(() {
                                            switch (dropdownvalue2) {
                                              case 'Desc':
                                                sortBy = 'dsc';
                                                break;
                                              case 'Asc':
                                                sortBy = 'asc';
                                                break;
                                              case 'A to Z':
                                                sortBy = 'a_to_z';
                                                break;
                                              case 'Z to A':
                                                sortBy = 'z_to_a';
                                                break;
                                            }
                                          });

                                          getCheckList(
                                            openCloseStatus,
                                            onlineWalkingStatus,
                                            searchValueController.text,
                                            //  searchValue,
                                            sortBy,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.infinity,
                                child: DataTable(
                                  showCheckboxColumn: false,
                                  dataRowColor: MaterialStateColor.resolveWith(
                                      (states) => Color(0xff141414)),
                                  border: TableBorder.symmetric(
                                    outside: BorderSide(
                                      width: 0.5,
                                      color: Color(
                                        0xffAAAAAA,
                                      ),
                                    ),
                                  ),
                                  // border: TableBorder.all(
                                  //   width: 0.5,
                                  //   color: Color(
                                  //     0xffAAAAAA,
                                  //   ),
                                  // ),
                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        'OrderID',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'mfont_Regular',
                                          color: Color(0xffCFCFCF),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Customer Name',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'mfont_Regular',
                                          color: Color(0xffCFCFCF),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Order Type',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'mfont_Regular',
                                          color: Color(0xffCFCFCF),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Status',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'mfont_Regular',
                                          color: Color(0xffCFCFCF),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'Total Amount',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'mfont_Regular',
                                            color: Color(0xffCFCFCF),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows:
                                      List.generate(_checkList.length, (index) {
                                    return DataRow(
                                      onSelectChanged: (selected) {
                                        if (selected == true) {
                                          print('object');
                                          setState(() {
                                            _selectedHomeItemIndex = 1;
                                            orderId = _checkList[index]
                                                .orderId
                                                .toString();
                                          });
                                        }
                                      },
                                      cells: <DataCell>[
                                        DataCell(
                                          Text(
                                            //   'Patio',
                                            _checkList[index]
                                                .orderId
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'mfont_Regular',
                                              color: Color(0xffCFCFCF),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            //    '220',
                                            _checkList[index]
                                                .customerName
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'mfont_Regular',
                                              color: Color(0xffCFCFCF),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            //    '220',
                                            _checkList[index]
                                                .orderType
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'mfont_Regular',
                                              color: Color(0xffCFCFCF),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: _checkList[index]
                                                      .paymentStatus
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'mfont_Regular',
                                                    color: Color(0xffCFCFCF),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '  ' +
                                                      _checkList[index]
                                                          .orderTime
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'mfont_Regular',
                                                    color: Color(0xff828282),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataCell(Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '\$',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'mfont_Regular',
                                                  color: Color(0xffFFBB00),
                                                ),
                                              ),
                                              TextSpan(
                                                text: _checkList[index]
                                                    .orderItemTotal
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'mfont_Regular',
                                                  color: Color(0xffFFFFFF),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )

                                            // Text(
                                            //   '\$ 499.00',
                                            //   style: TextStyle(
                                            //     fontSize: 14,
                                            //     fontFamily: 'mfont_Regular',
                                            //     color: Color(0xffCFCFCF),
                                            //   ),
                                            // ),
                                            ),
                                      ],
                                    );
                                  }),
                                ),
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: Text(
                              'No record found',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'mfont_Regular',
                                color: Color(0xffCFCFCF),
                              ),
                            ),
                          ),
                        ),
                ],
              )
            : _selectedHomeItemIndex == 1
                ? //-------------------------------- View/Print checkout Screen --------------------------------
                TableScreen(
                    orderId: orderId.toString(),
                  )
                : SizedBox(),
      ),
    );
  }

  showCustomDialog() {
    showDialog(
        context: context,
        builder: (ctx) => CustomAddNewCheckDialog(callbackFunction: callback));
  }
}

class CustomAddNewCheckDialog extends StatefulWidget {
  final Function callbackFunction;
  CustomAddNewCheckDialog({Key? key, required this.callbackFunction})
      : super(key: key);

  @override
  _CustomAddNewCheckDialogState createState() =>
      _CustomAddNewCheckDialogState();
}

class _CustomAddNewCheckDialogState extends State<CustomAddNewCheckDialog>
    with SingleTickerProviderStateMixin {
  var containerSize = 665.00;
  var tabIndex = 2;

  TabController? _tabController;

  var selectedTableColor = [];
  bool taxExemptStatus = false;
  bool mandatoryGratuityStatus = false;

  final guestDropdownCtrl = TextEditingController();
  final seatedDropdownCtrl = TextEditingController();
  final locationDropdownCtrl = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

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
    _tabController = TabController(initialIndex: 2, length: 4, vsync: this);
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
                        onPressed: () {
                          isValidate();
                        },
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
                            controller: phoneNumberController,
                            keyboardType: TextInputType.number,
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
                            controller: emailController,
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
                            controller: firstNameController,
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
                            controller: lastNameController,
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
                            controller: address1Controller,
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
                            controller: address2Controller,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter address 2',
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
                            controller: cityController,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter city',
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
                            controller: stateController,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff000000),
                              border: OutlineInputBorder(),
                              hintText: 'Enter state',
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

  //------------------------------------ For Validation ------------------------------------
  void isValidate() {
    var email = emailController.text.trim();
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);

    if (phoneNumberController.text.trim().isEmpty) {
      CustomToastHelper()
          .showCustomToast('Phone number must be filled out', false);

      return;
    }
    if (phoneNumberController.text.trim().length < 10 ||
        phoneNumberController.text.trim().length > 10) {
      CustomToastHelper()
          .showCustomToast('Phone number must be 10 digits', false);

      return;
    } else if (emailController.text.trim().isEmpty) {
      CustomToastHelper().showCustomToast('Email id must be filled out', false);
      return;
    } else if (!emailValid) {
      CustomToastHelper().showCustomToast('Enter valid email id', false);
    } else if (firstNameController.text.trim().isEmpty) {
      CustomToastHelper()
          .showCustomToast('First name must be filled out', false);

      return;
    } else if (lastNameController.text.trim().isEmpty) {
      CustomToastHelper()
          .showCustomToast('Last name must be filled out', false);
      return;
    } else {
      webserviceAddNewCheck();
    }
  }

  //------------------------------------ For add new check ------------------------------------
  void webserviceAddNewCheck() async {
    Loader.show(
      context,
      progressIndicator: const CircularProgressIndicator(
        backgroundColor: Color(0xffF2D35A),
        //color:Colors.teal,
        valueColor: AlwaysStoppedAnimation(Colors.grey),
        strokeWidth: 8,
      ),
    );

    var jsonResponse = await ApiHelper.addNewCheck(
      phoneNumberController.text.toString(),
      emailController.text.toString(),
      firstNameController.text.toString(),
      lastNameController.text.toString(),
      address1Controller.text.toString(),
      address2Controller.text.toString(),
      cityController.text.toString(),
      stateController.text.toString(),
    );

    debugPrint('Add new check Response - $jsonResponse');
    if (jsonResponse['status'].toString().toLowerCase() == 'true') {
      CustomToastHelper().showCustomToast(jsonResponse['message'], true);

      widget.callbackFunction(jsonResponse['order_id'], 1);
//917314823444
      Loader.hide();

       Navigator.pop(context, true);

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => TabScreen()),
      //   (Route<dynamic> route) => false,
      // );
    } else {
      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], false);
    }
  }
}

class CheckListModelClass {
  String? orderId;
  String? customerName;
  String? paymentStatus;
  String? orderTime;
  String? orderItemTotal;
  String? orderType;

  CheckListModelClass(
      {this.orderId,
      this.customerName,
      this.paymentStatus,
      this.orderTime,
      this.orderItemTotal,
      this.orderType});

  factory CheckListModelClass.fromJson(Map<String, dynamic> json) {
    return CheckListModelClass(
      orderId: json["order_id"].toString(),
      customerName: json["customer_name"].toString(),
      paymentStatus: json["order_status"].toString(),
      orderTime: json["order_time"].toString(),
      orderItemTotal: json["order_item_total"].toString(),
      orderType: json["order_type"].toString(),
    );
  }
}
