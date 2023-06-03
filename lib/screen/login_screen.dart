import 'package:flutter/material.dart';
import 'package:food_truck_mobile/helper/http_helper.dart';
import 'package:food_truck_mobile/screen/home_screen.dart';
import 'package:food_truck_mobile/screen/register_screen.dart';

import '../widget/bottom_navigation.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({
    super.key,
  });

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Truck'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const FlutterLogo(
              size: 120.0,
            ),
            const SizedBox(height: 40.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                HttpHelper().postWeather('location');
              },
              child: const Text('TRY API'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterScreen()));
              },
              child: const Text('New User'),
            ),
          ],
        ),
      ),
    );
  }
}
