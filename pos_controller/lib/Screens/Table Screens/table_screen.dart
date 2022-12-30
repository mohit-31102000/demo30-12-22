// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pos_controller/Screens/Table%20Screens/zones.dart';
import 'package:pos_controller/Utilities/customtoast.dart';
import 'package:pos_controller/services/apihelper.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TableScreen extends StatefulWidget {
  String orderId;
  TableScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  callback(varTopic) {
    setState(() {
      //_orderItemsist = varTopic;
      print('changed value : ' + varTopic.toString());
    });
  }

  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  var showZonesScreen = false;

  String? cashMethod = 'cash';

  List<OrderItemsModelClass> _orderItemsist = []; //mk
  List<MenuesModelClass> _menuesList = []; //mk
  List<ItemsModelClass> _itemsList = []; //mk

  String subTotal = '0.00';

  String orderStatus = 'Closed';

  String _singleValue = "Text alignment right";

  void getOrderDetailsLists() async {
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

    var jsonData = await ApiHelper.getOrderDetailLists(widget.orderId);
    // jsonData =  jsonData['data'];
    print('Get check detail lists data - $jsonData');

    if (jsonData['status'] == true) {
      setState(() {
        _orderItemsist = jsonData['data']['order_items']
            .map<OrderItemsModelClass>(
                (json) => OrderItemsModelClass.fromJson(json))
            .toList();

        _menuesList = jsonData['data']['menus']
            .map<MenuesModelClass>((json) => MenuesModelClass.fromJson(json))
            .toList();

        _itemsList = jsonData['data']['items']
            .map<ItemsModelClass>((json) => ItemsModelClass.fromJson(json))
            .toList();

        subTotal = jsonData['subtotal'].toString();
        orderStatus = jsonData['order_status'].toString();
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
    super.initState();
    Future.delayed(const Duration(milliseconds: 1), () {
      getOrderDetailsLists();
    });
  }

  @override
  Widget build(BuildContext context) {
    return showZonesScreen
        ? Zones()
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Checks',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'mfont_Medium'),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 32,
                                      width: 200,
                                      child: TextField(
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'mfont_Regular',
                                          color: Color(0xffFFBB00),
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Search Checks',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'mfont_Regular',
                                            color: Color(0xff707070),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffFFBB00),
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffAAAAAA),
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFBB00),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Color(0xffAAAAAA)),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 5),
                                              blurRadius: 8,
                                              color: Color(0xff000000))
                                        ],
                                      ),
                                      child: MaterialButton(
                                        padding: EdgeInsets.all(3),
                                        onPressed: () {},
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Image.asset(
                                            'assets/icons/search.png'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: SizedBox(
                                        height: 32,
                                        width: 32,
                                        child:
                                            Image.asset('assets/icons/plu.png'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'PLU',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff828282),
                                          fontFamily: 'mfont_Medium'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              height: 0.5,
                              color: Color(0xff828282),
                            ),
                            Expanded(
                              child: _itemsList.isNotEmpty
                                  ? ListView(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Wrap(
                                            spacing: 10,
                                            runSpacing: 8,
                                            children: List.generate(
                                              _itemsList.length,
                                              (index) {
                                                return InkWell(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   // showZonesScreen = true;
                                                    // });
                                                    if (orderStatus == 'open') {
                                                      addToCart(
                                                          _itemsList[index]
                                                              .itemId,
                                                          _itemsList[index]
                                                              .itemQuantity
                                                              .toString());
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2,
                                                            horizontal: 5),
                                                    height: 90,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffFF5656),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(6),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          _itemsList[index]
                                                              .itemTitle
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'mfont_Medium',
                                                              color: Color(
                                                                  0xffFFFFFF)),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            /*Text(
                                                                '-16',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'mfont_Regular',
                                                                    color: Color(
                                                                        0xffFFFFFF)),
                                                              ),*/
                                                            Text(
                                                              _itemsList[index]
                                                                  .itemPrice
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'mfont_Regular',
                                                                  color: Color(
                                                                      0xffFFFFFF)),
                                                            ),
                                                          ],
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
                                    )
                                  : Center(
                                      child: Text(
                                        'No records found',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'mfont_Medium',
                                            color: Colors.white),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: 450,
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
                        border:
                            Border.all(width: 0.5, color: Color(0xffAAAAAA)),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3, 5),
                              blurRadius: 10,
                              color: Color(0xff000000))
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 32,
                                //width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  border: Border.all(
                                    width: 1.5,
                                    color: Color(0xffFFBB00),
                                  ),
                                ),
                                child: MaterialButton(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.flip_camera_android_rounded,
                                        color: Color(0xffFFBB00),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Switch User',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffFFBB00),
                                            fontFamily: 'mfont_Medium'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                      height: 24,
                                      width: 24,
                                      child:
                                          Image.asset('assets/icons/send.png')),
                                  Text(
                                    'Send',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'mfont_Medium',
                                      color: Color(0xffCFCFCF),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            height: 1.5,
                            color: Color(0xff828282),
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 32,
                                      //width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(6),
                                        ),
                                        color: Color(0xffFFBB00),
                                      ),
                                      child: MaterialButton(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        onPressed: () {},
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                height: 24,
                                                width: 24,
                                                child: Image.asset(
                                                    'assets/icons/actions.png')),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Actions',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff141414),
                                                  fontFamily: 'mfont_Medium'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'BT-01',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xffFFFFFF),
                                          fontFamily: 'mfont_Medium'),
                                    ),
                                    Text(
                                      '24/08/17/ 10:26',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xffAAAAAA),
                                          fontFamily: 'mfont_Medium'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  //height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xff141414),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    border: Border.all(
                                        width: 0.5, color: Color(0xffAAAAAA)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: Image.asset(
                                                  'assets/icons/invoice.png'),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'Receipt',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'mfont_Medium',
                                                color: Color(0xff828282),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // showCustomEditDialog(

                                          // );
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: Image.asset(
                                                  'assets/icons/edit_item.png'),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'Edit Items',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'mfont_Medium',
                                                color: Color(0xff828282),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showCustomTransferDialogBox();
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: Image.asset(
                                                  'assets/icons/transfer.png'),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'Transfer',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'mfont_Medium',
                                                color: Color(0xff828282),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: Image.asset(
                                                  'assets/icons/no_sale.png'),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'No Sale',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'mfont_Medium',
                                                color: Color(0xff828282),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (orderStatus == 'open') {
                                            showCustomEditCheckDialogBox();
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: Image.asset(
                                                  'assets/icons/edit_checks.png'),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'Edit Check',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'mfont_Medium',
                                                color: Color(0xff828282),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DataTable(
                                  showCheckboxColumn: false,
                                  dataRowColor: MaterialStateColor.resolveWith(
                                      (states) => Color(0xff141414)),
                                  border: TableBorder.symmetric(
                                    // inside: BorderSide(
                                    //   width: 0.5,
                                    //   color: Color(
                                    //     0xffAAAAAA,
                                    //   ),
                                    // ),
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
                                        'ID',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'mfont_Medium',
                                          color: Color(0xffCFCFCF),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'QTY',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'mfont_Medium',
                                          color: Color(0xffCFCFCF),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Name',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'mfont_Medium',
                                          color: Color(0xffCFCFCF),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Price',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'mfont_Medium',
                                          color: Color(0xffCFCFCF),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Action',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'mfont_Medium',
                                          color: Color(0xffCFCFCF),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(_orderItemsist.length,
                                      (index) {
                                    return DataRow(
                                      onSelectChanged: (selected) {
                                        if (selected == true) {
                                          print(
                                            'order id : ' +
                                                widget.orderId.toString(),
                                          );
                                          print(
                                            'Item id : ' +
                                                _orderItemsist[index]
                                                    .itemId
                                                    .toString(),
                                          );
                                          print(
                                            'Item qty : ' +
                                                _orderItemsist[index]
                                                    .itemQty
                                                    .toString(),
                                          );
                                          print(
                                            'Item name : ' +
                                                _orderItemsist[index]
                                                    .itemName
                                                    .toString(),
                                          );
                                          print(
                                            'Item price : ' +
                                                _orderItemsist[index]
                                                    .itemPrice
                                                    .toString(),
                                          );
                                          if (orderStatus == 'open') {
                                            showCustomEditDialog(
                                              widget.orderId,
                                              _orderItemsist[index]
                                                  .orderItemId
                                                  .toString(),
                                              _orderItemsist[index]
                                                  .itemQty
                                                  .toString(),
                                              _orderItemsist[index]
                                                  .itemName
                                                  .toString(),
                                              _orderItemsist[index]
                                                  .itemPrice
                                                  .toString(),
                                              callback,
                                            );
                                          }
                                        }
                                      },
                                      cells: <DataCell>[
                                        DataCell(
                                          Text(
                                            _orderItemsist[index]
                                                .itemId
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'mfont_Regular',
                                              color: Color(0xffCFCFCF),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            _orderItemsist[index]
                                                .itemQty
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'mfont_Regular',
                                              color: Color(0xffCFCFCF),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            _orderItemsist[index]
                                                .itemName
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'mfont_Regular',
                                              color: Color(0xffCFCFCF),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            _orderItemsist[index]
                                                .itemPriceQty
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'mfont_Regular',
                                              color: Color(0xffCFCFCF),
                                            ),
                                          ),
                                        ),
                                        DataCell(Material(
                                          color: Colors.transparent,
                                          child: IconButton(
                                            onPressed: () {
                                              if (orderStatus == 'open') {
                                                deleteFromCart(
                                                  _orderItemsist[index]
                                                      .orderItemId
                                                      .toString(),
                                                );
                                              }
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            height: 1,
                            color: Color(0xff828282),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total :',
                                style: TextStyle(
                                    color: Color(0xffCFCFCF),
                                    fontSize: 12,
                                    fontFamily: 'mfont_Medium'),
                              ),
                              Text(
                                subTotal.toString(),
                                style: TextStyle(
                                    color: Color(0xffCFCFCF),
                                    fontSize: 20,
                                    fontFamily: 'mfont_Medium'),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            height: 1.5,
                            color: Color(0xffFFBB00),
                          ),
                          orderStatus == 'open'
                              ? _orderItemsist.isNotEmpty
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: RadioListTile(
                                            selected: true,
                                            contentPadding: EdgeInsets.all(0),
                                            title: Text(
                                              "Cash",
                                              style: TextStyle(
                                                  color: Color(0xffCFCFCF),
                                                  fontSize: 20,
                                                  fontFamily: 'mfont_Medium'),
                                            ),
                                            value: "cash",
                                            groupValue: cashMethod,
                                            onChanged: (value) {
                                              setState(() {
                                                cashMethod = value.toString();
                                                print(value);
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile(
                                            contentPadding: EdgeInsets.all(0),
                                            title: Text(
                                              "Stripe",
                                              style: TextStyle(
                                                  color: Color(0xffCFCFCF),
                                                  fontSize: 20,
                                                  fontFamily: 'mfont_Medium'),
                                            ),
                                            value: "stripe",
                                            groupValue: cashMethod,
                                            onChanged: (value) {
                                              setState(() {
                                                cashMethod = value.toString();
                                                print(value);
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Container(
                                          height: 48,
                                          //width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(6),
                                            ),
                                            color: Color(0xffFFBB00),
                                          ),

                                          child: MaterialButton(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            onPressed: () {
                                              if (cashMethod == 'cash') {
                                                showCashDialog(
                                                  context,
                                                  widget.orderId,
                                                );
                                              } else if (cashMethod ==
                                                  'stripe') {
                                                showPaymentDialogBox(
                                                  widget.orderId,
                                                  subTotal.toString(),
                                                );
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 32,
                                                  width: 32,
                                                  child: Image.asset(
                                                      'assets/icons/pay.png'),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Pay',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xff141414),
                                                      fontFamily:
                                                          'mfont_Semibold'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox()
                              : SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    width: 120,
                    height: 90,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 28,
                          width: 28,
                          child: Image.asset('assets/icons/customer_add.png'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Customer Add',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      height: 90,
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
                        border:
                            Border.all(width: 0.5, color: Color(0xffAAAAAA)),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3, 5),
                              blurRadius: 10,
                              color: Color(0xff000000))
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    width: 1, color: Color(0xff707070)),
                              ),
                            ),
                            child: FittedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child:
                                        Image.asset('assets/images/waiter.png'),
                                  ),
                                  Text(
                                    'Waiter',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'mfont_Medium',
                                        color: Color(0xffFFFFFF)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  getOrderDetailsLists();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 35),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 28,
                                          width: 28,
                                          child: Icon(
                                            Icons.menu_book,
                                            color: Color(0xff828282),
                                          )),
                                      Text(
                                        'All',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'mfont_Medium',
                                            color: Color(0xff828282)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children:
                                    List.generate(_menuesList.length, (index) {
                                  return InkWell(
                                    onTap: () {
                                      filterByItemName(
                                          _menuesList[index].menuId);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 35),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height: 28,
                                              width: 28,
                                              child: Icon(
                                                Icons.menu_book,
                                                color: Color(0xff828282),
                                              )),
                                          Text(
                                            _menuesList[index]
                                                .menuTitle
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'mfont_Medium',
                                                color: Color(0xff828282)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }

  //------------------------------------ For add to cart ------------------------------------
  void addToCart(
    itemId,
    itemQuantity,
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

    var jsonResponse = await ApiHelper.addToCart(
      widget.orderId.toString(),
      itemId.toString(),
      itemQuantity.toString(),
    );

    debugPrint('Add to cart Response - $jsonResponse');
    if (jsonResponse['status'].toString().toLowerCase() == 'true') {
      setState(() {
        _orderItemsist = jsonResponse['data']
            .map<OrderItemsModelClass>(
                (json) => OrderItemsModelClass.fromJson(json))
            .toList();
        subTotal = jsonResponse['subtotal'].toString();
      });

      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], true);
    } else {
      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], false);
    }
  }

  //------------------------------------ For delete from cart ------------------------------------
  void deleteFromCart(
    cartItemId,
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

    var jsonResponse = await ApiHelper.deleteFromCart(
      widget.orderId.toString(),
      cartItemId.toString(),
    );

    debugPrint('Delete from cart Response - $jsonResponse');
    if (jsonResponse['status'].toString().toLowerCase() == 'true') {
      setState(() {
        _orderItemsist = jsonResponse['data']
            .map<OrderItemsModelClass>(
                (json) => OrderItemsModelClass.fromJson(json))
            .toList();
      });

      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], true);
    } else {
      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], false);
    }
  }

  //------------------------------------ For filter items by item name ------------------------------------
  void filterByItemName(menuId) async {
    Loader.show(
      context,
      progressIndicator: const CircularProgressIndicator(
        backgroundColor: Color(0xffF2D35A),
        //color:Colors.teal,
        valueColor: AlwaysStoppedAnimation(Colors.grey),
        strokeWidth: 8,
      ),
    );

    var jsonResponse = await ApiHelper.filterByItemName(menuId);

    debugPrint('Filter by item name response - $jsonResponse');
    if (jsonResponse['status'].toString().toLowerCase() == 'true') {
      setState(() {
        _itemsList = jsonResponse['data']
            .map<ItemsModelClass>((json) => ItemsModelClass.fromJson(json))
            .toList();
      });

      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], true);
    } else {
      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], false);
    }
  }

  showCustomEditDialog(orderId, cartItemId, cartItemQty, cartItemName,
      cartItemPrice, callbackFunction) {
    showDialog(
      context: context,
      builder: (ctx) => showCustomDialog(
          orderId: orderId,
          cartItemId: cartItemId,
          cartItemQty: cartItemQty,
          cartItemName: cartItemName,
          cartItemPrice: cartItemPrice,
          callbackFunction: callbackFunction),
    );
  }

  showCustomTransferDialogBox() {
    showDialog(context: context, builder: (ctx) => showCustomTransferDialog());
  }

  showPaymentDialogBox(orderId, amount) {
    showDialog(
      context: context,
      builder: (ctx) => StripePaymentDialog(
        orderId: orderId,
        amount: amount,
      ),
    );
  }

  showCustomEditCheckDialogBox() {
    showDialog(
      context: context,
      builder: (ctx) => CustomEditCheckDialog(
        orderId: widget.orderId.toString(),
      ),
    );
  }
}

showCashDialog(context, morderId) {
  //------------------------------------ For Stripe Payment ------------------------------------
  void webServiceMakePaymentCash(
    String orderId,
    String token,
    String amount,
    String paymentType,
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

    var jsonResponse = await ApiHelper.makePayment(
      orderId,
      token,
      paymentType,
    );

    debugPrint('COD payment Response - $jsonResponse');
    if (jsonResponse['status'].toString().toLowerCase() == 'true') {
      CustomToastHelper().showCustomToast(jsonResponse['message'], true);

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
                offset: Offset(3, 5), blurRadius: 10, color: Color(0xff000000))
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
                'Are you sure to make payment ?',
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
                      webServiceMakePaymentCash(
                          morderId.toString(), '', '', 'cod');
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

//----------------------------------- Edit item DialogBox -----------------------------------
class showCustomDialog extends StatefulWidget {
  String? orderId;
  String? cartItemId;
  String? cartItemQty;
  String? cartItemName;
  String? cartItemPrice;
  final Function callbackFunction;
  showCustomDialog({
    Key? key,
    this.orderId,
    this.cartItemId,
    this.cartItemQty,
    this.cartItemName,
    this.cartItemPrice,
    required this.callbackFunction,
  }) : super(key: key);

  @override
  State<showCustomDialog> createState() => _showCustomDialogState();
}

class _showCustomDialogState extends State<showCustomDialog> {
  var count = 0;

  List<OrderItemsModelClass> _orderItemsist2 = []; //mk

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = int.parse(widget.cartItemQty.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 450,
          // height: 500,
          height: 160,
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
            children: [
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
                      'Order Edit',
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
                          print('Cart item quantity : ' +
                              widget.cartItemQty.toString());

                          updateToCart(widget.cartItemId, count.toString());
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 74,
                color: Color(0xff000000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // '$widget.cartItemName \$20.50',
                      widget.cartItemName.toString() +
                          "  \$" +
                          widget.cartItemPrice.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'mfont_Medium',
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                    Container(
                      height: 34,
                      //  width: 100,
                      decoration: BoxDecoration(
                          color: Color(0xff141414),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border:
                              Border.all(width: 0.5, color: Color(0xffAAAAAA))),
                      child: Row(
                        children: [
                          Container(
                            height: 34,
                            width: 34,
                            // color: Colors.red,
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  if (count != 0) {
                                    count--;
                                  }
                                });
                              },
                              padding: EdgeInsets.all(0),
                              child: Center(
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 34,
                            width: 34,
                            //   color: Colors.blue,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  width: 0.5,
                                  color: Color(0xffAAAAAA),
                                ),
                                right: BorderSide(
                                  width: 0.5,
                                  color: Color(0xffAAAAAA),
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                count.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'mfont_Medium',
                                  color: Color(0xffFFBB00),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 34,
                            width: 34,
                            // color: Colors.red,
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  count++;
                                });
                              },
                              padding: EdgeInsets.all(0),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              /*
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 34,
                              decoration: BoxDecoration(
                                color: Color(0xff141414),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                  width: 0.5,
                                  color: Color(0xffAAAAAA),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Table',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'mfont_Medium',
                                      color: Color(0xffFFFFFF),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'mfont_Regular',
                                          color: Color(0xffFFBB00),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 14,
                                        color: Color(0xffFFBB00),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 34,
                              decoration: BoxDecoration(
                                color: Color(0xff141414),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                  width: 0.5,
                                  color: Color(0xffAAAAAA),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Course',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'mfont_Medium',
                                      color: Color(0xffFFFFFF),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Entrees',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'mfont_Regular',
                                          color: Color(0xffFFBB00),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 14,
                                        color: Color(0xffFFBB00),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 34,
                      decoration: BoxDecoration(
                        color: Color(0xff141414),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(
                          width: 0.5,
                          color: Color(0xffAAAAAA),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Meat Temp',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Medium-Rare',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'mfont_Regular',
                                  color: Color(0xffFFBB00),
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: Color(0xffFFBB00),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 34,
                      decoration: BoxDecoration(
                        color: Color(0xff141414),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(
                          width: 0.5,
                          color: Color(0xffAAAAAA),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add Cheese',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Cheddar \$0.50',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'mfont_Regular',
                                  color: Color(0xffFFBB00),
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: Color(0xffFFBB00),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 34,
                      decoration: BoxDecoration(
                        color: Color(0xff141414),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(
                          width: 0.5,
                          color: Color(0xffAAAAAA),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Allergy',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Optional',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'mfont_Regular',
                                  color: Color(0x66FFFFFF),
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: Color(0xffFFBB00),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 34,
                      decoration: BoxDecoration(
                        color: Color(0xff141414),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(
                          width: 0.5,
                          color: Color(0xffAAAAAA),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Side 1',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Spicy Slaw',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'mfont_Regular',
                                  color: Color(0xffFFBB00),
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: Color(0xffFFBB00),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 34,
                      decoration: BoxDecoration(
                        color: Color(0xff141414),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(
                          width: 0.5,
                          color: Color(0xffAAAAAA),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Side 1',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Spicy Slaw',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'mfont_Regular',
                                  color: Color(0xffFFBB00),
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: Color(0xffFFBB00),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
              */
            ],
          ),
        ),
      ),
    );
  }

  //------------------------------------ For update to cart ------------------------------------
  void updateToCart(
    itemId,
    itemQuantity,
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

    var jsonResponse = await ApiHelper.updateToCart(
      widget.orderId.toString(),
      itemId.toString(),
      itemQuantity.toString(),
    );

    debugPrint('Update to cart Response - $jsonResponse');
    if (jsonResponse['status'].toString().toLowerCase() == 'true') {
      setState(() {
        _orderItemsist2 = jsonResponse['data']
            .map<OrderItemsModelClass>(
                (json) => OrderItemsModelClass.fromJson(json))
            .toList();
      });

      widget.callbackFunction(_orderItemsist2);

      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], true);
    } else {
      Loader.hide();
      CustomToastHelper().showCustomToast(jsonResponse['message'], false);
    }
  }
}

