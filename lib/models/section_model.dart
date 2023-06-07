import 'package:cloud_firestore/cloud_firestore.dart';

/// The [SectionModel]
class SectionModel {
  String? id;
  String label;
  List<String> foodItems;

  SectionModel({
    required this.id,
    this.label = "Uncategorized",
    this.foodItems = const <String>[],
  });

  void addFoodItem(String foodId){
    foodItems.add(foodId);
  }

  void removeFoodItem(String foodId){
    foodItems.remove(foodId);
  }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      "id": id,
      "label": label,
      "foodItems": foodItems,
    };
    return jsonMap;
  }

  factory SectionModel.fromSnapshot(var document) {
    final data = document.data();
    return SectionModel(
      id: document.id,
      label: data!["label"],
      foodItems: data!["foodItems"],
    );
  }
}
