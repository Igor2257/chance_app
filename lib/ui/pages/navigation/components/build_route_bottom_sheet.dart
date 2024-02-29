import 'dart:async';
import 'dart:ui' as ui;

import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/components/map_data.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/select_place.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BuildRouteBottomSheet extends StatefulWidget {
  const BuildRouteBottomSheet({super.key});

  @override
  State<BuildRouteBottomSheet> createState() => _BuildRouteBottomSheetState();
}

class _BuildRouteBottomSheetState extends State<BuildRouteBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedButton(
              onPress: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => const SelectPlace(
                              pickResultFor: PickResultFor.first,
                            )))
                    .whenComplete(() => setState(() {}));
              },
              border: Border.all(
                color: darkNeutral800,
              ),
              height: 0,
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: primaryText,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    firstPickResult?.formattedAddress ??
                            "Додати пункт відправлення",
                        style: TextStyle(color: primaryText, fontSize: 16),
                        maxLines: 5,
                      )),
                ],
              )),
          const SizedBox(
            height: 24,
          ),
          RoundedButton(
              height: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              onPress: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                    builder: (context) => const SelectPlace(
                      pickResultFor: PickResultFor.second,
                            )))
                    .whenComplete(() => setState(() {}));
              },
              border: Border.all(
                color: darkNeutral800,
              ),
              color: Colors.transparent,
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: primaryText,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    secondPickResult?.formattedAddress ??
                        "Додати пункт відправлення",
                    style: TextStyle(color: primaryText, fontSize: 16),
                    maxLines: 5,
                  )),
                ],
              )),
          const SizedBox(
            height: 24,
          ),
          RoundedButton(
              onPress: () async {
                await getPolyline().then((value) {
                  if (value != null) {
                    mapController!.animateCamera(CameraUpdate.newLatLngZoom(
                        LatLng(value.latitude, value.longitude), 18));
                  }
                  
                  Navigator.of(context).pop();
                });
              },
              color: firstPickResult != null && secondPickResult != null
                  ? primary1000
                  : darkNeutral600,
              child: Text(
                "Побудувати маршрут",
                style: TextStyle(color: primary50, fontSize: 16),
              )),
        ],
      ),
    );
  }

  Future<PointLatLng?> getPolyline() async {
    if (firstPickResult == null || secondPickResult == null) {
      return null;
    }
    PolylinePoints polylinePoints = PolylinePoints();
    PointLatLng? firstPointLatLng = await getPositionOfPoint(firstPickResult!);
    PointLatLng? secondPointLatLng =
        await getPositionOfPoint(secondPickResult!);
    if (firstPointLatLng == null || secondPointLatLng == null) {
      return null;
    }
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      firstPointLatLng, // Начальная точка
      secondPointLatLng, // Конечная точка
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    Polyline polyline = Polyline(
      polylineId: const PolylineId("route"),
      color: Colors.red, // Цвет маршрута
      points: polylineCoordinates, // Координаты маршрута
      width: 3, // Ширина маршрута
    );
    polylines.removeWhere((element) => element.polylineId==const PolylineId("route"));
    polylines.add(polyline);
    Marker pointA = Marker(
        markerId: const MarkerId("point_a"),
        draggable: false,
        position: LatLng(firstPointLatLng.latitude, firstPointLatLng.longitude),
        icon: await getMarkerIcon(PickResultFor.first) ??
            await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(
                    devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
                "assets/icons/point_a.png"),
        infoWindow: InfoWindow(
            title: firstPickResult!.name,
            snippet: firstPickResult!.formattedAddress,
            onTap: () {
              mapController!.animateCamera(CameraUpdate.newLatLngZoom(
                  LatLng(firstPointLatLng.latitude, firstPointLatLng.longitude),
                  18));
            }));
    setMarkers.clear();
    setMarkers.add(pointA);
    Marker pointB = Marker(
        markerId: const MarkerId("point_B"),
        draggable: false,
        position:
            LatLng(secondPointLatLng.latitude, secondPointLatLng.longitude),
        icon: await getMarkerIcon(PickResultFor.second) ??
            await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(
                    devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
                "assets/icons/point_b.png"),
        infoWindow: InfoWindow(
            title: secondPickResult!.name,
            snippet: secondPickResult!.formattedAddress,
            onTap: () {
              mapController!.animateCamera(CameraUpdate.newLatLngZoom(
                  LatLng(
                      secondPointLatLng.latitude, secondPointLatLng.longitude),
                  18));
            }));
    setMarkers.add(pointB);
    setState(() {});

    return firstPointLatLng;
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
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
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
}
