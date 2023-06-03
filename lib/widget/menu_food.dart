import 'package:flutter/material.dart';
import 'package:food_truck_mobile/helper/constants.dart';
import 'package:food_truck_mobile/screen/restaurant_menu_screen.dart';
import 'package:food_truck_mobile/widget/popular_tag.dart';
import 'package:food_truck_mobile/widget/text.dart';

class MenuFood extends StatelessWidget {
  const MenuFood({super.key,
    this.imageUrl,
    required this.foodName,
    required this.description,
    required this.price,
    this.isPopular = true});

  final String? imageUrl;
  final String foodName;
  final String description;
  final double price;
  final bool isPopular;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 110,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextTitleSmall(
                        text: foodName,
                        isBold: true,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextLabelSmall(
                        text: description,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        maxLine: 3,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: Row(
                          children: [
                            Expanded(child: TextTitleSmall(text: '\$ $price', isBold: true,)),
                            if (isPopular) const PopularTag(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8,),
              if (imageUrl == null)
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage(
                          'images/DefaultRestaurantImage.jpeg',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              if (imageUrl != null)
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                          imageUrl!,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


