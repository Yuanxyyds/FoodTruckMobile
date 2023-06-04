import 'package:flutter/material.dart';
import 'package:food_truck_mobile/helper/constants.dart';
import 'package:food_truck_mobile/screen/restaurant_menu_screen.dart';
import 'package:food_truck_mobile/widget/home_restaurant_button.dart';
import 'package:food_truck_mobile/widget/text.dart';

/// This is the Restaurant Button on the Home Screen, Slightly different UI than
/// [HomeRestaurantButton]

class SearchRestaurantButton extends StatelessWidget {
  const SearchRestaurantButton(
      {super.key,
      this.imageUrl,
      required this.restaurantName,
      required this.label,
      required this.deliveryPrice,
      required this.priceCategory});

  final String? imageUrl;
  final String restaurantName;
  final String label;
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
                      restaurantName: restaurantName,
                      restaurantDescription: 'restaurantDescription',
                      restaurantRating: 5.0,
                      foodItems: const [
                    'Food 1',
                    'Food 2',
                    'Food3',
                    'Food4',
                    'Food5'
                  ]),
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
              if (imageUrl == null)
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
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextTitleSmall(
                          text: restaurantName,
                          isBold: true,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextLabelSmall(
                          text: label,
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
          const Expanded(
              flex: 4,
              child: Icon(
                Icons.delivery_dining,
              )),
          const Expanded(flex: 2, child: SizedBox()),
          if (deliveryPrice < 0)
            const Expanded(
                flex: 16,
                child: TextTitleSmall(
                  text: 'no delivery',
                  padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                  isBold: true,
                )),
          if (deliveryPrice == 0)
            const Expanded(
                flex: 16,
                child: TextTitleSmall(
                  text: 'free delivery',
                  padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                  isBold: true,
                )),
          if (deliveryPrice > 0)
            Expanded(
                flex: 16,
                child: TextTitleSmall(
                  text: '\$ $deliveryPrice',
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  isBold: true,
                )),
          const Expanded(flex: 2, child: SizedBox()),
          Expanded(
              flex: 5,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: TextTitleSmall(
                    text: '\$' * priceCategory,
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                    isBold: true,
                  ))),
          Expanded(
              flex: 5,
              child: TextTitleSmall(
                text: '\$' * (5 - priceCategory),
                color: Colors.grey,
                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                isBold: true,
              )),
        ],
      ),
    );
  }
}
