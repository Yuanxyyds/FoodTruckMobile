import 'package:flutter/material.dart';
import 'package:food_truck_mobile/screen/home_screen.dart';
import 'package:food_truck_mobile/widget/text.dart';

import '../helper/constants.dart';
import '../widget/components/button.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order successful"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Image.asset('images/ThankYouDecoration.png'),
              const SizedBox(
                height: 50.0,
              ),
              const Center(
                child: SizedBox(
                    width: 300.0,
                    child: Text(
                        "Your purchase has been successfully completed!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold))),
              ),
            ],
          )),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: SizedBox(
          height: 60.0,
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const HomeScreen(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                },
                child: Container(
                    height: 45.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Constants.primaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.transparent),
                    child: const Center(
                      child: TextTitleMedium(
                        text: "Return to Home",
                        color: Constants.primaryColor,
                      ),
                    )),
              )),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                  child: SizedBox(
                height: 45.0,
                child: Button(
                  text: "Track your order",
                  textColor: Colors.white,
                  backgroundColor: Constants.primaryColor,
                  takeLeastSpace: true,
                  onPressed: () {},
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
