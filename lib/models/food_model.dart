import 'package:cloud_firestore/cloud_firestore.dart';

/// The [FoodModel]
class FoodModel {
  String? id;
  String name;
  String description;
  double price;
  String foodUrl;
  Map<String, double> topping;

  FoodModel({
    required this.id,
    required this.name,
    this.description = 'Description not set',
    required this.price,
    this.foodUrl = 'images/DefaultRestaurantImage.jpeg',
    this.topping = const <String, double>{},
  });

  void addTopping(String name, double price){
    topping?['name'] = price;
  }

  void removeTopping(String name){
    topping?.remove('name');
  }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "foodUrl": foodUrl,
      'topping': topping,
    };
    return jsonMap;
  }

  factory FoodModel.fromSnapshot(var document) {
    final data = document.data();
    return FoodModel(
        id: document.id,
        name: data!["name"],
        description: data!["description"],
        price: data!["price"],
        foodUrl: data!["foodUrl"],
        topping: data!['toppings'],
    );
  }
}
