import 'package:flutter/material.dart';
import 'package:food_truck_mobile/helper/http_helper.dart';
import 'package:food_truck_mobile/screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const LogInScreen(),
    );
  }
}


