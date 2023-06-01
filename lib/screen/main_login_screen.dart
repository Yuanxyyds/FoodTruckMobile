import 'package:flutter/material.dart';
import 'package:food_truck_mobile/icons/google_icon.dart';
import 'package:food_truck_mobile/screen/register_screen.dart';
import 'package:food_truck_mobile/widget/clickable_label.dart';
import 'package:food_truck_mobile/widget/input_field.dart';
import 'package:food_truck_mobile/widget/section_header_single_line.dart';
import 'package:food_truck_mobile/widget/text.dart';
import '../helper/constants.dart';
import '../widget/bottom_navigation.dart';
import '../widget/button.dart';

class MainLoginScreen extends StatefulWidget {
  const MainLoginScreen({Key? key}) : super(key: key);

  @override
  State<MainLoginScreen> createState() => _MainLoginScreenState();
}

class _MainLoginScreenState extends State<MainLoginScreen> {
  bool _emailMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TextHeadlineSmall(
            text: 'My Account',
          ),
        ),
        bottomNavigationBar: const BottomNavigation(
          currentIndex: 2,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                const InputField(
                    labelText: 'Email', prefixIcon: Icon(Icons.email)),
              if (!_emailMode)
                const InputField(
                    labelText: 'Password', prefixIcon: Icon(Icons.password)),
              const SizedBox(height: 8),
              if (_emailMode)
                Button(
                  text: 'Next',
                  textColor: Constants.whiteColor,
                  takeLeastSpace: true,
                  onPressed: () {
                    setState(() {
                      _emailMode = !_emailMode;
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
                      _emailMode = !_emailMode;
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
}
