import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_truck_mobile/helper/constants.dart';
import 'package:food_truck_mobile/helper/login_method.dart';
import 'package:food_truck_mobile/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// The main Auth instance (Provider) that stores the information of the
/// current user
class AuthManager extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LoginMethod? _currentLoginMethod;

  LoginMethod? get currentLoginMethod => _currentLoginMethod;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
        Fluttertoast.showToast(
          msg: "Login Succeeded!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 16.0,
        );
        _currentLoginMethod = LoginMethod.google;
        bool exist = await doesUserExist(currentUser!.uid);
        if (!exist) {
          _initializeNewUser(currentUser!.email!);
        }
        notifyListeners();
      } else {
        Fluttertoast.showToast(
          msg: "Google sign in cancelled by user",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Google sign in failed: $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
  }

  /// Sign in to the account by Email/Password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Fluttertoast.showToast(
          msg: "Login Succeed!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 16.0);
      _currentLoginMethod = LoginMethod.emailAndPassword;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
          msg: "Sign in Failed: $substring",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 16.0);
    }
  }

  /// Sign out from current account
  Future<void> signOut() async {
    try {
      if (_currentLoginMethod == LoginMethod.google) {
        await _googleSignIn.signOut();
      }
      await _firebaseAuth.signOut();
      Fluttertoast.showToast(
        msg: "Logout Succeed!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    } catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Logout Failed; $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
    notifyListeners();
  }

  /// Register and Initialize new account based on Email/Password
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Fluttertoast.showToast(
        msg: "Registration Succeed!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
      _currentLoginMethod = LoginMethod.emailAndPassword;
      _initializeNewUser(email);
    } catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Registration Failed: $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
    notifyListeners();
  }

  /// Update Email
  Future<bool> updateEmail(String newEmail) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(newEmail);
      notifyListeners();
      return true;
    } catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Failed to update email: $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
      return false;
    }
  }

  /// Send a password Reset Email to User's email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "A password reset email has sent!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    } catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Failed to send reset email: $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
  }

  /// Initialize the new user profile
  Future<void> _initializeNewUser(String email) async {
    try {
      CollectionReference users = _firestore.collection('users');
      DocumentReference userRef = users.doc(currentUser?.uid);
      if (currentLoginMethod == LoginMethod.google) {
        await userRef.set(UserModel(
          id: currentUser?.uid,
          name: _googleSignIn.currentUser!.displayName ?? 'User: $email',
          avatar: _googleSignIn.currentUser!.photoUrl ??
              Constants.defaultUserAvatar,
          email: email,
        ).toJson());
      } else {
        await userRef.set(
            UserModel(id: currentUser?.uid, name: 'Users $email', email: email)
                .toJson());
      }
    } catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Initialize Failed: $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
  }

  /// Initialize the new user profile
  Future<bool> updateUser(UserModel user) async {
    try {
      CollectionReference users = _firestore.collection('users');
      DocumentReference userRef = users.doc(user.id);
      await userRef.update(user.toJson());
      Fluttertoast.showToast(
        msg: "Update Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
      notifyListeners();
      return true;
    } catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Update Failed: $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
      return false;
    }
  }

  Future<bool> doesUserExist(String userId) async {
    try {
      DocumentReference userRef = _firestore.collection('users').doc(userId);
      DocumentSnapshot userSnapshot = await userRef.get();
      return userSnapshot.exists;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to check user existence: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
      return false;
    }
  }

  /// Return the Current User's information
  Future<UserModel?> getUserInfo() async {
    try {
      CollectionReference users = _firestore.collection('users');
      DocumentReference userRef = users.doc(currentUser?.uid);
      var documentSnapshot = await userRef.get();
      return UserModel.fromSnapshot(documentSnapshot);
    } catch (e) {
      if (e.toString().contains("Null check operator used on a null value")) {
        _initializeNewUser(currentUser!.email!);
        getUserInfo();
      } else {
        String input = e.toString();
        String substring = input.substring(input.indexOf("]") + 1);
        Fluttertoast.showToast(
          msg: "Fail to get user info: $substring",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 16.0,
        );
      }
      return null;
    }
  }
}