//----------------------------------- Transfer DialogBox -----------------------------------
class showCustomTransferDialog extends StatefulWidget {
  const showCustomTransferDialog({Key? key}) : super(key: key);

  @override
  State<showCustomTransferDialog> createState() =>
      _showCustomTransferDialogState();
}

class _showCustomTransferDialogState extends State<showCustomTransferDialog> {
  bool shouldCheck = false;
  bool shouldCheckDefault = false;

  var check1 = false;
  var check2 = false;

  var checkValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 450,
          height: 380,
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
            children: [
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
                      'Transfer Other User',
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
                              'Send',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          check1 = true;
                          check2 = false;
                          checkValue = 'Milo M. Horne';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        // height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 1, color: Color(0xff828282)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    border: Border.all(
                                      width: 1,
                                      color: check1
                                          ? Color(0xffFFBB00)
                                          : Color(0xffAAAAAA),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'M H',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'mfont_Regular',
                                        color: check1
                                            ? Color(0xffFFBB00)
                                            : Color(0xffAAAAAA),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Milo M. Horne',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'mfont_Regular',
                                    color: check1
                                        ? Color(0xffFFBB00)
                                        : Color(0xffAAAAAA),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  color: check1
                                      ? Color(0xffFFBB00)
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  border: Border.all(
                                    width: 1,
                                    color: check1
                                        ? Color(0xffFFBB00)
                                        : Color(0xff707070),
                                  ),
                                ),
                                child: check1
                                    ? Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                      )
                                    : null),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          check2 = true;
                          check1 = false;
                          checkValue = 'Virginia E. England';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        // height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 1, color: Color(0xff828282)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    border: Border.all(
                                      width: 1,
                                      color: check2
                                          ? Color(0xffFFBB00)
                                          : Color(0xffAAAAAA),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'V E',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'mfont_Regular',
                                        color: check2
                                            ? Color(0xffFFBB00)
                                            : Color(0xffAAAAAA),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Virginia E. England',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'mfont_Regular',
                                    color: check2
                                        ? Color(0xffFFBB00)
                                        : Color(0xffAAAAAA),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  color: check2
                                      ? Color(0xffFFBB00)
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  border: Border.all(
                                    width: 1,
                                    color: check2
                                        ? Color(0xffFFBB00)
                                        : Color(0xff707070),
                                  ),
                                ),
                                child: check2
                                    ? Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                      )
                                    : null),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//----------------------------------- Edit check DialogBox -----------------------------------
