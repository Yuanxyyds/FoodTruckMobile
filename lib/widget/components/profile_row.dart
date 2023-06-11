import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/text.dart';

import '../../helper/constants.dart';

class ProfileRow extends StatelessWidget {
  final IconData icon;
  final String info;
  final bool secondary;

  const ProfileRow(
      {required this.icon,
      required this.info,
      this.secondary = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 25.0),
      child: Row(
        children: [
          Container(
            width: 40.0, // Adjust the size of the container as needed
            height: 40.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Constants.primaryColorLight,
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(child: TextTitleMedium(text: info)),
          if (!secondary)
            Container(
              width: 40.0, // Adjust the size of the container as needed
              height: 40.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
