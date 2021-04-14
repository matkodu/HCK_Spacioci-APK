import 'dart:async';

import 'package:hck_locat_test1/data_models/user_location.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  UserLocation _currentLocation;

  var location = Location();

  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    // Request permission to use location

    if (Permission.location.isGranted != null) {
      // If granted listen to the onLocationChanged stream and emit over our controller
      location.onLocationChanged.listen((locationData) {
        if (locationData != null) {
          _locationController.add(UserLocation(
            latitude: locationData.latitude,
            longitude: locationData.longitude,
          ));
        }
      });
    }
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation;
  }
}
