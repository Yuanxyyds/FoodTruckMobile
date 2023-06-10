import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_truck_mobile/models/food_model.dart';

/// The main FoodManager instance (Provider) that manages the food functions
class FoodManager extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Find all foods created under this restaurant
  Future<List<FoodModel>?> getFoodByRestaurant(String restaurantId) async {
    try {
      List<FoodModel> myFoods = <FoodModel>[];
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('foods') // Replace with your collection name
          .where(FieldPath.documentId, isGreaterThanOrEqualTo: restaurantId)
          .where(FieldPath.documentId, isLessThanOrEqualTo: '${restaurantId}z')
          .get();
      for (var document in snapshot.docs) {
        myFoods.add(FoodModel.fromSnapshot(document));
      }
      return myFoods;
    } catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Fail to get food: $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
    return null;
  }

  /// Return all foods under certain section (by sectionId)
  Future<List<FoodModel>?> getFoodBySection(String sectionId) async {
    try {
      List<FoodModel> myFoods = <FoodModel>[];
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('foods') // Replace with your collection name
          .where('sectionId', isEqualTo: sectionId)
          .get();
      for (var document in snapshot.docs) {
        myFoods.add(FoodModel.fromSnapshot(document));
      }
      return myFoods;
    } catch (e) {

      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Fail to get food: $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
    return null;
  }

}
