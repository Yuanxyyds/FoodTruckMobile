import 'package:flutter/material.dart';
import 'package:food_truck_mobile/helper/constants.dart';
import 'package:food_truck_mobile/models/restaurant_model.dart';
import 'package:food_truck_mobile/screen/restaurant_menu_screen.dart';
import 'package:food_truck_mobile/widget/decorations/open_tag.dart';
import 'package:food_truck_mobile/widget/text.dart';
import 'package:food_truck_mobile/widget/decorations/close_tag.dart';

/// This is the Restaurant Button on the Home Screen, Slightly different UI than
/// [SearchRestaurantButton]
class HomeRestaurantButton extends StatelessWidget {
  const HomeRestaurantButton(
      {super.key,
      this.deliveryPrice = -1,
      this.priceCategory = 2,
      required this.restaurantModel});

  final RestaurantModel restaurantModel;
  final double
      deliveryPrice; // 0 Free Delivery, -1 not available, otherwise specified
  final int priceCategory; // 1-5

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                RestaurantMenuScreen(restaurantModel: restaurantModel,),
            transitionDuration: Duration.zero,
          ),
        );
      },
      child: Container(
        width: 220,
        height: 160,
        decoration: BoxDecoration(
            color: Constants.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (restaurantModel.restaurantUrl == null)
                Expanded(
                  child: Container(
                    width: 250,
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
                  child: Container(
                    width: 250,
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
              Expanded(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextTitleSmall(
                          text: restaurantModel.name,
                          isBold: true,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      if (restaurantModel.isOpen)
                        const OpenTag(),
                      if (!(restaurantModel.isOpen))
                        const CloseTag(),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextLabelSmall(
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
                child: Center(
                  child: TextTitleSmall(
                    text: 'no delivery',
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                    isBold: true,
                  ),
                )),
          if (deliveryPrice == 0)
            const Expanded(
                child: Center(
                  child: TextTitleSmall(
                    text: 'free delivery',
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                    isBold: true,
                  ),
                )),
          if (deliveryPrice > 0)
            Expanded(
                child: Center(
                  child: TextTitleSmall(
                    text: '\$$deliveryPrice delivery',
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                    isBold: true,
                  ),
                )),
          SizedBox(width: 8,),
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
