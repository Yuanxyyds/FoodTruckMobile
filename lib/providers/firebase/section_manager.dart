import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_truck_mobile/models/section_model.dart';

/// The main SectionManager instance (Provider) that manages the functions of
/// sections
class SectionManager extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Return all sections in a restaurant searching by restaurantId
  Future<List<SectionModel>?> getOwnedSection(String restaurantId) async {
    try {
      List<SectionModel> mySections = <SectionModel>[];
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('sections') // Replace with your collection name
          .where(FieldPath.documentId, isGreaterThanOrEqualTo: restaurantId)
          .where(FieldPath.documentId, isLessThanOrEqualTo: '${restaurantId}z')
          .get();
      for (var document in snapshot.docs) {
        mySections.add(SectionModel.fromSnapshot(document));
      }
      return mySections;
    } catch (e) {
      String input = e.toString();
      String substring = input.substring(input.indexOf("]") + 1);
      Fluttertoast.showToast(
        msg: "Fail to get sections: $substring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
    return null;
  }
}
