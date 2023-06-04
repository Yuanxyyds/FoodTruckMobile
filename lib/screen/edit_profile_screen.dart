import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_truck_mobile/widget/button.dart';
import 'package:provider/provider.dart';

import '../firebase/auth.dart';
import '../models/user_model.dart';
import '../widget/input_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, required this.userModel})
      : super(key: key);

  final UserModel userModel;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameEditingController = TextEditingController();

  final TextEditingController _emailEditingController = TextEditingController();

  final TextEditingController _phoneNumberEditingController =
      TextEditingController();

  final TextEditingController _addressEditingController =
      TextEditingController();

  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();

  @override
  void dispose() {
    _nameEditingController.dispose();
    _emailEditingController.dispose();
    _phoneNumberEditingController.dispose();
    _addressEditingController.dispose();
    _emailFocusNode.dispose();
    _addressFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = context.watch<Auth>();
    _nameEditingController.text = widget.userModel.name;
    _emailEditingController.text = widget.userModel.email;
    _phoneNumberEditingController.text = widget.userModel.phoneNumber;
    _addressEditingController.text = widget.userModel.address;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: GestureDetector(
        onTap: () {
          _emailFocusNode.unfocus();
          _nameFocusNode.unfocus();
          _addressFocusNode.unfocus();
          _phoneNumberFocusNode.unfocus();
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: ListView(children: [
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/UnknownUser.jpg'),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              InputField(
                focusNode: _nameFocusNode,
                controller: _nameEditingController,
                labelText: 'Full Name',
                onTap: () {
                  _nameEditingController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: _nameEditingController.value.text.length,
                  );
                },
                prefixIcon: const Icon(Icons.person),
                borderRadius: 32,
              ),
              const SizedBox(
                height: 16,
              ),
              InputField(
                focusNode: _addressFocusNode,
                controller: _addressEditingController,
                onTap: () {
                  _addressEditingController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: _addressEditingController.value.text.length,
                  );
                },
                labelText: 'Address',
                prefixIcon: const Icon(Icons.location_on),
                borderRadius: 32,
              ),
              const SizedBox(
                height: 16,
              ),
              InputField(
                focusNode: _emailFocusNode,
                controller: _emailEditingController,
                onTap: () {
                  _emailEditingController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: _emailEditingController.value.text.length,
                  );
                },
                labelText: 'E-Mail',
                prefixIcon: const Icon(Icons.email),
                borderRadius: 32,
              ),
              const SizedBox(
                height: 16,
              ),
              InputField(
                focusNode: _phoneNumberFocusNode,
                controller: _phoneNumberEditingController,
                onTap: () {
                  _phoneNumberEditingController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset:
                        _phoneNumberEditingController.value.text.length,
                  );
                },
                labelText: 'Phone Number',
                prefixIcon: const Icon(Icons.phone),
                borderRadius: 32,
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 32,
              ),
              Button(
                text: 'Edit Profile',
                onPressed: () async {
                  if (!_checkFieldIsEmpty()) {
                    widget.userModel.name = _nameEditingController.text;
                    widget.userModel.address = _addressEditingController.text;
                    widget.userModel.email = _emailEditingController.text;
                    widget.userModel.phoneNumber =
                        _phoneNumberEditingController.text;
                    if (await auth.updateEmail(widget.userModel.email)){
                      if (await auth.updateUser(widget.userModel)){
                        Navigator.of(context).pop();
                      }
                    }
                  }
                },
                takeLeastSpace: true,
                backgroundColor: Colors.yellow,
              ),
            ])),
      ),
    );
  }

  /// Check if all input field is empty
  bool _checkFieldIsEmpty() {
    if (_nameEditingController.text.isEmpty ||
        _addressEditingController.text.isEmpty ||
        _emailEditingController.text.isEmpty ||
        _phoneNumberEditingController.text.isEmpty) {
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
}
