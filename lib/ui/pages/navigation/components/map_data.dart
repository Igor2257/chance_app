
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart';
import 'package:chance_app/ux/position_controller.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

bool isNotTapedOnMyLocationButton = false;
GoogleMapController? mapController;

Set<Marker> setMarkers = {};

String getUrl(LatLng position, LatLng position1) {
  String origin = "origin=${position.latitude},${position.longitude}";
  String destination =
      "destination=${position1.latitude},${position1.longitude}";
  String key = "key=AIzaSyDmTTd3yiTiyosQb_CYX2Ync20v-xiynYg";
  String parameters = "$origin&$destination&$key";
  String output = "json";
  String url =
      "https://maps.googleapis.com/maps/api/directions/$output?$parameters";
  return url;
}

String autoCompleteUrl(String text) {
  return "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$text&radius=1000000&key=$googleAPIKey";
}
List<LatLng> polylineCoordinates = [];
String googleAPIKey = "AIzaSyDmTTd3yiTiyosQb_CYX2Ync20v-xiynYg";
late PositionController positionController;
PickResult? firstPickResult, secondPickResult;