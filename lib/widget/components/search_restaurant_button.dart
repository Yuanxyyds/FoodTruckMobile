import 'package:flutter/material.dart';
import 'package:food_truck_mobile/helper/constants.dart';
import 'package:food_truck_mobile/models/restaurant_model.dart';
import 'package:food_truck_mobile/screen/restaurant_menu_screen.dart';
import 'package:food_truck_mobile/widget/components/home_restaurant_button.dart';
import 'package:food_truck_mobile/widget/decorations/close_tag.dart';
import 'package:food_truck_mobile/widget/decorations/open_tag.dart';
import 'package:food_truck_mobile/widget/text.dart';

/// This is the Restaurant Button on the Home Screen, Slightly different UI than
/// [HomeRestaurantButton]

class SearchRestaurantButton extends StatelessWidget {
  const SearchRestaurantButton(
      {super.key,
      this.deliveryPrice = -1,
      this.priceCategory = 3,
      required this.restaurantModel});

  final RestaurantModel restaurantModel;
  final double
      deliveryPrice; // 0 Free Delivery, -1 not available, otherwise specified
  final int priceCategory; // 1-5

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  RestaurantMenuScreen(
                restaurantModel: restaurantModel,
              ),
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
              if (restaurantModel.restaurantUrl == null)
                Expanded(
                  flex: 2,
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
              if (restaurantModel.restaurantUrl != null)
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(
                          restaurantModel.restaurantUrl,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextTitleSmall(
                              text: restaurantModel.name,
                              isBold: true,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          if (restaurantModel.isOpen) const OpenTag(),
                          if (!(restaurantModel.isOpen)) const CloseTag(),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextLabelSmall(
                          maxLine: 2,
                          text: restaurantModel.description!,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                        ),
                      ),
                      Expanded(
                          child: _DeliveryPriceBar(
                        deliveryPrice: deliveryPrice,
                        priceCategory: priceCategory,
                      )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeliveryPriceBar extends StatelessWidget {
  const _DeliveryPriceBar(
      {Key? key, required this.deliveryPrice, required this.priceCategory})
      : super(key: key);

  final double deliveryPrice;
  final int priceCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          const Icon(
            Icons.delivery_dining,
          ),
          const SizedBox(width: 8,),
          if (deliveryPrice < 0)
            const Expanded(
                child: TextTitleSmall(
                  text: 'no delivery',
                  padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                  isBold: true,
                )),
          if (deliveryPrice == 0)
            const Expanded(
                child: TextTitleSmall(
                  text: 'free delivery',
                  padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                  isBold: true,
                )),
          if (deliveryPrice > 0)
            Expanded(
                child: TextTitleSmall(
                  text: '\$$deliveryPrice delivery',
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  isBold: true,
                )),
          const SizedBox(width: 8,),
          Align(
              alignment: Alignment.centerRight,
              child: TextTitleSmall(
                text: '\$' * priceCategory,
                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                isBold: true,
              )),
          TextTitleSmall(
            text: '\$' * (5 - priceCategory),
            color: Colors.grey,
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
            isBold: true,
          ),
        ],
      ),
    );
  }
}
