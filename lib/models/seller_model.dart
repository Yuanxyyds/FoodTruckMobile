import 'package:cloud_firestore/cloud_firestore.dart';

/// The [SellerModel]
class SellerModel {
  String? id;
  String name;
  String phoneNumber;
  String email;
  double accountBalance;
  List<String> restaurants;

  SellerModel({
    required this.id,
    required this.name,
    this.phoneNumber = 'Click to set your phone number',
    required this.email,
    this.accountBalance = 0,
    this.restaurants = const <String>[],
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "accountBalance": accountBalance,
      "restaurants": restaurants,
    };
  }

  factory SellerModel.fromSnapshot(
      var document) {
    final data = document.data();
    return SellerModel(
        id: document.id,
        name: data!["name"],
        phoneNumber: data!["phoneNumber"],
        email: data!["email"],
        restaurants: data!["restaurants"],
        accountBalance: data!["accountBalance"]);
  }
}
