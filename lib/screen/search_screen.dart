import 'package:flutter/material.dart';
import 'package:food_truck_mobile/providers/firebase/restaurant_manager.dart';
import 'package:food_truck_mobile/models/food_model.dart';
import 'package:food_truck_mobile/models/restaurant_model.dart';
import 'package:food_truck_mobile/widget/components/home_restaurant_button.dart';
import 'package:food_truck_mobile/widget/components/input_field.dart';
import 'package:food_truck_mobile/widget/dividers/section_divider.dart';
import 'package:food_truck_mobile/widget/text.dart';

import '../widget/components/bottom_navigation.dart';
import '../widget/components/search_restaurant_button.dart';

/// The [SearchScreen] of the App, it contains two states: View Recommendation
/// State when the search bar is not clicked, Search State when the search bar
/// is clicked TODO: Get instance from firestore

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  final FocusNode _textFieldFocusNode = FocusNode();
  List<RestaurantModel> _searchResults = [];
  List<RestaurantModel> _restaurants = [];

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RestaurantManager restaurantManager = RestaurantManager();
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 1,
      ),
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: _isSearching
            ? _buildSearchResults()
            : FutureBuilder<List<RestaurantModel>?>(
                future: restaurantManager.getAllRestaurant(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _restaurants = snapshot.data!;
                    return _buildRecommendedRestaurants();
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
      ),
    );
  }

  /// The Action to filter restaurant based on user input
  void _search(String query) {
    setState(() {
      _searchResults.clear();
      if (query.isNotEmpty) {
        _searchResults = _restaurants
            .where((restaurant) =>
                restaurant.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  /// The Searching Bar, it has two different UI in two different states
  AppBar _appBar() {
    return AppBar(
      toolbarHeight: 80,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: InputField(
          labelText: 'Search for restaurant',
          prefixIcon: const Icon(Icons.search),
          focusNode: _textFieldFocusNode,
          controller: _searchController,
          onChange: _search,
          onTap: () {
            setState(() {
              if (!_isSearching) {
                _isSearching = !_isSearching;
              }
            });
          },
        ),
      ),
      actions: [
        if (_isSearching)
          IconButton(
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
      ],
    );
  }

  /// The Component of View Recommendation Restaurants State
  Widget _buildRecommendedRestaurants() {
    return ListView.builder(
      itemCount:
          _restaurants.length * 2 - 1 <= 0 ? 0 : _restaurants.length * 2 - 1,
      itemBuilder: (context, index) {
        bool isEven = index % 2 == 0;
        if (isEven) {
          final restaurant = _restaurants[index ~/ 2];
          return SearchRestaurantButton(
            restaurantModel: restaurant,
          );
        } else {
          return const SectionDivider();
        }
      },
    );
  }

  /// The Component of Search State
  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(
        child: TextHeadlineSmall(
          text: 'No result found',
        ),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length * 2 - 1 <= 0
          ? 0
          : _searchResults.length * 2 - 1,
      itemBuilder: (context, index) {
        bool isEven = index % 2 == 0;
        if (isEven) {
          final restaurant = _searchResults[index ~/ 2];
          return SearchRestaurantButton(
            restaurantModel: restaurant,
          );
        } else {
          return const SectionDivider();
        }
      },
    );
  }
}