class CustomEditCheckDialog extends StatefulWidget {
  String? orderId;
  CustomEditCheckDialog({this.orderId, Key? key}) : super(key: key);
  @override
  _CustomEditCheckDialogState createState() => _CustomEditCheckDialogState();
}

class _CustomEditCheckDialogState extends State<CustomEditCheckDialog>
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

  void getCheckDetail() async {
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

    var jsonData = await ApiHelper.getCheckDetail(widget.orderId.toString());
    // jsonData =  jsonData['data'];
    print('Get check detail  - $jsonData');

    if (jsonData['status'] == true) {
      setState(() {
        phoneNumberController.text = jsonData['data']['phone'].toString();
        emailController.text = jsonData['data']['email'].toString();
        firstNameController.text = jsonData['data']['first_name'].toString();
        lastNameController.text = jsonData['data']['last_name'].toString();
        address1Controller.text = jsonData['data']['address1'].toString();
        address2Controller.text = jsonData['data']['address2'].toString();
        cityController.text = jsonData['data']['city'].toString();
        stateController.text = jsonData['data']['state'].toString();
      });

      Loader.hide();
    } else {
      print(jsonData['message']);

      CustomToastHelper().showCustomToast(jsonData['message'], false);
      Loader.hide();
    }
  }

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

    Future.delayed(const Duration(milliseconds: 1), () {
      getCheckDetail();
    });
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
                      'Edit Check',
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
                          containerSize = 550;
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 34,
                          decoration: BoxDecoration(
                            color: Color(0xff141414),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xffAAAAAA),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Table',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'mfont_Medium',
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'mfont_Regular',
                                      color: Color(0xffFFBB00),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: Color(0xffFFBB00),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 34,
                          decoration: BoxDecoration(
                            color: Color(0xff141414),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xffAAAAAA),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Guest',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'mfont_Medium',
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'mfont_Regular',
                                      color: Color(0xffFFBB00),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: Color(0xffFFBB00),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 34,
                          decoration: BoxDecoration(
                            color: Color(0xff141414),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xffAAAAAA),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Seated',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'mfont_Medium',
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '1 : 51 PM',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'mfont_Regular',
                                      color: Color(0xffFFBB00),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: Color(0xffFFBB00),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 34,
                          decoration: BoxDecoration(
                            color: Color(0xff141414),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xffAAAAAA),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tax Exempt',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'mfont_Medium',
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '1 : 51 PM',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'mfont_Regular',
                                      color: Color(0xffFFBB00),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: Color(0xffFFBB00),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 34,
                          decoration: BoxDecoration(
                            color: Color(0xff141414),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xffAAAAAA),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mandatory Gratuity',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'mfont_Medium',
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '1 : 51 PM',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'mfont_Regular',
                                      color: Color(0xffFFBB00),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: Color(0xffFFBB00),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              color: Color(0xff141414),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 34,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff141414),
                              border: OutlineInputBorder(),
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffFFFFFF),
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
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                              color: Color(0xff141414),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 34,
                          //width: 200,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffFFBB00),
                            ),
                            decoration: InputDecoration(
                              fillColor: Color(0xff141414),
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'mfont_Medium',
                                color: Color(0xffFFFFFF),
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
      webserviceUpdateCheck();
    }
  }

  //------------------------------------ For update check ------------------------------------
  void webserviceUpdateCheck() async {
    Loader.show(
      context,
      progressIndicator: const CircularProgressIndicator(
        backgroundColor: Color(0xffF2D35A),
        //color:Colors.teal,
        valueColor: AlwaysStoppedAnimation(Colors.grey),
        strokeWidth: 8,
      ),
    );

    var jsonResponse = await ApiHelper.updateCheck(
      widget.orderId.toString(),
      phoneNumberController.text.toString(),
      emailController.text.toString(),
      firstNameController.text.toString(),
      lastNameController.text.toString(),
      address1Controller.text.toString(),
      address2Controller.text.toString(),
      cityController.text.toString(),
      stateController.text.toString(),
    );

    debugPrint('Update check Response - $jsonResponse');
    if (jsonResponse['status'].toString().toLowerCase() == 'true') {
      CustomToastHelper().showCustomToast(jsonResponse['message'], true);

      Loader.hide();

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

//----------------------------------- Stripe Payment DialogBox -----------------------------------
class StripePaymentDialog extends StatefulWidget {
  String? orderId;
  String? amount;
  StripePaymentDialog({this.orderId, this.amount, Key? key}) : super(key: key);
  @override
  _StripePaymentDialogState createState() => _StripePaymentDialogState();
}

class _StripePaymentDialogState extends State<StripePaymentDialog>
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

  _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      setState(() {});
    }
  }

  void Function(CreditCardModel)? onCreditCardModelChange;
  CreditCardModel? creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '000');

  FocusNode cvvFocusNode = FocusNode();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void makeCardPayment() {
    final _expiryDateList = _expiryDateController.text.split("/");
    print("split " + _expiryDateList[0]);
    print("split " + _expiryDateList[1]);

    final CreditCard testCard = CreditCard(
      number: _cardNumberController.text.trim().toString(),
      expMonth: int.parse(_expiryDateList[0].trim().toString()),
      expYear: int.parse(_expiryDateList[1].trim().toString()),
      name: _cardHolderNameController.text.toString(),
      cvc: _cvvCodeController.text.toString(),
      // addressLine1: 'Address 1',
      // addressLine2: 'Address 2',
      // addressCity: 'City',
      // addressState: 'CA',
      // addressZip: '1337',
    );

    StripePayment.createTokenWithCard(
      testCard,
    ).then((token) {
      print(token.tokenId);
      //  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received ${token.tokenId}')));
      setState(() {
        _paymentToken = token;
      });
      webServiceMakePayment(
        widget.orderId.toString(),
        token.tokenId.toString(),
        widget.amount.toString(),
        'stripe',
      );
    }).catchError(setError);
  }

  Token? _paymentToken;
  PaymentMethod? _paymentMethod;
  String? _error;
  final String _currentSecret =
      "sk_test_51JmcapSEb3iBGuB6WZB7jpbmMkvvAy6EYr1LiWhIjV689Xb2pYZKRU2AAAxjKOEkeGu11E8e1WHGVShYar072RMZ00Z832L3y0"; //set this yourself, e.g using curl
  PaymentIntentResult? _paymentIntent;
  Source? _source;

  @override
  initState() {
    super.initState();

    _tabController = TabController(initialIndex: 2, length: 4, vsync: this);
    _tabController!.addListener(_handleTabSelection);
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51JmcapSEb3iBGuB6zXEkFkNxxk2neiRtRzOrdH9B1NRiEkk8SyTAdDIWn1q6RWevFCpwN7L55GugPUn8qVvc4IiF00hgZRERab",
        merchantId: "Your_Merchant_id",
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    //   _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(error.toString())));
    print('error ' + error.toString());
    setState(() {
      _error = error.toString();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 540,
          height: 400,
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
                      'Payment',
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
                          isValidate(context);
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
                              'Pay Now',
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
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Card Holder Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'mfont_Medium',
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 42,
                        decoration: BoxDecoration(
                          color: Color(0xff000000),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: TextFormField(
                          controller: _cardHolderNameController,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'mfont_Medium',
                            color: Color(0xffFFBB00),
                          ),
                          decoration: InputDecoration(
                            fillColor: Color(0xff000000),
                            border: OutlineInputBorder(),
                            hintText: 'Name',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffAAAAAA),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffFFBB00), width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffAAAAAA), width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Card Number',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'mfont_Medium',
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 42,
                        decoration: BoxDecoration(
                          color: Color(0xff000000),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: TextFormField(
                          controller: _cardNumberController,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'mfont_Medium',
                            color: Color(0xffFFBB00),
                          ),
                          decoration: InputDecoration(
                            fillColor: Color(0xff000000),
                            border: OutlineInputBorder(),
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'mfont_Medium',
                              color: Color(0xffAAAAAA),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffFFBB00), width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffAAAAAA), width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'mfont_Medium',
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: Color(0xff000000),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _expiryDateController,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'mfont_Medium',
                                      color: Color(0xffFFBB00),
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'MM/YY',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'mfont_Medium',
                                        color: Color(0xffAAAAAA),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffFFBB00),
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffAAAAAA),
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CVC',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'mfont_Medium',
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: Color(0xff000000),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _cvvCodeController,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'mfont_Medium',
                                      color: Color(0xffFFBB00),
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'XXX',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'mfont_Medium',
                                        color: Color(0xffAAAAAA),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffFFBB00),
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffAAAAAA),
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    onChanged: (String text) {
                                      setState(() {
                                        cvvCode = text;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //----------For Validation----------------
  void isValidate(var ctx) {
    if (_cardHolderNameController.text.trim().isEmpty) {
      CustomToastHelper()
          .showCustomToast('Card holder name must be filled out', false);

      return;
    } else if (_cardNumberController.text.trim().isEmpty) {
      CustomToastHelper()
          .showCustomToast('Card number must be filled out', false);

      return;
    } else if (_cardNumberController.text.trim().isEmpty) {
      CustomToastHelper()
          .showCustomToast('Card number must be filled out', false);

      return;
    } else if (_expiryDateController.text.trim().isEmpty) {
      CustomToastHelper()
          .showCustomToast('Expiry date must be filled out', false);

      return;
    } else if (_cvvCodeController.text.trim().isEmpty) {
      CustomToastHelper().showCustomToast('CVV code must be filled out', false);

      return;
    } else {
      print('Ready to submit');

      makeCardPayment();
    }
  }

  //------------------------------------ For Stripe Payment ------------------------------------
  void webServiceMakePayment(
    String orderId,
    String token,
    String amount,
    String paymentType,
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

    var jsonResponse = await ApiHelper.makePayment(
      orderId,
      token,
      paymentType,
    );

    debugPrint('Update check Response - $jsonResponse');
    if (jsonResponse['status'].toString().toLowerCase() == 'true') {
      CustomToastHelper().showCustomToast(jsonResponse['message'], true);

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

//----------------------------------- Modal classes -----------------------------------
class OrderItemsModelClass {
  String? orderItemId;
  String? itemId;
  String? itemName;
  String? itemPrice;
  String? itemQty;
  String? itemPriceQty;

  OrderItemsModelClass({
    this.orderItemId,
    this.itemId,
    this.itemName,
    this.itemPrice,
    this.itemQty,
    this.itemPriceQty,
  });

  factory OrderItemsModelClass.fromJson(Map<String, dynamic> json) {
    return OrderItemsModelClass(
      orderItemId: json["order_item_id"].toString(),
      itemId: json["item_id"].toString(),
      itemName: json["item_name"].toString(),
      itemPrice: json["item_price"].toString(),
      itemQty: json["item_qty"].toString(),
      itemPriceQty: json["item_price_qty"].toString(),
    );
  }
}

class MenuesModelClass {
  String? menuId;
  String? menuTitle;

  MenuesModelClass({
    this.menuId,
    this.menuTitle,
  });

  factory MenuesModelClass.fromJson(Map<String, dynamic> json) {
    return MenuesModelClass(
      menuId: json["menu_id"].toString(),
      menuTitle: json["menu_title"].toString(),
    );
  }
}

class ItemsModelClass {
  String? itemId;
  String? itemTitle;
  String? itemQuantity;
  String? itemPrice;

  ItemsModelClass(
      {this.itemId, this.itemTitle, this.itemQuantity, this.itemPrice});

  factory ItemsModelClass.fromJson(Map<String, dynamic> json) {
    return ItemsModelClass(
      itemId: json["item_id"].toString(),
      itemTitle: json["item_title"].toString(),
      itemQuantity: json["item_qty"].toString(),
      itemPrice: json["item_price"].toString(),
    );
  }
}
