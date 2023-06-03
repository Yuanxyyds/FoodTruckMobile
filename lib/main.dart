import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:food_truck_mobile/helper/theme.dart';
import 'package:food_truck_mobile/screen/home_screen.dart';
import 'package:food_truck_mobile/screen/login_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool devicePreview = false;
  runApp(devicePreview
      ? DevicePreview(
          enabled: !kReleaseMode, builder: (context) => const MyApp())
      : const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: FoodTruckThemeData.themeData,
      home: const HomeScreen(),
    );
  }
}
