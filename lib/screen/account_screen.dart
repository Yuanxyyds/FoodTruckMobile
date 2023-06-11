import 'package:flutter/material.dart';
import 'package:food_truck_mobile/firebase/auth_manager.dart';
import 'package:food_truck_mobile/icons/google_icon.dart';
import 'package:food_truck_mobile/models/user_model.dart';
import 'package:food_truck_mobile/screen/edit_profile_screen.dart';
import 'package:food_truck_mobile/screen/register_screen.dart';
import 'package:food_truck_mobile/widget/components/clickable_label.dart';
import 'package:food_truck_mobile/widget/components/input_field.dart';
import 'package:food_truck_mobile/widget/components/profile_row.dart';
import 'package:food_truck_mobile/widget/dividers/section_divider.dart';
import 'package:food_truck_mobile/widget/dividers/section_header_lr.dart';
import 'package:food_truck_mobile/widget/text.dart';
import 'package:provider/provider.dart';
import '../helper/constants.dart';
import '../widget/components/bottom_navigation.dart';
import '../widget/components/button.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// The [AccountScreen] of this app, it has two screens: User Information
/// Screen and the User Login Screen.

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  bool _emailMode = true;

  @override
  void dispose() {
    _inputEmail.dispose();
    _inputPassword.dispose();
    super.dispose();
  }

  /// Build the page based on if currentUser has an instance
  @override
  Widget build(BuildContext context) {
    AuthManager auth = context.watch<AuthManager>();
    return auth.currentUser == null
        ? getLoginContent(auth)
        : getAccountProfile(auth);
  }

  /// Login State, Current Only Email/Password is supported
  Widget getLoginContent(AuthManager auth) {
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
              const SectionHeaderLR(
                text: 'or log in using email',
              ),
              const SizedBox(height: 8),
              InputField(
                labelText: _emailMode ? 'Email' : 'Password',
                obscureText: _emailMode ? false : true,
                prefixIcon: _emailMode
                    ? const Icon(Icons.email)
                    : const Icon(Icons.password),
                controller: _emailMode ? _inputEmail : _inputPassword,
                suffixIcon: _emailMode
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.arrow_back_outlined),
                        onPressed: () {
                          setState(() {
                            _emailMode = !_emailMode;
                            _inputEmail.clear();
                            _inputPassword.clear();
                          });
                        },
                      ),
              ),
              const SizedBox(height: 8),
              if (_emailMode)
                Button(
                  text: 'Next',
                  textColor: Constants.whiteColor,
                  takeLeastSpace: true,
                  onPressed: () {
                    setState(() {
                      if (!_checkFieldIsEmpty(_inputEmail)) {
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
                      if (!_checkFieldIsEmpty(_inputPassword)) {
                        auth.signInWithEmailAndPassword(
                            email: _inputEmail.text,
                            password: _inputPassword.text);
                        _emailMode = !_emailMode;
                        _inputEmail.clear();
                        _inputPassword.clear();
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
                Center(
                  child: ClickableLabel(
                    text: 'Forgot your password?',
                    onTap: () {
                      auth.sendPasswordResetEmail(_inputEmail.text);
                    },
                  ),
                ),
            ],
          ),
        ));
  }

  /// Check if the input email or password is empty
  bool _checkFieldIsEmpty(TextEditingController controller) {
    if (controller.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Input Cannot be Empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 16.0);
      return true;
    }
    return false;
  }

  /// User Information State, Currently support retrieving data from Firebase
  /// The Implementation of this function has precondition that the current
  /// state has an currentUser instance.
  /// TODO: UI is not implemented
  Widget getAccountProfile(AuthManager auth) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 3,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await auth.signOut();
        },
        child: const Icon(Icons.remove),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: FutureBuilder<UserModel?>(
          future: auth.getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel userData = snapshot.data as UserModel;
                return ListView(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                          userData.avatar,
                        ),
                      ),
                    ),
                    Center(
                        child: TextTitleLarge(
                      text: userData.name,
                      isBold: true,
                    )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Button(
                        text: 'Edit Profile',
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        takeLeastSpace: true,
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditProfileScreen(
                                      userModel: userData,
                                    )));
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ProfileRow(
                      icon: Icons.phone,
                      info: userData.phoneNumber,
                    ),
                    ProfileRow(icon: Icons.mail_outline, info: userData.email),
                    ProfileRow(icon: Icons.pin_drop, info: userData.address),
                    const SectionDivider(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 25.0),
                    ),
                    ProfileRow(
                        icon: Icons.account_balance_wallet,
                        info: userData.accountBalance.toStringAsFixed(2)),
                    GestureDetector(
                      onTap: () async {
                        await auth.signOut();
                      },
                      child: const ProfileRow(
                        icon: Icons.logout,
                        info: "Log out",
                        secondary: true,
                      ),
                    )
                  ],
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
