import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                count = count > 0 ? count - 1 : 0;
              });
            },
            child: const Icon(Icons.remove),
          ),
          Text(
            count.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                count += 1;
              });
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
