/// The [SellerModel]
class SellerModel {
  String? id;
  String name;
  String phoneNumber;
  String email;
  double accountBalance;

  SellerModel({
    required this.id,
    required this.name,
    this.phoneNumber = 'Click to set your phone number',
    required this.email,
    this.accountBalance = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "accountBalance": accountBalance,
    };
  }

  factory SellerModel.fromSnapshot(var document) {
    final data = document.data();
    return SellerModel(
        id: document.id,
        name: data!["name"],
        phoneNumber: data!["phoneNumber"],
        email: data!["email"],
        accountBalance: data!["accountBalance"]);
  }
}
