// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:pos_controller/Utilities/customtoast.dart';
import 'package:pos_controller/services/api.dart';
import 'package:pos_controller/services/apihelper.dart';
import 'package:pos_controller/services/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String userImage = '';

  var _image4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 1), () {
      getProfileDetail();
    });
  }

  _imgPick(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: imageSource);
    setState(() {
      _image4 = image;
    });
    if (_image4 == null) return;
  }

  void _showPicker4(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgPick(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgPick(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> getImage(var url) async {
    final response = await http.get(Uri.parse(url));

    // Get the image name
    final imageName = path.basename(url);
    // Get the document directory path
    final appDir = await path_provider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later
    final localPath = path.join(appDir.path, imageName);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);

    setState(() {
      _image4 = imageFile;
    });
    Loader.hide();
  }

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
      SharedPreferences pref = await SharedPreferences.getInstance();

      setState(() {
        userNameController.text = jsonData['data']['staff_name'].toString();
        emailController.text = jsonData['data']['staff_email'].toString();
        userImage = jsonData['data']['staff_image'].toString();
        getImage(userImage);
      });

      
    } else {
      print(jsonData['message']);

      CustomToastHelper().showCustomToast(jsonData['message'], false);
      Loader.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
        child: Center(
            child: ListView(
              children: [
                Column(
                  
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
                Container(
                  height: 180,
                  width: 180,
                  child: Stack(
                    children: [
                      Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            //  color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            // image: DecorationImage(
                            //     image: NetworkImage(userImage), fit: BoxFit.cover),
                            border: Border.all(
                              width: 1.5,
                              color: Color(0xffFFBB00),
                            ),
                          ),
                          child: _image4 != null
                              ? ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(100)),
                                  child: Image.file(
                                    File(_image4.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(100)),
                                  child: Image.asset(
                                    'assets/images/placeholder.png',
                                    fit: BoxFit.fill,
                                  ),
                                )),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            _showPicker4(context);
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              //  color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),

                              border: Border.all(
                                width: 1.5,
                                color: Color(0xffFFBB00),
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Color(0xffFFBB00),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'mfont_Light',
                          color: Color(0xffFFFFFF)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 550,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3, 5),
                              blurRadius: 10,
                              color: Color(0xff000000))
                        ],
                      ),
                      child: TextField(
                        controller: userNameController,
                        cursorColor: const Color(0xffFFBB00),
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'mfont_Semibold',
                          color: const Color(0xffFFBB00),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xff000000),
                          filled: true,
                          hintText: 'Enter your name',
                          hintStyle: TextStyle(
                            color: Color(0xffA4A4A4),
                            fontSize: 18,
                            fontFamily: 'mfont_Medium',
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: Color(0xffAAAAAA), width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: Color(0xffAAAAAA), width: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'mfont_Light',
                          color: Color(0xffFFFFFF)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 550,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3, 5),
                              blurRadius: 10,
                              color: Color(0xff000000))
                        ],
                      ),
                      child: TextField(
                        controller: emailController,
                        readOnly: true,
                        cursorColor: const Color(0xffFFBB00),
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'mfont_Semibold',
                          color: const Color(0xffFFBB00),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xff000000),
                          filled: true,
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(
                            color: Color(0xffA4A4A4),
                            fontSize: 18,
                            fontFamily: 'mfont_Medium',
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: Color(0xffAAAAAA), width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: Color(0xffAAAAAA), width: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 52,
                      // width: 38,
                      decoration: BoxDecoration(
                        color: Color(0xffFFBB00),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
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
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        onPressed: () {
                          isValidate();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19)),
                        child: Text(
                          'Update',
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff141414),
                              fontFamily: 'mfont_Semibold'),
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
              ],
            )),
      ),
    );
  }

  //------------------------------------ For Validation ------------------------------------
  void isValidate() {
    if (userNameController.text.trim().isEmpty) {
      CustomToastHelper().showCustomToast('Username must be filled out', false);

      return;
    } else {
      updateProfileData();
    }
  }

  //------------------------------------ For update profile ------------------------------------

  Future<dynamic> updateProfileData() async {
    Loader.show(
      context,
      progressIndicator: const CircularProgressIndicator(
        backgroundColor: Color(0xffF2D35A),
        //color:Colors.teal,
        valueColor: AlwaysStoppedAnimation(Colors.grey),
        strokeWidth: 8,
      ),
    );
    SharedPreferences? pref = await SharedPreferences.getInstance();
    var accessToken = await Token.getToken();

    var postUri =
        Uri.parse('${Api.kGetUpdateProfileData}?access_token=$accessToken');

    var request = http.MultipartRequest("POST", postUri);
    request.fields["staff_id"] = pref.getString('NSUD_staff_id') ?? '0';
    request.fields["language_id"] = '1';
    request.fields["staff_name"] = userNameController.text.toString();
    request.fields["device_id"] = await FlutterUdid.udid;
    request.fields["password"] = pref.getString('NSUD_staff_password') ?? '0';
    // request.fields["staff_email"] = emailController.text.toString();

    request.files
        .add(await http.MultipartFile.fromPath('staff_image', _image4.path));

    await request.send().then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        var jsonResponse = json.decode(value);
        print(value);

        if (jsonResponse['status'].toString().toLowerCase() == 'true') {
    
          Loader.hide();
          CustomToastHelper().showCustomToast(jsonResponse['message'], true);

         // getProfileDetail();

        } else {
          Loader.hide();
          CustomToastHelper().showCustomToast(jsonResponse['message'], false);

          // setState(() {
          //   //iconNameController.clear();
          //   _image4 = null;
          // });

          //   Navigator.of(context).pop();
        }

        return json.decode(value);
      });
    }).catchError((e) {
      print('e');
      print(e);
    });
  }
}
