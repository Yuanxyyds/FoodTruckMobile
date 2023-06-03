import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/home_restaurant.dart';
import 'package:food_truck_mobile/widget/input_field.dart';
import 'package:food_truck_mobile/widget/section_divider.dart';
import 'package:food_truck_mobile/widget/text.dart';

import '../widget/bottom_navigation.dart';
import '../widget/search_restaurant.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  final FocusNode _textFieldFocusNode = FocusNode();

  final List<String> _recommendedRestaurants = [
    'Restaurant A',
    'Restaurant B',
    'Starbucks',
    'McDonald',
    'KFC',
  ];

  List<String> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _searchResults.clear();
      if (query.isNotEmpty) {
        // Perform search logic here, e.g., query the database or API
        // and update _searchResults list accordingly
        _searchResults = _recommendedRestaurants
            .where((restaurant) =>
                restaurant.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNavigation(
          currentIndex: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: _isSearching
              ? _buildSearchResults()
              : _buildRecommendedRestaurants(),
        ));
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: InputField(
              focusNode: _textFieldFocusNode,
              labelText: 'Search for restaurant',
              prefixIcon: const Icon(Icons.search),
              controller: _searchController,
              onChange: _search,
              onTap: () {
                setState(() {
                  if (!_isSearching) {
                    _isSearching = !_isSearching;
                    _searchResults.clear();
                    _searchController.clear();
                  }
                });
              },
            ),
          ),
          if (_isSearching)
            Expanded(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                    _searchResults.clear();
                    _searchController.clear();
                    _textFieldFocusNode.unfocus();
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecommendedRestaurants() {
    return Column(children: [
      _appBar(),
      Expanded(
        child: ListView.builder(
          itemCount: _recommendedRestaurants.length * 2 - 1,
          itemBuilder: (context, index) {
            bool isEven = index % 2 == 0;
            if (isEven) {
              final restaurant = _recommendedRestaurants[index ~/ 2];
              return SearchRestaurant(
                  restaurantName: restaurant,
                  label: 'label',
                  deliveryPrice: -1,
                  priceCategory: 2);
            } else {
              return const SectionDivider();
            }
          },
        ),
      ),
    ]);
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Column(children: [
        _appBar(),
        const Expanded(
          child: Center(
            child: TextHeadlineSmall(
              text: 'No result found',
            ),
          ),
        ),
      ]);
    }

    return Column(children: [
      _appBar(),
      Expanded(
        child: ListView.builder(
          itemCount: _searchResults.length * 2 - 1,
          itemBuilder: (context, index) {
            bool isEven = index % 2 == 0;
            if (isEven) {
              final restaurant = _searchResults[index ~/ 2];
              return SearchRestaurant(
                  restaurantName: restaurant,
                  label: 'label',
                  deliveryPrice: -1,
                  priceCategory: 2);
            } else {
              return const SectionDivider();
            }
          },
        ),
      ),
    ]);
  }
}
