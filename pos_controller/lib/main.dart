
import 'package:flutter/material.dart';
import 'package:pos_controller/Screens/login_screen.dart';


void main() => runApp(const MyApp());

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: mainNavigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.yellow, 
      ),
      home: const LoginScreen(),
    );
  }
}


