import 'dart:convert';

import 'package:chance_app/ui/pages/navigation/navigation_page/components/map_data.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart';
import 'package:chance_app/ux/hive_crud.dart';
import 'package:chance_app/ux/model/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

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

  Future<String?> sendMyLocation(double latitude, double longitude) async {
    String? error;
    try {
      await Supabase.instance.client.from("ward_location").update({
        "latitude": latitude,
        "longitude": longitude,
        "when": DateTime.now().toIso8601String(),
      }).match({"myEmail": HiveCRUD().user!.email}).then((value) {
        print("value $value");
      });
    } catch (e) {
      error = e.toString();
      print("value $error");
    }

    return error;
  }

  Future<LatLng?> getWardLocation(String wardEmail) async {
    LatLng? latLng;
    try {
      await Supabase.instance.client
          .from("ward_location")
          .select()
          .match({"myEmail": wardEmail}).then((value) {
        List<dynamic> list = value;
        latLng = LatLng(double.parse(list[0]["latitude"].toString()),
            double.parse(list[0]["longitude"].toString()));
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print("error $e");
    }

    return latLng;
  }

  Future<String?> isAppShouldSentLocation() async {
    String? error;
    try {
      await Supabase.instance.client.rpc('isappshouldsentlocation',
          params: {"user_email": HiveCRUD().user!.email}).then((value) async {
        print("isappshouldsentlocation $value");
        if (value != null) {
          try {
            bool isAppShouldSentLocation = bool.parse(value.toString());
            HiveCRUD hiveCRUD = HiveCRUD();
            Settings settings = hiveCRUD.setting;
            settings = settings.copyWith(
                isAppShouldSentLocation: isAppShouldSentLocation);
            await hiveCRUD.updateSettings(settings);
          } catch (e) {
            FlutterError(e.toString());
          }
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print("error $e");
    }

    return error;
  }
}
