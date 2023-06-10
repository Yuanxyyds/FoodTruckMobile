import 'package:flutter/material.dart';


/// TODO: [OrderDetailScreen] UI not implemented yet
class OrderDetailScreen extends StatefulWidget {
  final String orderTitle;
  final double orderPrice;
  final List<String> foodItems;

  const OrderDetailScreen({
    Key? key,
    required this.orderTitle,
    required this.orderPrice,
    required this.foodItems,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.orderTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Price: \$${widget.orderPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Food Items:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.foodItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.foodItems[index]),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Rate this Order:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Slider(
                  value: _rating,
                  min: 0.0,
                  max: 5.0,
                  onChanged: (value) {
                    setState(() {
                      _rating = value;
                    });
                  },
                ),
                Text('${_rating.toStringAsFixed(1)}'),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                // Perform rating submission or any other action
                // You can access the order title, price, food items, and rating from the widget's properties
              },
              child: const Text('Submit Rating'),
            ),
          ),
        ],
      ),
    );
  }
}
