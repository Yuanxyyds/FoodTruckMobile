import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_truck_mobile/models/restaurant_model.dart';

/// The main RestaurantManager instance (Provider) that manages the restaurant
/// functions
class RestaurantManager extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  /// Return all registered restaurants
  Future<List<RestaurantModel>?> getAllRestaurant() async {
    try {
      List<RestaurantModel> myRestaurants = <RestaurantModel>[];
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('restaurants').get();
      for (var document in snapshot.docs) {
        myRestaurants.add(RestaurantModel.fromSnapshot(document));
      }
      return myRestaurants;
    } catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Fail to get restaurants: $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
    return null;
  }

  /// Return all restaurants currently Open
  Future<List<RestaurantModel>?> getOpenRestaurant() async {
    try {
      List<RestaurantModel> myRestaurants = <RestaurantModel>[];
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('restaurants').where('isOpen', isEqualTo: true).get();
      for (var document in snapshot.docs) {
        myRestaurants.add(RestaurantModel.fromSnapshot(document));
      }
      return myRestaurants;
    } catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Fail to get restaurants: $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
    return null;
  }
}
