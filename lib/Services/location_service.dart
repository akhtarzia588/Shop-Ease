import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

enum LocationStatus {
  success,
  serviceDisabled, // phone ki location band hai
  denied, // user ne mana kiya
  deniedForever, // user ne "dobara mat poocho" kiya
  error,
}

class LocationResult {
  final LocationStatus status;
  final String? address; // "Karachi, Pakistan"
  final double? latitude;
  final double? longitude;

  LocationResult(this.status, {this.address, this.latitude, this.longitude});
}

class LocationService {
  Future<LocationResult> getCurrentLocation() async {
    try {
      // 1. Phone ki location service on hai?
      final serviceOn = await Geolocator.isLocationServiceEnabled();
      if (!serviceOn) {
        return LocationResult(LocationStatus.serviceDisabled);
      }

      // 2. Permission check aur maangna
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        return LocationResult(LocationStatus.denied);
      }
      if (permission == LocationPermission.deniedForever) {
        return LocationResult(LocationStatus.deniedForever);
      }

      // 3. Coordinates
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );

      // 4. Coordinates se shehar ka naam
      String address =
          '${position.latitude.toStringAsFixed(3)}, ${position.longitude.toStringAsFixed(3)}';
      try {
        final geocoding = Geocoding();
        final places = await geocoding.placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (places.isNotEmpty) {
          final p = places.first;

          final String locality = p.locality ?? '';
          final String subArea = p.subAdministrativeArea ?? '';
          final String country = p.country ?? '';

          final String city = locality.isNotEmpty ? locality : subArea;

          final String text = [
            city,
            country,
          ].where((e) => e.isNotEmpty).join(', ');

          if (text.isNotEmpty) address = text;
        }
      } catch (_) {
        // Geocoding fail ho to coordinates hi dikha do
      }

      return LocationResult(
        LocationStatus.success,
        address: address,
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      return LocationResult(LocationStatus.error);
    }
  }
}
