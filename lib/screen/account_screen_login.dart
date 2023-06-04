import 'package:flutter/material.dart';
import 'package:food_truck_mobile/helper/auth.dart';
import 'package:food_truck_mobile/icons/google_icon.dart';
import 'package:food_truck_mobile/screen/account_screen_profile.dart';
import 'package:food_truck_mobile/screen/register_screen.dart';
import 'package:food_truck_mobile/widget/clickable_label.dart';
import 'package:food_truck_mobile/widget/input_field.dart';
import 'package:food_truck_mobile/widget/section_header_single_line.dart';
import 'package:food_truck_mobile/widget/text.dart';
import 'package:provider/provider.dart';
import '../helper/constants.dart';
import '../widget/bottom_navigation.dart';
import '../widget/button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountScreenLogin extends StatefulWidget {
  const AccountScreenLogin({Key? key}) : super(key: key);

  @override
  State<AccountScreenLogin> createState() => _AccountScreenLoginState();
}

class _AccountScreenLoginState extends State<AccountScreenLogin> {
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  bool _emailMode = true;

  @override
  void dispose() {
    _inputEmail.dispose();
    _inputPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = context.watch<Auth>();
    return auth.currentUser == null
        ? getLoginContent(auth)
        : getAccountProfile(auth);
  }

  Widget getLoginContent(Auth auth) {
    return Scaffold(
        appBar: AppBar(
          title: const TextHeadlineSmall(
            text: 'My Account',
          ),
        ),
        bottomNavigationBar: const BottomNavigation(
          currentIndex: 3,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: ListView(
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/UnknownUser.jpg'),
                ),
              ),
              const Center(
                child: TextTitleLarge(
                  text: 'Create an account or log in',
                  isBold: true,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              const Center(
                child: TextTitleMedium(
                  text: 'Log in below or create.',
                  padding: EdgeInsets.zero,
                ),
              ),
              const Center(
                child: TextTitleMedium(
                  text: 'a new Food Truck account.',
                  padding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 8),
              Button(
                  text: 'Continue with Facebook',
                  backgroundColor: const Color(0xFF1877F2),
                  textColor: Constants.whiteColor,
                  icon: Icons.facebook,
                  takeLeastSpace: true,
                  onPressed: () {}),
              const SizedBox(height: 8),
              Button(
                text: 'Continue with Google',
                textColor: Constants.whiteColor,
                icon: GoogleIcon.google,
                takeLeastSpace: true,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              Button(
                text: 'Continue with Apple',
                textColor: Constants.whiteColor,
                backgroundColor: Constants.blackColor,
                icon: Icons.apple,
                takeLeastSpace: true,
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              const SectionHeaderSingleLine(
                text: 'or log in using email',
              ),
              const SizedBox(height: 8),
              if (_emailMode)
                InputField(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  controller: _inputEmail,
                ),
              if (!_emailMode)
                InputField(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.password),
                  controller: _inputPassword,
                  obscureText: true,
                ),
              const SizedBox(height: 8),
              if (_emailMode)
                Button(
                  text: 'Next',
                  textColor: Constants.whiteColor,
                  takeLeastSpace: true,
                  onPressed: () {
                    setState(() {
                      if (_inputEmail.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Email Cannot be Empty!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                      } else {
                        _emailMode = !_emailMode;
                      }
                    });
                  },
                ),
              if (!_emailMode)
                Button(
                  text: 'Finish',
                  textColor: Constants.whiteColor,
                  takeLeastSpace: true,
                  onPressed: () {
                    setState(() {
                      if (_inputPassword.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Password Cannot be Empty!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                      } else {
                        auth.signInWithEmailAndPassword(
                            email: _inputEmail.text,
                            password: _inputPassword.text);

                        _inputEmail.clear();
                        _inputPassword.clear();
                        _emailMode = !_emailMode;
                      }
                    });
                  },
                ),
              const SizedBox(height: 8),
              if (_emailMode)
                Center(
                    child: ClickableLabel(
                  text: 'Register a new account with email',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
                  },
                )),
              if (!_emailMode)
                const Center(
                    child: ClickableLabel(
                  text: 'Forgot your password?',
                )),
            ],
          ),
        ));
  }

  Widget getAccountProfile(Auth auth) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await auth.signOut();
        },
        child: const Icon(Icons.remove),
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                'images/UnknownUser.jpg', // Replace with the user's profile picture URL
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'John Doe', // Replace with the user's name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'john.doe@example.com', // Replace with the user's email
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('123-456-7890'),
              // Replace with the user's phone number
              onTap: () {
                // Handle phone number tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('New York, USA'),
              // Replace with the user's location
              onTap: () {
                // Handle location tap
              },
            ),
            // Add more user information as needed
          ],
        ),
      ),
    );
  }
}
