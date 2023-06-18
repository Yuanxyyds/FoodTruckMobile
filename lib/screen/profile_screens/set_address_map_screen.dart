import 'package:flutter/material.dart';
import 'package:food_truck_mobile/providers/firebase/auth_manager.dart';
import 'package:food_truck_mobile/helper/constants.dart';
import 'package:food_truck_mobile/models/user_model.dart';
import 'package:food_truck_mobile/widget/components/button.dart';
import 'package:food_truck_mobile/widget/components/input_field.dart';
import 'package:food_truck_mobile/widget/dialogs/permission_setting_dialog.dart';
import 'package:food_truck_mobile/widget/map.dart';
import 'package:food_truck_mobile/widget/text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:food_truck_mobile/providers/user_location_provider.dart';

/// A [SetAddressMapScreen] that shows the location of current User
class SetAddressMapScreen extends StatefulWidget {
  SetAddressMapScreen({
    super.key, required this.auth, required this.userModel,
  });

  final AuthManager auth;
  UserModel userModel;

  @override
  State<SetAddressMapScreen> createState() => _SetAddressMapScreenState();
}

class _SetAddressMapScreenState extends State<SetAddressMapScreen> {
  final TextEditingController _addressController = TextEditingController();
  bool _isRequesting = true;
  bool _isSearching = false;
  LatLng selectedUserLocation = const LatLng(40.5, -74);
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserLocationProvider userLocation = context.watch<UserLocationProvider>();
    return _isSearching
        ? _getSearchContent()
        : (_isRequesting
            ? _getCurrentLocationContent(context, userLocation)
            : _getSearchedLocationContent(context, userLocation));
  }

  Widget _getCurrentLocationContent(
      BuildContext context, UserLocationProvider userLocation) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 32),
        child: Column(
          children: [
            TextTitleLarge(
              text: 'Add Address',
              color: Theme.of(context).primaryColor,
              isBold: true,
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: TextBodySmall(
                text: 'Please add your location. Adding your location will ',
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
              ),
            ),
            Center(
              child: TextBodySmall(
                text: 'help us locate you.',
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: TextBodyMedium(
                  text: 'Home Address',
                  isBold: true,
                  color: Theme.of(context).primaryColor,
                )),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: userLocation.requestCurrentLocation(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _addressController.text = userLocation.currentAddress;
                    return Column(
                      children: [
                        InputField(
                          controller: _addressController,
                          labelText: 'Home Address',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.my_location),
                            onPressed: () {
                              setState(() {
                                _isRequesting = true;
                              });
                            },
                          ),
                          onTap: () {
                            setState(() {
                              _isSearching = true;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: MapWidget(
                            currentUserLocation:
                                userLocation.currentUserLocation != null
                                    ? LatLng(
                                        userLocation
                                            .currentUserLocation!.latitude!,
                                        userLocation
                                            .currentUserLocation!.longitude!)
                                    : const LatLng(43.727707, -79.413954),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Button(
              text: 'Update',
              textColor: Constants.whiteColor,
              takeLeastSpace: false,
              onPressed: () {
                widget.userModel.address = _addressController.text;
                widget.auth.updateUser(widget.userModel);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSearchedLocationContent(
      BuildContext context, UserLocationProvider userLocation) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 32),
        child: Column(
          children: [
            TextTitleLarge(
              text: 'Add Address',
              color: Theme.of(context).primaryColor,
              isBold: true,
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: TextBodySmall(
                text: 'Please add your location. Adding your location will ',
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
              ),
            ),
            Center(
              child: TextBodySmall(
                text: 'help us create a circle for you.',
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: TextBodyMedium(
                  text: 'Home Address',
                  isBold: true,
                  color: Theme.of(context).primaryColor,
                )),
            const SizedBox(
              height: 16,
            ),
            Expanded(
                child: Column(
              children: [
                InputField(
                  controller: _addressController,
                  labelText: 'Home Address',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: () {
                      setState(() {
                        _isRequesting = true;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: MapWidget(
                    currentUserLocation: selectedUserLocation,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Button(
                  text: 'Update',
                  textColor: Constants.whiteColor,
                  onPressed: () {
                    widget.userModel.address = _addressController.text;
                    widget.auth.updateUser(widget.userModel);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _getSearchContent() {
    return Scaffold(
      appBar: _appBar(),
      body: _buildSearchResults(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      toolbarHeight: 80,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: InputField(
          controller: _addressController,
          labelText: 'Home Address',
          onTap: () {
            _addressController.selection = TextSelection(
              baseOffset: 0,
              extentOffset: _addressController.value.text.length,
            );
          },
          onChange: _search,
        ),
      ),
      actions: [
        if (_isSearching)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                _isSearching = false;
              });
            },
          ),
      ],
    );
  }

  /// The Action to filter restaurant based on user input
  void _search(String query) async {
    _searchResults.clear();
    if (query.isNotEmpty) {
      _searchResults = await UserLocationProvider().placeAutoComplete(query);
    }
    setState(() {});
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
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: const Icon(Icons.location_on),
            title: TextBodyMedium(
              text: _searchResults[index]['description'],
            ),
            onTap: () {
              setState(() {
                _addressController.text = _searchResults[index]['description'];
                selectedUserLocation = LatLng(_searchResults[index]['latitude'],
                    _searchResults[index]['longitude']);
                _isSearching = false;
                _isRequesting = false;
                _searchResults.clear();
              });
            });
      },
    );
  }
}
