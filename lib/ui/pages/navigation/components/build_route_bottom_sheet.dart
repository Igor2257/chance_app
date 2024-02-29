import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/components/map_data.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/select_place.dart';
import 'package:flutter/material.dart';

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
      child: Column(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                              pickResultFor: PickResultFor.first,
                            )))
                    .whenComplete(() => setState(() {}));
              },
              border: Border.all(
                color: darkNeutral800,
              ),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: primaryText,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    secondPickResult?.formattedAddress??"Додати пункт відправлення",
                    style: TextStyle(color: primaryText, fontSize: 16),
                  ),
                ],
              )),
          const SizedBox(
            height: 24,
          ),
          RoundedButton(
              onPress: () async {
                //PolylinePoints polylinePoints = PolylinePoints();
//
                //PolylineResult result =
                //    await polylinePoints.getRouteBetweenCoordinates(
                //  googleAPIKey,
                //  PointLatLng(startLatitude, startLongitude), // Начальная точка
                //  PointLatLng(endLatitude, endLongitude), // Конечная точка
                //);
                //if (result.points.isNotEmpty) {
                //  result.points.forEach((PointLatLng point) {
                //    polylineCoordinates
                //        .add(LatLng(point.latitude, point.longitude));
                //  });
                //}
//
                //Polyline polyline = Polyline(
                //  polylineId: PolylineId("poly"),
                //  color: Colors.red, // Цвет маршрута
                //  points: polylineCoordinates, // Координаты маршрута
                //  width: 3, // Ширина маршрута
                //);
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
}
