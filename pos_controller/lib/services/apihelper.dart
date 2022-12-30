import 'dart:convert';
import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:pos_controller/services/api.dart';
import 'package:pos_controller/services/networking.dart';
import 'package:pos_controller/services/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<dynamic> loginUserDetail(
    String userName,
    String password,
  ) async {
    Map<String, String> body = {
      'email': userName,
      'password': password,
      'language_id': '1',
      'device_id': await FlutterUdid.udid,
    };

    var url = '${Api.kLoginUrl}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Get user profile data --------------------------------------
  static Future<dynamic> getUserProfileData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'language_id': '1',
      'device_id': await FlutterUdid.udid,
    };

    var url =
        '${Api.kGetUserProfileData}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Update user profile data --------------------------------------
  static Future<dynamic> updateUserProfileData(
    String userName,
    String userEmail,
    String userImage,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'language_id': '1',
      'staff_name': userName.toString(),
      'device_id': await FlutterUdid.udid,
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'staff_email': userEmail.toString(),
    };

    var url = '${Api.kLoginUrl}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Change password --------------------------------------
  static Future<dynamic> changePassword(String currentPassword,
      String newPassword, String confirmPassword) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'language_id': '1',
      'device_id': await FlutterUdid.udid,
      'password': currentPassword.toString(),
      'new_password': newPassword.toString(),
      'confirm_password': confirmPassword.toString(),
    };

    var url =
        '${Api.kChangePasswordUrl}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Add new check --------------------------------------
  static Future<dynamic> addNewCheck(
    String phoneNumber,
    String emailId,
    String firstName,
    String lastName,
    String address1,
    String address2,
    String city,
    String state,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'language_id': '1',
      'device_id': await FlutterUdid.udid,
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'phone': phoneNumber,
      'email': emailId,
      'first_name': firstName,
      'last_name': lastName,
      'address1': address1,
      'address2': address2,
      'city': city,
      'state': state,
    };

    var url = '${Api.kAddNewCheck}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Update check --------------------------------------
  static Future<dynamic> updateCheck(
    String orderId,
    String phoneNumber,
    String emailId,
    String firstName,
    String lastName,
    String address1,
    String address2,
    String city,
    String state,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'language_id': '1',
      'order_id': orderId.toString(),
      'device_id': await FlutterUdid.udid,
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'phone': phoneNumber,
      'email': emailId,
      'first_name': firstName,
      'last_name': lastName,
      'address1': address1,
      'address2': address2,
      'city': city,
      'state': state,
    };

    var url = '${Api.kUpdateCheck}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Make Payment --------------------------------------
  static Future<dynamic> makePayment(
    String orderId,
    String token,
 
    String paymentType,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'language_id': '1',
      'order_id': orderId.toString(),
      'device_id': await FlutterUdid.udid,
      'stripeToken': token.toString(),
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'payment_type': paymentType,
    };

    var url = '${Api.kmakePayment}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Get check list data --------------------------------------
  static Future<dynamic> getCheckList(
      checkStatus, orderType, search, sortBy) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'language_id': '1',
      'device_id': await FlutterUdid.udid,
      'check_status': checkStatus.toString(),
      'order_type': orderType.toString(),
      'search': search.toString(),
      'sort_by': sortBy.toString()
    };

    var url = '${Api.kGetCheckList}?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Get order detail lists data --------------------------------------
  static Future<dynamic> getOrderDetailLists(String orderId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'language_id': '1',
      'device_id': await FlutterUdid.udid,
      'order_id': orderId.toString(),
    };

    var url =
        '${Api.kGetCheckDetalList}?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //-------------------------------------- Add to cart --------------------------------------
  static Future<dynamic> addToCart(
    String orderId,
    String itemId,
    String itemQuantity,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'language_id': '1',
      'device_id': await FlutterUdid.udid,
      'order_id': orderId,
      'item_id': itemId,
      'item_qty': itemQuantity,
    };

    var url = '${Api.kAddToCartUrl}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //-------------------------------------- Delete from cart ---------------------------------
  static Future<dynamic> deleteFromCart(
    String orderId,
    String cartItemId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'language_id': '1',
      'device_id': await FlutterUdid.udid,
      'order_id': orderId.toString(),
      'cart_item_id': cartItemId.toString(),
    };

    var url =
        '${Api.kDeleteFromCartUrl}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //-------------------------------------- Update to cart --------------------------------------
  static Future<dynamic> updateToCart(
    String orderId,
    String itemId,
    String itemQuantity,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'language_id': '1',
      'device_id': await FlutterUdid.udid,
      'order_id': orderId,
      'cart_item_id': itemId,
      'cart_item_qty': itemQuantity,
    };

    var url = '${Api.kUpdateToCartUrl}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Get check detail data --------------------------------------
  static Future<dynamic> getCheckDetail(String? orderId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'language_id': '1',
      'device_id': await FlutterUdid.udid,
      'order_id': orderId.toString(),
    };

    var url = '${Api.kGetCheckDetail}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //-------------------------------------- Filter by item name --------------------------------------
  static Future<dynamic> filterByItemName(
    String menuId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'staff_id': pref.getString('NSUD_staff_id') ?? '0',
      'password': pref.getString('NSUD_staff_password') ?? '0',
      'language_id': '1',
      'device_id': await FlutterUdid.udid,
      'menu_id': menuId.toString(),
    };

    var url = '${Api.kFilterByNameUrl}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  /*
  static const String _customerIDPrefKey = 'customer_id_pref_key';

  static Future<String> getCustomerID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_customerIDPrefKey) ?? '0';
  }

  static Future<bool> setCustomerID(String customerID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_customerIDPrefKey, customerID);
  }

  static Future<bool> removeCustomerID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(_customerIDPrefKey);
  }

  static Future<dynamic> submitRegistrationUserDetail(
    String restaurantName,
    String emailId,
    String phoneNumber,
    int country,
    int state,
    int city,
    String password,
    String confirmPassword,
  ) async {
    Map<String, String> body = {
      'restaurant_name': restaurantName,
      'email': emailId,
      'password': password,
      'confirm_password': confirmPassword,
      'phone_no': phoneNumber,
      'country_id': country.toString(),
      'state_id': state.toString(),
      'city_id': city.toString(),
    };

    var url = '${Api.kRegistrationUrl}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  

  static Future<dynamic> forgetpasswordcheckmobilenumberexist(
      String phoneNumber, String newpassword, String confirmpassword) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'phone_no': phoneNumber,
      'new_password': newpassword,
      'confirm_password': confirmpassword,
    };

    var accessToken = await Token.getToken();
    var url = '${Api.kForgetPasswordUrl}?access_token=$accessToken';

    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getUniversalPopuplsit(String myURL) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url = '$myURL/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> deleteIcon(
    int iconId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'icon_id': iconId.toString(),
    };
    var url = '${Api.kDeleteIcon}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getVendorlsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url = '${Api.kVendorList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> addQuantityNewProduct(
      String locationid,
      String vendorid,
      String inventoryid,
      String productid,
      int quantity,
      int wheightValue) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'location_id': locationid.toString(),
      'vendor_id': vendorid.toString(),
      'inventry_id': inventoryid.toString(),
      'product_id': productid.toString(),
      'quantity': quantity.toString(),
      'weight': wheightValue.toString(),
    };

    var url =
        '${Api.kAddQuantityNewProduct}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getPurchaseOrderlsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url =
        '${Api.kPurchaseOrderList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getRecievedOrderlsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url =
        '${Api.kRecievedOrderList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> addQuantity(String inventoryquantityid,
      String containertype, int quantity, int weight) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'inventry_product_id': inventoryquantityid.toString(),
      'quantity_type': containertype,
      'quantity': quantity.toString(),
      'weight': weight.toString(),
    };

    var url = '${Api.kAddQuantity}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }
  //============================================ Old code add Quantity  ===========================================
  // static Future<dynamic> addQuantity(
  //   String productid,
  //   String containertype,
  //   int quantity,
  // ) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   Map<String, String> body = {
  //     'user_id': pref.getString('NSUD_userid') ?? '0',
  //     'product_id': productid.toString(),
  //     'container_type': containertype,
  //     'quantity': quantity.toString(),
  //   };

  //   var url = '${Api.kAddQuantity}/?access_token=${await Token.getToken()}';
  //   debugPrint('Url - $url');
  //   debugPrint('Parameter Body - $body');
  //   return jsonDecode(await Networking.post(url, body));
  // }

  static Future<dynamic> addNewproduct(
      String productname,
      String productcode,
      int producttypeid,
      int productcategoryid,
      String containerType,
      // String containerSize,
      String units,
      String singleportionunit,
      String singleportionsize,
      String retailportionprice,
      String wholesalecontainerprice,
      String emptyweight,
      String fullweight,
      String vendorcode,
      int vendorid,
      String casesize,
      String par,
      String recorderpoint,
      String orderby,
      String idealpourcost,
      String presentation) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'product_name': productname,
      'product_code': productcode,
      'product_type_id': producttypeid.toString(),
      'product_categorie_id': productcategoryid.toString(),
      'container_type': containerType,
      //'container_size': containerSize,
      'units': units,
      'single_portion_unit': singleportionunit,
      'single_portion_size': singleportionsize,
      'retail_portion_price': retailportionprice,
      'wholesale_container_price': wholesalecontainerprice,
      'empty_weight': emptyweight,
      'full_weight': fullweight,
      'vendor_code': vendorcode,
      'vendor_id': vendorid.toString(),
      'case_size': casesize,
      'par': par,
      'reorder_point': recorderpoint,
      'order_by_the': orderby,
      'ideal_pour_cost': idealpourcost,
      'quantity': presentation,
    };

    var url = '${Api.kAddNewProduct}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> addProductToOrder(
    int productid,
    String orderbythe,
    String quantity,
    String casesize,
    String wholesalevalue,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'product_id': productid.toString(),
      'order_by': orderbythe,
      'quantity': quantity,
      'case_size': casesize,
      'wholesale_value': wholesalevalue,
    };

    var url =
        '${Api.kAddProductToOrder}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> updateproduct(
      String productid,
      String productname,
      String productcode,
      int producttypeid,
      int productcategoryid,
      String containerType,
      // String containerSize,
      String units,
      String singleportionunit,
      String singleportionsize,
      String retailportionprice,
      String wholesalecontainerprice,
      String emptyweight,
      String fullweight,
      String vendorcode,
      int vendorid,
      String casesize,
      String par,
      String recorderpoint,
      String orderby,
      String idealpourcost,
      String presentation) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'product_id': productid,
      'product_name': productname,
      'product_code': productcode,
      'product_type_id': producttypeid.toString(),
      'product_categorie_id': productcategoryid.toString(),
      'container_type': containerType,
      // 'container_size': containerSize,
      'units': units,
      'single_portion_unit': singleportionunit,
      'single_portion_size': singleportionsize,
      'retail_portion_price': retailportionprice,
      'wholesale_container_price': wholesalecontainerprice,
      'empty_weight': emptyweight,
      'full_weight': fullweight,
      'vendor_code': vendorcode,
      'vendor_id': vendorid.toString(),
      'case_size': casesize,
      'par': par,
      'reorder_point': recorderpoint,
      'order_by_the': orderby,
      'ideal_pour_cost': idealpourcost,
      'quantity': presentation,
    };

    var url = '${Api.kUpdateProduct}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> addNewVendor(
    String vendortname,
    String vendoremailid,
    String contactname,
    String phoneneumber,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'vendor_name': vendortname,
      'email': vendoremailid,
      'contact_name': contactname,
      'phone_number': phoneneumber,
    };

    var url = '${Api.kAddNewVendor}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> addNewIconMultipart(
      String iconName, File selectImage) async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    var accessToken = await Token.getToken();

    var postUri =
        Uri.parse('${Api.kForgetPasswordUrl}?access_token=$accessToken');

    var request = http.MultipartRequest("POST", postUri);
    request.fields["user_id"] = pref.getString('NSUD_userid') ?? '0';
    request.fields["icon_name"] = iconName;

    request.files
        .add(await http.MultipartFile.fromPath('image', selectImage.path));

    await request.send().then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        // print(value);
        return json.decode(value);
      });
    }).catchError((e) {
      print('e');
      print(e);
    });
  }

  static Future<dynamic> getIconslsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url = '${Api.kIconList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getProductTypelsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url = '${Api.kProducttypeList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getInventorylsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url = '${Api.kInventoriesList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> updateInventory(
      String inventoryId,
      //  String inventoryDescription,
      //  String inventoryNotes,
      String date,
      String vendorId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'inventry_id': inventoryId.toString(),
      //'description': inventoryDescription,
      //'inventrie_notes': inventoryNotes.toString(),
      'date': date,
      'vendor_id': vendorId.toString(),
    };

    var url = '${Api.kInventoryUpdate}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getLocationlsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url = '${Api.kLocationList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getInvoicelsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url = '${Api.kInvoiceList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getcCategoryDetail(int producttypeid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'product_type_id': producttypeid.toString(),
    };

    var url =
        '${Api.kProducttypeDetail}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getInventoryDetail(int inventoryid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'inventry_id': inventoryid.toString(),
    };

    var url = '${Api.kInventoryDetail}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getProductDetail(
      int productid, String locationId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'product_id': productid.toString(),
      'location_id': locationId.toString(),
    };

    var url = '${Api.kProductDetail}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getInventoryProductDetail(
      int inventoryid, int locationid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'inventry_id': inventoryid.toString(),
      'location_id': locationid.toString(),
    };

    var url =
        '${Api.kInventoryProductDetail}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getLocationProductDetail(int locationid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'location_id': locationid.toString(),
    };

    var url =
        '${Api.kLocationProductDetail}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getcLocationDetail(int locationid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'location_id': locationid.toString(),
    };

    var url = '${Api.kLocationDetail}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> deleteProductCategory(
    int productTypeId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'product_type_id': productTypeId.toString(),
    };

    var url =
        '${Api.kDeleteProductCategory}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> deleteLocation(
    int locationId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'location_id': locationId.toString(),
    };

    var url = '${Api.kDeleteLocation}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> addNewProductType(
    String producttypename,
    int producttypeiconid,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'name': producttypename,
      'icon_id': producttypeiconid.toString(),
    };
    var url =
        '${Api.kAddNewProductType}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> updateNewProductType(
    String producttypename,
    int producttypeid,
    int producttypeiconid,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'name': producttypename,
      'product_type_id': producttypeid.toString(),
      'icon_id': producttypeiconid.toString(),
    };
    var url =
        '${Api.kUpdateNewProductType}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> deleteProductType(
    int producttypeid,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'product_type_id': producttypeid.toString(),
    };
    var url =
        '${Api.kDeleteProductType}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> deleteProduct(
    int producttypeid,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'product_id': producttypeid.toString(),
    };
    var url = '${Api.kDeleteProduct}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> addNewProductCategory(
    String productcategorypename,
    int producttypeid,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'categorie_name': productcategorypename,
      'product_type_id': producttypeid.toString(),
    };
    var url =
        '${Api.kAddNewProductCategory}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getProductlsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url = '${Api.kProductList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getProductCategorylsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url =
        '${Api.kProductCategoryList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> updateVendor(
    int vendorID,
    String vendortname,
    String vendoremailid,
    String contactname,
    String phoneneumber,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'vendor_id': vendorID.toString(),
      'vendor_name': vendortname,
      'email': vendoremailid,
      'contact_name': contactname,
      'phone_number': phoneneumber,
    };

    var url = '${Api.kUpdateVendor}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> deleteVendor(
    int vendorID,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'vendor_id': vendorID.toString(),
    };

    var url = '${Api.kDeleteVendor}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  /*static Future<dynamic> getprodcutcategorylsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id':  pref.getString('NSUD_userid') ?? '0',
    };

    var url = '${Api.kProductCategoryList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> getvendorlsit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id':  pref.getString('NSUD_userid') ?? '0',
    };

    var url = '${Api.kVendorList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }*/

