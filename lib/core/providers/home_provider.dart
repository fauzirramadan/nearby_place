import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearby_place/utils/constant.dart';

import '../../utils/notif_utils.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    init();
  }

  GoogleMapController? mapController;
  List<PlacesAutocompleteResult> listPlace = [];
  Set<Marker> marker = {};
  CameraPosition initialMapLocation = const CameraPosition(
    target: LatLng(-6.200000, 106.816666),
    zoom: 14,
  );
  Position? currentPositon;
  bool isLoading = false;
  String? errorMessage;

  void init() {
    refresh();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      NotifUtils.showSnackbar("Please turn on your location");
      return Future.error("Location services is enabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanently denied");
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPositon = position;
    setMapPositionCurrent(position);

    return position;
  }

  void setMapPositionCurrent(Position position) {
    initialMapLocation = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14,
    );
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 22)));
    marker.clear();
    marker.add(Marker(
        markerId: const MarkerId('current location'),
        position: LatLng(position.latitude, position.longitude)));
  }

  void refresh() async {
    isLoading = true;
    notifyListeners();
    await _determinePosition();
    isLoading = false;
    notifyListeners();
  }

  void oncameraMove(CameraPosition position) {
    marker.clear();
    marker.add(Marker(
        markerId: const MarkerId('current location'),
        position: LatLng(position.target.latitude, position.target.longitude)));
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
