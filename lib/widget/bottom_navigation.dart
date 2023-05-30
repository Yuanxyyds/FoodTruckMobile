import 'package:flutter/material.dart';
import 'package:food_truck_mobile/screen/account_screen.dart';
import 'package:food_truck_mobile/screen/home_screen.dart';
import 'package:food_truck_mobile/screen/order_history_screen.dart';
import 'package:food_truck_mobile/screen/placeholder_screen.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({super.key, required this.currentIndex});


  @override
  Widget build(BuildContext context) {
    Widget screen = Container();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Fixed
      backgroundColor: Theme.of(context).primaryColorDark, // <-- This works for fixed
      selectedItemColor: Colors.greenAccent,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            screen = const HomeScreen();
            break;
          case 1:
            screen = const PlaceholderScreen();
            break;
          case 2:
            screen = const OrderHistoryScreen();
            break;
          case 3:
            screen = const AccountScreen();
            break;
        }
        Navigator.of(context).pop();
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => screen,
            transitionDuration: Duration.zero,
          ),
        );
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
      ],
    );
  }
}