/*
  static Future<dynamic> registerProvider(
      String firstName,
      String lastName,
      String emailId,
      String password,
      String phoneNumber,
      String nationality,
      String state,
      String city,
      File selectImage) async {
    SharedPreferences? pref = await SharedPreferences.getInstance();
    var accessToken = await Token.getToken();

    var postUri =
        Uri.parse('${Api.kForgetPasswordUrl}?access_token=$accessToken');

    var request = http.MultipartRequest("POST", postUri);
    request.fields["first_name"] = firstName;
    request.fields["last_name"] = lastName;
    request.fields["email"] = emailId;
    request.fields["password"] = password;
    request.fields["phone_number"] = phoneNumber;
    request.fields["nationality"] = nationality;
    request.fields["state"] = state;
    request.fields["city"] = city;
    request.fields["language_id"] = pref.getString('restaurantLanguage') ?? '1';
    request.fields["device_id"] = await FlutterUdid.udid;

    request.files.add(await http.MultipartFile.fromPath(
        'company_certificate', selectImage.path));

    await request.send().then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        // print(value);
        return json.decode(value);
      });
    }).catchError((e) {
      print('e');
      print(e);
    });
  }*/

  static Future<dynamic> academicLevelList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'language_id': pref.getString('restaurantLanguage') ?? '1',
      'device_id': await FlutterUdid.udid,
    };

    var accessToken = await Token.getToken();
    var url = '${Api.kAcademicLevelsUrl}?access_token=$accessToken';

    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> countriesList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'device_id': await FlutterUdid.udid,
      'language_id': pref.getString('restaurantLanguage') ?? '1',
    };

    var accessToken = await Token.getToken();
    var url = '${Api.kCountriesUrl}?access_token=$accessToken';

    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> stateList(
    String country_id,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'device_id': await FlutterUdid.udid,
      'country_id': country_id,
      'language_id': pref.getString('restaurantLanguage') ?? '1',
    };
    print('body stateList $body');
    var accessToken = await Token.getToken();
    var url = '${Api.kStatesUrl}?access_token=$accessToken';

    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> cityList(
    String state_id,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'device_id': await FlutterUdid.udid,
      'state_id': state_id,
      'language_id': pref.getString('restaurantLanguage') ?? '1',
    };

    var accessToken = await Token.getToken();
    var url = '${Api.kCityUrl}?access_token=$accessToken';

    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> cityListForSearch(
    String state_id,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'device_id': await FlutterUdid.udid,
      'country': state_id,
      'language_id': pref.getString('restaurantLanguage') ?? '1',
    };

    var accessToken = await Token.getToken();
    var url = '${Api.kCityUrl}?access_token=$accessToken';
    print('city body $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> jobTypes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'language_id': pref.getString('restaurantLanguage') ?? '1',
      'device_id': await FlutterUdid.udid,
      'customer_id': pref.getString('user_id') ?? '',
    };

    var accessToken = await Token.getToken();
    var url = '${Api.kJobTypesUrl}?access_token=$accessToken';
    print("kJobTypesUrl $body");
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> jobWorkingPeriods() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'language_id': pref.getString('restaurantLanguage') ?? '1',
      'device_id': await FlutterUdid.udid,
    };

    var accessToken = await Token.getToken();
    var url = '${Api.kJobWorkPeriodsUrl}?access_token=$accessToken';

    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> jobSkills() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'language_id': pref.getString('restaurantLanguage') ?? '1',
      'device_id': await FlutterUdid.udid,
    };

    var accessToken = await Token.getToken();
    var url = '${Api.kGetSkillsUrl}?access_token=$accessToken';

    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> ChangePassword(oldPassword, newPassword) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'device_id': await FlutterUdid.udid,
      'oldpassword': oldPassword,
      'new_password': newPassword,
    };

    var accessToken = await Token.getToken();
    var url = '${Api.kChangePasswordUrl}?access_token=$accessToken';

    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> sendFeedBack(title, description) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'language_id': pref.getString('restaurantLanguage') ?? '1',
      'device_id': await FlutterUdid.udid,
      'customer_id': pref.getString('user_id') ?? '',
      'title': title,
      'description': description,
    };

    var accessToken = await Token.getToken();
    var url = '${Api.kSendFeedBackUrl}?access_token=$accessToken';
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> login({required phone, var fcmtoken}) async {
    assert(phone != null);
    Map<String, String> body = {
      'phone_number': phone,
      'device_id': await FlutterUdid.udid,
      'fcm_token': fcmtoken.toString()
    };
    var accessToken = await Token.getToken();
    var url = '${Api.kLoginUrl}?access_token=$accessToken';
    print('data login $body');

    return jsonDecode(await Networking.post(url, body));
  }

  //--------------------- Place Indivisual order ---------------------------------
  static Future<dynamic> addPlaceindivisualOrder(
    String purchaseId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'purchase_id': purchaseId.toString(),
    };

    var url =
        '${Api.kPlaceIndivisualOrder}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //--------------------- Place all vendor order ---------------------------------
  static Future<dynamic> placeAllVendorOrder(
    String orderId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'vendor_id': orderId.toString(),
    };

    var url =
        '${Api.kPlaceAllVendorOrder}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //--------------------- Place all user order ---------------------------------
  static Future<dynamic> placeAllUserOrder() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url =
        '${Api.kPlaceAllUserOrder}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> approveInvoice(
    int purchaseid,
    int locationid,
    String mdate,
    String invoicenumber,
    String recievedby,
    String notes,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'purchase_id': purchaseid.toString(),
      'location_id': locationid.toString(),
      'date': mdate.toString(),
      'invoice_number': invoicenumber.toString(),
      'received_by': recievedby.toString(),
      'notes': notes.toString(),
    };

    var url = '${Api.kApproveInvoice}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Get user profile data --------------------------------------
  static Future<dynamic> getUserProfileData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
    };

    var url =
        '${Api.kGetUserProfileData}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> addNewInventoryandProduct(
      String inventoryid,
      String locationid,
      //  String vendorid,
      String productid,
      //String description,
      // String notes,
      int quantity,
      String weight) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'inventry_id': inventoryid,
      'location_id': locationid,
      //  'vendor_id': vendorid,
      'product_id': productid,
      // 'description': description,
      // 'inventrie_notes': notes,
      'quantity': quantity.toString(),
      'weight': weight.toString(),
    };

    var url =
        '${Api.kAddNewInventoryandProduct}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> UpdatProfileDetail(
    String restaurantName,
    String phoneNumber,
    int country,
    int state,
    int city,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'restaurant_name': restaurantName,
      'phone_no': phoneNumber,
      'country_id': country.toString(),
      'state_id': state.toString(),
      'city_id': city.toString(),
    };

    var url =
        '${Api.kUpdateProfileUrl}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  static Future<dynamic> ForgetPassword(oldPassword, newPassword) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'device_id': await FlutterUdid.udid,
      'oldpassword': oldPassword,
      'new_password': newPassword,
    };

    var accessToken = await Token.getToken();
    var url = '${Api.kChangePasswordUrl}?access_token=$accessToken';

    return jsonDecode(await Networking.post(url, body));
  }

  //--------------------------- Master product list------------------------------------------
  static Future<dynamic> getMasterProductlsit(
      var pageIndex, var productName, var productCategoryName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'page_id': pageIndex.toString(),
      'ProductSearch': productName.toString(),
      'ProductCategorie': productCategoryName.toString(),
    };

    var url =
        '${Api.kMasterProductList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //------------------------------ Add master product ---------------------------
  static Future<dynamic> addMasterproduct(
    String productId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'product_id': productId,
    };

    var url =
        '${Api.kAddMasterProduct}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

