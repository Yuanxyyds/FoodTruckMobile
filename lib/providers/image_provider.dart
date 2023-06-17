import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_truck_mobile/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widget/dialogs/permission_setting_dialog.dart';

class ImageProviderClass{
  ImageProviderClass();

  File? _imageFile;
  File? get imageFile => _imageFile;

  Future<void> pickImage(ImageSource source) async {
    PermissionStatus permissionStatus;
    if (source == ImageSource.camera) {
      permissionStatus = await Permission.camera.request();
    } else {
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          permissionStatus = await Permission.storage.request();
        }  else {
          permissionStatus = await Permission.photos.request();
        }
      } else {
        permissionStatus = await Permission.photos.request();
      }
    }

    if (permissionStatus == PermissionStatus.granted) {
      try {
        final pickedFile = await ImagePicker().pickImage(source: source);
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error Picking Image $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 16.0,
        );
      }
    } else {
      _showAlert();
    }
  }

  void _showAlert() {
    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (BuildContext context) {
        return const PermissionSettingsDialog(type: 'Camera/Photo',);
      },
    );
  }

  void clearImage() {
    _imageFile = null;
  }
}