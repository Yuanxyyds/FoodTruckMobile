import 'package:food_truck_mobile/helper/constants.dart';

/// The [UserModel]
class UserModel {
  String? id;
  String name;
  String phoneNumber;
  String email;
  String avatar;
  String address;
  double accountBalance;

  UserModel({
    required this.id,
    required this.name,
    this.phoneNumber = 'Click to set your phone number',
    required this.email,
    this.avatar = Constants.defaultUserAvatar,
    this.address = 'Click to set your address',
    this.accountBalance = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "avatar": avatar,
      "address": address,
      "accountBalance": accountBalance
    };
  }

  factory UserModel.fromSnapshot(
      var document) {
    final data = document.data();
    return UserModel(
        id: document.id,
        name: data!["name"],
        phoneNumber: data!["phoneNumber"],
        email: data!["email"],
        avatar: data!["avatar"],
        address: data!["address"],
        accountBalance: data!["accountBalance"]);
  }
}
