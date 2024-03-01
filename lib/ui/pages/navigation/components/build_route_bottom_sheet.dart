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
import 'package:fluttertoast/fluttertoast.dart';
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
                if (firstPickResult == null || secondPickResult == null) {
                  return null;
                }
                if (firstPickResult!.id != secondPickResult!.id) {
                  await getPolyline().then((value) {
                    if (value != null) {
                      mapController!.animateCamera(CameraUpdate.newLatLngZoom(
                          LatLng(value.latitude, value.longitude), 18));
                      Navigator.of(context).pop();
                    }
                  });
                } else {
                  Fluttertoast.showToast(
                      msg: "Оберіть іншу кінцеву точку",
                      toastLength: Toast.LENGTH_LONG);
                }
              },
              color: firstPickResult != null && secondPickResult != null
                  ? primary1000
                  : darkNeutral400,
              child: Text(
                "Побудувати маршрут",
                style: TextStyle(color: primary50, fontSize: 16),
              )),
        ],
      ),
    );
  }

  Future<PointLatLng?> getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PointLatLng? firstPointLatLng;
    if (firstPickResult!.id != "me") {
      try {
        firstPointLatLng = PointLatLng(firstPickResult!.geometry!.location.lat,
            firstPickResult!.geometry!.location.lng);
      } catch (e) {
        firstPointLatLng = await getPositionOfPoint(firstPickResult!);
      }
    } else {
      firstPointLatLng = PointLatLng(firstPickResult!.geometry!.location.lat,
          firstPickResult!.geometry!.location.lng);
    }
    PointLatLng? secondPointLatLng;
    if (secondPickResult!.id != "me") {
      try {
        secondPointLatLng = PointLatLng(
            secondPickResult!.geometry!.location.lat,
            secondPickResult!.geometry!.location.lng);
      } catch (e) {
        secondPointLatLng = await getPositionOfPoint(secondPickResult!);
      }
    } else {
      secondPointLatLng = PointLatLng(secondPickResult!.geometry!.location.lat,
          secondPickResult!.geometry!.location.lng);
    }
    if (firstPointLatLng == null || secondPointLatLng == null) {
      return null;
    }
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      firstPointLatLng,
      secondPointLatLng,
    );
    List<LatLng> polylineCoordinates = [];
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    Polyline polyline = Polyline(
      polylineId: const PolylineId("route"),
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
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
                  LatLng(
                      firstPointLatLng!.latitude, firstPointLatLng.longitude),
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
                      secondPointLatLng!.latitude, secondPointLatLng.longitude),
                  18));
            }));
    setMarkers.add(pointB);
    setState(() {});

    return firstPointLatLng;
  }


}
