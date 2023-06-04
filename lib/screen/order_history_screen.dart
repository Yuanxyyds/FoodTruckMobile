import 'package:flutter/material.dart';
import 'package:food_truck_mobile/screen/order_detail_screen.dart';
import '../widget/bottom_navigation.dart';

/// TODO: [OrderHistoryScreen] UI not implemented yet

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 2,
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with the actual number of orders
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text('Order ${index + 1}'),
            // Replace with the order title or details
            subtitle: Text('Order Date: ${DateTime.now().toString()}'),
            // Replace with the order date
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OrderDetailScreen(
                      orderTitle: 'Sample Order',
                      orderPrice: 100.0,
                      foodItems: ['Food1', 'Food2'])));
            },
          );
        },
      ),
    );
  }
}
