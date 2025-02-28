part of '../index.dart';

class MapController extends GetxController {
  var targetLocation = const LatLng(0.0, 0.0).obs;
  GoogleMapController? mapController;

  void setTargetLocation(LocationModel location) {
    targetLocation.value = LatLng(location.lat, location.lng);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