//------------------------------ Delete invnetory ---------------------------
  static Future<dynamic> deleteInventory(
    String inventoryId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'inventry_id': inventoryId,
    };

    var url = '${Api.kDeleteInventory}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

//------------------------------ Get category list by product type ---------------------------
  static Future<dynamic> getCategoryListByProductType(
    String productTypeId,
  ) async {
    print('product type idddd : ' + productTypeId.toString());

    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'product_type_id': productTypeId,
      'language_id': pref.getString('restaurantLanguage') ?? '1',
    };

    var accessToken = await Token.getToken();
    var url =
        '${Api.kProductCategoryListByProductType}?access_token=$accessToken';

    return jsonDecode(await Networking.post(url, body));
  }

//------------------------------ Add new location ---------------------------
  static Future<dynamic> addNewLocation(
    String locationName,
    String countBy,
    String searchBy,
    String weightBy,
    String productId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'language_id': pref.getString('restaurantLanguage') ?? '1',
      'location_name': locationName,
      'count_by': countBy,
      'search_by': searchBy.toString(),
      'weight_by': weightBy,
      'product_id': productId,
    };

    var url = '${Api.kAddNewLocation}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //------------------------------ Get location data with product list ---------------------------
  static Future<dynamic> getLocationDataWithProductList(
      String? locationId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'location_id': locationId.toString()
    };

    var url =
        '${Api.kgetLocationDataWithProductList}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //------------------------------ Move product to another location ---------------------------
  static Future<dynamic> moveProduct(
    String locationname,
    String locationid,
    String productid,
    String movelocationid,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'user_id': pref.getString('NSUD_userid') ?? '0',
      'location_name': locationname,
      'location_id': locationid,
      'product_id': productid.toString(),
      'move_location_id': movelocationid.toString(),
    };

    var url = '${Api.kMoveProductUrl}/?access_token=${await Token.getToken()}';
    debugPrint('Url - $url');
    debugPrint('Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  */
}
