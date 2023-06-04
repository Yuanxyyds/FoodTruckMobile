import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/text.dart';

import '../helper/constants.dart';
import '../widget/popular_tag.dart';
import '../widget/section_divider.dart';

class FoodDetailScreen extends StatefulWidget {
  final String? imageUrl;
  final String foodName;
  final String description;
  final double price;
  final bool isPopular;

  const FoodDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.foodName,
    required this.description,
    required this.price,
    required this.isPopular,
  }) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int count = 1;

  // Ternary operator to get Url, simplifying build method
  String getImageUrlOrDefault() {
    return widget.imageUrl ?? 'images/DefaultRestaurantImage.jpeg';
  }

  double calculateSubtotal() {
    return count * widget.price;
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = calculateSubtotal();
    String url = getImageUrlOrDefault();
    Color removeColor = count == 1 ? Colors.grey : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: ListView(
          children: [
            Container(
              height: 185,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(url),
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
                      text: widget.foodName,
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
                      widget.description,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: TextTitleMedium(
                        text: '\$ ${widget.price.toStringAsFixed(2)}',
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
            const Placeholder(
              fallbackHeight: 200.0,
            ),
            const SectionDivider(),
            Row(
              children: [
                const Expanded(
                  child: TextTitleMedium(
                    text: "Subtotal",
                    isBold: true,
                  ),
                ),
                TextTitleMedium(
                  text: '\$ ${subtotal.toStringAsFixed(2)}',
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                count = count > 1 ? count - 1 : 1;
                              });
                            },
                            child: Icon(
                              Icons.remove,
                              color: removeColor,
                            ),
                          ),
                          Text(
                            count.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                count += 1;
                              });
                            },
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Constants.primaryColor),
                      child: const Center(
                        child: TextTitleMedium(
                          text: "Add to Order",
                          color: Colors.white,
                        ),
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
