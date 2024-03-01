import 'dart:async';
import 'dart:ui' as ui;

import 'package:chance_app/ui/pages/navigation/place_picker/src/models/address_component.dart'
    as myaddress;
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/bounds.dart'
    as myBounds;
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/geometry.dart'
    as myGeometry;
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/location.dart'
    as myLocation;
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart'
    as myPick;
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/select_place.dart';
import 'package:chance_app/ux/position_controller.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

bool isNotTapedOnMyLocationButton = false;
GoogleMapController? mapController;

String googleAPIKey = "AIzaSyDmTTd3yiTiyosQb_CYX2Ync20v-xiynYg";

late PositionController positionController;


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

Future<PointLatLng?> getPositionOfPoint(PickResult pickResult) async {
  final result = await Repository().getLocationFromPlaceId(pickResult);
  if (result == null) {
    return null;
  }
  return PointLatLng(result.latitude, result.longitude);
}

Future<BitmapDescriptor?> getMarkerIcon(PickResultFor pickResultFor) async {
  Size size = const Size(170, 170);
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);

  final Radius radius = Radius.circular(size.width / 2);

  final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
  const double shadowWidth = 15.0;

  final Paint borderPaint = Paint()..color = Colors.white;
  const double borderWidth = 3.0;

  const double imageOffset = shadowWidth + borderWidth;

  // Add shadow circle
  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      shadowPaint);

  // Add border circle
  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(shadowWidth, shadowWidth, size.width - (shadowWidth * 2),
            size.height - (shadowWidth * 2)),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      borderPaint);

  // Oval for the image
  Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
      size.width - (imageOffset * 2), size.height - (imageOffset * 2));

  // Add path for oval image
  canvas.clipPath(Path()..addOval(oval));

  // Add image
  String path = "";
  switch (pickResultFor) {
    case PickResultFor.first:
      path = "assets/icons/point_a.png";
      break;
    case PickResultFor.second:
      path = "assets/icons/point_b.png";
      break;
  }
  ui.Image image = await getImageFromPath(
      path: path); // Alternatively use your own method to get the image
  paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.contain);

  // Convert canvas to image
  final ui.Image markerAsImage = await pictureRecorder
      .endRecording()
      .toImage(size.width.toInt(), size.height.toInt());

  // Convert image to bytes
  final ByteData? byteData =
      await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
  if (byteData != null) {
    final Uint8List uint8List = byteData.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(uint8List);
  }
  return null;
}

Future<ui.Image> getImageFromPath({required String path}) async {
  Uint8List imageBytes = Uint8List(0);
  final ByteData bytes = await rootBundle.load(path);
  imageBytes = bytes.buffer.asUint8List();

  final Completer<ui.Image> completer = Completer();

  ui.decodeImageFromList(imageBytes, (ui.Image img) {
    return completer.complete(img);
  });

  return completer.future;
}

myPick.PickResult getPickResult(PlaceDetails result) {
  Map<String, dynamic> map = result.toJson();
  map["geometry"] = myGeometry.Geometry(
          location: myLocation.Location(
              lat: result.geometry!.location.lat,
              lng: result.geometry!.location.lng),
          locationType: result.geometry!.locationType,
          viewport: result.geometry!.viewport != null
              ? myBounds.Bounds(
                  northeast: myLocation.Location(
                      lat: result.geometry!.viewport!.northeast.lat,
                      lng: result.geometry!.viewport!.northeast.lng),
                  southwest: myLocation.Location(
                      lat: result.geometry!.viewport!.southwest.lat,
                      lng: result.geometry!.viewport!.southwest.lng))
              : null,
          bounds: result.geometry!.bounds != null
              ? myBounds.Bounds(
                  northeast: myLocation.Location(
                      lat: result.geometry!.bounds!.northeast.lat,
                      lng: result.geometry!.bounds!.northeast.lng),
                  southwest: myLocation.Location(
                      lat: result.geometry!.bounds!.southwest.lat,
                      lng: result.geometry!.bounds!.southwest.lng))
              : null)
      .toJson();
  map["address_components"] = result.addressComponents
      .map((e) => myaddress.AddressComponent(
          types: e.types, longName: e.longName, shortName: e.shortName))
      .toList();
  return myPick.PickResult.fromJson(map);
}