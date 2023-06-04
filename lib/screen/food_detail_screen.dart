import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/counter.dart';
import 'package:food_truck_mobile/widget/text.dart';

import '../helper/constants.dart';
import '../widget/popular_tag.dart';
import '../widget/section_divider.dart';

class FoodDetailScreen extends StatelessWidget {
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

  // Ternary operator to get Url, simplifying build method
  String getImageUrlOrDefault() {
    return imageUrl ?? 'images/DefaultRestaurantImage.jpeg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodName),
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
                  image: AssetImage(getImageUrlOrDefault()),
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
                      text: foodName,
                      isBold: true,
                    ),
                  ),
                  if (isPopular) const PopularTag()
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
                      description,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: TextTitleMedium(
                        text: '\$ $price',
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
                  text: '\$ $price',
                  isBold: true,
                )
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                const Expanded(flex: 4, child: Counter()),
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
