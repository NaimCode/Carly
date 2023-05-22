import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  print("Grannnnnnnnnted");
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation);
}

final currentLocationProvider = FutureProvider((ref) => _determinePosition());

final streamLocationProvider = Provider((ref) {
  const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 30,
  );
  return Geolocator.getPositionStream(locationSettings: locationSettings);
});

class PosNotifier extends StateNotifier<LatLng?> {
  PosNotifier() : super(null) {
    init();
  }
  LatLng? destination;
  void init() async {
    Position pos = await _determinePosition();
    state = LatLng(pos.latitude, pos.longitude);
  }

  void update(LatLng latLng) {
    state = latLng;
  }

  void setDestination(LatLng latLng) {
    destination = latLng;
  }
}

final posProvider =
    StateNotifierProvider<PosNotifier, LatLng?>((ref) => PosNotifier());

final mapControllerProvider =
    Provider((ref) => Completer<GoogleMapController>());

class DesNotifier extends StateNotifier<LatLng?> {
  DesNotifier() : super(null);

  void update(LatLng latLng) {
    state = latLng;
  }
}

final destinataireProvider =
    StateNotifierProvider<DesNotifier, LatLng?>((ref) => DesNotifier());

final markersProvider = Provider((ref) {
  final location = ref.watch(posProvider);
  final destination = ref.watch(destinataireProvider);

  Set<Marker> markers = {};

  if (location != null) {
    markers.add(Marker(
        markerId: const MarkerId("Current"),
        position: location,
        flat: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(20)));
  }
  if (destination != null) {
    markers.add(
        Marker(markerId: const MarkerId("Destination"), position: destination));
  }

  return markers;
});

final distanceProvider = Provider((ref) {
  final location = ref.watch(posProvider);
  final destination = ref.watch(destinataireProvider);
  if (location == null || destination == null) return null;
  return Geolocator.distanceBetween(location.latitude, location.longitude,
      destination.latitude, destination.longitude);
});
