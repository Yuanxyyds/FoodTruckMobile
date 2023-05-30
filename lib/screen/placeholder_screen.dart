import 'package:flutter/material.dart';
import '../widget/bottom_navigation.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placeholder'),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1,),
      body: const Center(
        child: Text(
          'Placeholder Content',
          style: TextStyle(fontSize: 24),
        ),
      ),

    );
  }
}