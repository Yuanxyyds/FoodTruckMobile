import 'package:flutter/material.dart';
import 'package:food_truck_mobile/helper/constants.dart';
import 'package:food_truck_mobile/models/food_model.dart';
import 'package:food_truck_mobile/screen/food_detail_screen.dart';
import 'package:food_truck_mobile/screen/restaurant_menu_screen.dart';
import 'package:food_truck_mobile/widget/decorations/popular_tag.dart';
import 'package:food_truck_mobile/widget/text.dart';

/// This class contains a [FoodButton] that can be pressed to view the food's
/// details
class FoodButton extends StatelessWidget {
  const FoodButton(
      {super.key,
      this.isPopular = true, required this.foodModel});

  final FoodModel foodModel;
  final bool isPopular;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FoodDetailScreen(
                      foodModel: foodModel,
                      isPopular: isPopular),
              transitionDuration: Duration.zero,
            ),
          );
        },
        child: Container(
          height: 100,
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
                        text: foodModel.name,
                        isBold: true,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextLabelSmall(
                          text: foodModel.description,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          maxLine: 3,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextTitleSmall(
                            text: '\$ ${foodModel.price}',
                            isBold: true,
                          )),
                          if (isPopular) const PopularTag(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8,),
              if (foodModel.foodUrl == null)
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
              if (foodModel.foodUrl != null)
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(
                          foodModel.foodUrl,
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
