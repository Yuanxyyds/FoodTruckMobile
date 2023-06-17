import 'package:flutter/material.dart';
import 'package:food_truck_mobile/models/food_model.dart';
import 'package:food_truck_mobile/models/order_item_model.dart';
import 'package:food_truck_mobile/providers/shopping_cart_provider.dart';
import 'package:food_truck_mobile/widget/components/add_topping.dart';
import 'package:food_truck_mobile/widget/components/button.dart';
import 'package:food_truck_mobile/widget/text.dart';
import 'package:food_truck_mobile/helper/constants.dart';
import 'package:food_truck_mobile/widget/decorations/popular_tag.dart';
import 'package:food_truck_mobile/widget/dividers/section_divider.dart';
import 'package:provider/provider.dart';

/// The [FoodDetailScreen] that shows the detailed information of the food, and
/// topping options
class FoodDetailScreen extends StatefulWidget {
  final FoodModel foodModel;
  final bool isPopular;

  const FoodDetailScreen({
    Key? key,
    required this.isPopular,
    required this.foodModel,
  }) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int count = 1;
  double singleItemTotal = 0;
  List<String> selectedToppings = <String>[];

  @override
  void initState() {
    singleItemTotal = widget.foodModel.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color removeColor = count == 1 ? Colors.grey : Colors.black;
    ShoppingCartProvider shoppingCartProvider =
        context.read<ShoppingCartProvider>();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.foodModel.name),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: ListView(
            children: [
              Container(
                height: 185,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(widget.foodModel.foodUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextTitleLarge(
                        text: widget.foodModel.name,
                        isBold: true,
                      ),
                    ),
                    if (widget.isPopular) const PopularTag()
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        widget.foodModel.description,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: TextTitleMedium(
                          text:
                              '\$ ${widget.foodModel.price.toStringAsFixed(2)}',
                          isBold: true,
                          padding: EdgeInsets.zero,
                        )),
                  ),
                ],
              ),
              const SectionDivider(),
              const TextTitleMedium(
                text: "Toppings",
                isBold: true,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0),
                child: Text("Choose up to 4 additional items."),
              ),
              ..._getContent(),
              const SizedBox(
                height: 130.0,
              ),
            ],
          ),
        ),

        // Subtotal information fixed at bottom
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: SizedBox(
            height: 100.0,
            child: ListView(children: [
              Row(
                children: [
                  const Expanded(
                    child: TextTitleMedium(
                      text: "Subtotal",
                      isBold: true,
                    ),
                  ),
                  TextTitleMedium(
                    text: '\$ ${(singleItemTotal * count).toStringAsFixed(2)}',
                    isBold: true,
                  )
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  count = count > 1 ? count - 1 : 1;
                                });
                              },
                              icon: Icon(
                                Icons.remove,
                                color: removeColor,
                              ),
                            ),
                            Text(
                              count.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  count += 1;
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                      flex: 6,
                      child: Button(
                        text: "Add to Order",
                        textColor: Colors.white,
                        backgroundColor: Constants.primaryColor,
                        takeLeastSpace: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                          OrderItemModel orderItemModel = OrderItemModel(
                              foodUrl: widget.foodModel.foodUrl,
                              foodName: widget.foodModel.name,
                              foodId: widget.foodModel.id!,
                              singleItemPrice: singleItemTotal,
                              toppings: selectedToppings,
                              quantity: count);
                          shoppingCartProvider.addOrderItem(orderItemModel);
                        },
                      ))
                ],
              ),
            ]),
          ),
        ));
  }

  /// Method to get all topping of the current foodModel
  List<Widget> _getContent() {
    List<Widget> content = [];
    for (var element in widget.foodModel.topping.keys) {
      content.add(AddTopping(
        name: element,
        price: widget.foodModel.topping[element]!,
        onSelectionChanged: (bool value) {
          if (value) {
            setState(() {
              singleItemTotal =
                  singleItemTotal + widget.foodModel.topping[element]!;
              selectedToppings.add(element);
            });
          } else {
            setState(() {
              singleItemTotal =
                  singleItemTotal - widget.foodModel.topping[element]!;
              selectedToppings.remove(element);
            });
          }
        },
      ));
    }
    return content;
  }
}
