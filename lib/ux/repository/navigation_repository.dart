import 'dart:convert';

import 'package:chance_app/ui/pages/navigation/navigation_page/components/map_data.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class NavigationRepository {
  Future<LatLng?> getLocationFromPlaceId(PickResult pickResult) async {
    LatLng? latLng;
    try {
      Uri uri = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/details/json?fields=geometry&place_id=${pickResult.placeId}&key=$googleAPIKey");
      await http.post(uri, headers: <String, String>{
        'Content-Type': 'application/json',
      }).then((value) async {
        if (value.statusCode > 199 && value.statusCode < 300) {
          Map<String, dynamic> map = jsonDecode(value.body);
          latLng = LatLng(map["result"]["geometry"]["location"]["lat"],
              map["result"]["geometry"]["location"]["lng"]);
        }
      });
    } catch (error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    }
    return latLng;
  }
}