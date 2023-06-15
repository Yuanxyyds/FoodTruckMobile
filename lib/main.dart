import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:food_truck_mobile/firebase/auth_manager.dart';
import 'package:food_truck_mobile/helper/theme.dart';
import 'package:food_truck_mobile/providers/shoping_cart_provider.dart';
import 'package:food_truck_mobile/providers/user_location_provider.dart';
import 'package:food_truck_mobile/screen/home_screen.dart';
import 'package:provider/provider.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // runApp(DevicePreview(
  // enabled: !kReleaseMode, builder: (context) => const MyApp()));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthManager()),
    ChangeNotifierProvider(create: (_) => ShoppingCartProvider()),
    ChangeNotifierProvider(create: (_) => UserLocationProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: FoodTruckThemeData.themeData,
      home: const HomeScreen(),
    );
  }
}
