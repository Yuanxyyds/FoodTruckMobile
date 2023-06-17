import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_truck_mobile/main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widget/dialogs/permission_setting_dialog.dart';

class ImageProviderClass {
  ImageProviderClass();

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  File? _imageFile;
  File? _croppedFile;

  File? get croppedFile => _croppedFile;

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
        } else {
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

  Future<void> cropImage() async {
    if (_imageFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _imageFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        _croppedFile = File(croppedFile.path);
      }
    }
  }

  void _showAlert() {
    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (BuildContext context) {
        return const PermissionSettingsDialog(
          type: 'Camera/Photo',
        );
      },
    );
  }

  Future<String?> uploadImageToFirebaseStorage() async {
    try {
      final Reference ref = _firebaseStorage.ref().child(
          'user_avatars/image_${DateTime.now().millisecondsSinceEpoch}.jpg');

      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );

      final uploadTask = ref.putFile(croppedFile!, metadata);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      print(e);
      Fluttertoast.showToast(
          msg: "Fail to upload Image: $substring",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 16.0);
      return null;
    }
  }

  void clearImage() {
    _imageFile = null;
    _croppedFile = null;
  }
}
