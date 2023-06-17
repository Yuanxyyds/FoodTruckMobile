import 'package:flutter/cupertino.dart';
import 'package:food_truck_mobile/models/order_item_model.dart';

class ShoppingCartProvider extends ChangeNotifier {
  final List<OrderItemModel> _orderItems = [];
  String restaurantId = '';
  List<OrderItemModel> get orderItems => _orderItems;

  void addOrderItem(OrderItemModel item) {
    _orderItems.add(item);
    notifyListeners();
  }

  void removeOrderItem(OrderItemModel item) {
    _orderItems.remove(item);
    notifyListeners();
  }

  void clearOrderItems() {
    _orderItems.clear();
  }

  double getTotalCost(){
    double totalPrice = 0;
    for (OrderItemModel orderItem in orderItems){
      totalPrice += orderItem.singleItemPrice * orderItem.quantity;
    }
    return totalPrice;
  }
}