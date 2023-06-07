import 'package:cloud_firestore/cloud_firestore.dart';

/// The [RestaurantModel]
class RestaurantModel {
  String? id;
  String name;
  String description;
  bool isOpen;
  String address;
  String restaurantUrl;
  String area;
  List<String> section;

  RestaurantModel({
    required this.id,
    required this.name,
    this.description = 'Description not set',
    this.isOpen = true,
    this.address = 'UofT',
    this.restaurantUrl = 'images/DefaultRestaurantImage.jpeg',
    this.area = 'UofT',
    this.section = const <String>[],
  });

  void addSection(String sectionId){
    section.add(sectionId);
  }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      "id": id,
      "name": name,
      "description": description,
      "isOpen": isOpen,
      "address": address,
      'restaurantUrl': restaurantUrl,
      "area": area,
      'section': section,
    };
    return jsonMap;
  }

  factory RestaurantModel.fromSnapshot(var document) {
    final data = document.data();
    return RestaurantModel(
      id: document.id,
      name: data!["name"],
      description: data!["description"],
      isOpen: data!["isOpen"],
      address: data!["address"],
      restaurantUrl: data!['restaurantUrl'],
      area: data!["area"],
      section: data!['section'],
    );
  }
}
