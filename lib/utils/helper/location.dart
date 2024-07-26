import 'package:geolocator/geolocator.dart';
import 'dart:developer';
import 'scaffold_snakbar.dart';

class LocationHelper {
  static Future<Position?> determineCurrentPosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    //* Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled.');
      customSnackBar(context, "Location services are disabled.");
    }

    //* Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permissions are denied.');
        customSnackBar(context, "Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log('Location permissions are permanently denied.');
      customSnackBar(context, "Location permissions are permanently denied.");
    }

    //* Try to get the last known position first for faster feedback
    Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
    if (lastKnownPosition != null) {
      log('Using last known position: ${lastKnownPosition.latitude}, ${lastKnownPosition.longitude}');
      return lastKnownPosition;
    }

    //* If no last known position is available, get the current position
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      log('Current position: ${currentPosition.latitude}, ${currentPosition.longitude}');
      return currentPosition;
    } catch (err) {
      log('Error getting current position: $err');
      customSnackBar(context, "Error getting current position.");
      return null;
    }
  }
}
