/// [OrderItemModel]
class OrderItemModel {
  final String foodName;
  final String foodId;
  final List<String> toppings;
  final double singleItemPrice;
  int quantity;

  OrderItemModel(
      {required this.foodName,
      required this.foodId,
      this.toppings = const <String>[],
      required this.singleItemPrice,
      required this.quantity});


}
