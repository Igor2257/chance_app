import 'dart:convert';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/enum/invitation_status.dart';
import 'package:chance_app/ux/model/invitation_model.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class InvitationRepository {
  Future<String?> sendConfirmToWard(String email) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      error = "Немає підключення до інтернету";
    } else {
      try {
        //var url = Uri.parse('$apiUrl/medicine');
        //final cookie = await getCookie();
        //String date = medicineModel.startDate!.toUtc().toString();
        //Map<String, dynamic> map = medicineModel.toJson();
        //map["startDate"] = date;
        //await http
        //    .post(
        //  url,
        //  headers: <String, String>{
        //    'Content-Type': 'application/json',
        //    'Cookie': cookie.toString(),
        //  },
        //  body: jsonEncode(map),
        //)
        //    .then((value) async {
        //  if (!(value.statusCode > 199 && value.statusCode < 300)) {
        //    error = jsonDecode(value.body)["message"]
        //        .toString()
        //        .replaceAll("[", "")
        //        .replaceAll("]", "");
        //  } else {
        //    await await addMedicine(medicineModel).whenComplete(() async {
        //      await setIsSentInLocalMedicine(true,
        //          medicineModel: medicineModel);
        //    });
        //  }
        //});
      } catch (e) {
        error = error.toString();
      }
    }
    if (error != null) {
      Fluttertoast.showToast(msg: error, toastLength: Toast.LENGTH_LONG);
    }
    return error;
  }

  Future<dynamic> getInvitationForMe() async {
    List<InvitationModel> invitations = [];
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      return "noInternet";
    } else {
      try {
        var url = Uri.parse('$apiUrl/navaccess/for-me');
        final cookie = await UserRepository().getCookie();
        await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookie.toString(),
          },
        ).then((value) async {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            Fluttertoast.showToast(
                msg: jsonDecode(value.body)["message"]
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                toastLength: Toast.LENGTH_LONG);
          } else {
            List<dynamic> list = jsonDecode(value.body);

            for (int i = 0; i < list.length; i++) {
              invitations.add(InvitationModel.fromJson(list[i]));
            }
          }
        });
      } catch (e) {
        return e.toString();
      }
    }
    return invitations;
  }

  Future<dynamic> getInvitationFromMe() async {
    List<InvitationModel> invitations = [];
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      return "noInternet";
    } else {
      try {
        var url = Uri.parse('$apiUrl/navaccess/from-me');
        final cookie = await UserRepository().getCookie();
        await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookie.toString(),
          },
        ).then((value) async {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            Fluttertoast.showToast(
                msg: jsonDecode(value.body)["message"]
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                toastLength: Toast.LENGTH_LONG);
          } else {
            List<dynamic> list = jsonDecode(value.body);

            for (int i = 0; i < list.length; i++) {
              invitations.add(InvitationModel.fromJson(list[i]));
            }
          }
        });
      } catch (e) {
        return e.toString();
      }
    }
    return invitations;
  }




  Future<String?> acceptInvitation(
      String id, InvitationStatus invitationStatus) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      error = "Немає підключення до інтернету";
    } else {
      try {
        var url = Uri.parse('$apiUrl/navaccess/$id/accept');
        final cookie = await UserRepository().getCookie();
        await http
            .patch(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookie.toString(),
          },
          body: jsonEncode({"navaccessId": id}),
        )
            .then((value) async {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
          }
        });
      } catch (e) {
        error = e.toString();
      }
    }

    return error;
  }
  Future<String?> rejectInvitation(String id) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      error= "Немає підключення до інтернету";
    } else {
      try {
        var url = Uri.parse('$apiUrl/navaccess/$id/reject');
        final cookie = await UserRepository().getCookie();
        await http
            .patch(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookie.toString(),
          },
          body: jsonEncode({"navaccessId": id}),
        )
            .then((value) async {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
          }
        });
      } catch (e) {
        error = e.toString();
      }
    }

    return error;
  }
  Future<String?> removeInvitation(String id) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      error= "Немає підключення до інтернету";
    } else {
      try {
        var url = Uri.parse('$apiUrl/navaccess/$id');
        final cookie = await UserRepository().getCookie();
        await http
            .delete(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookie.toString(),
          },
          body: jsonEncode({"navaccessId": id}),
        )
            .then((value) async {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
          }
        });
      } catch (e) {
        error = e.toString();
      }
    }

    return error;
  }
  Future<String?> checkOnValidCode(String code) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      error = "Немає підключення до інтернету";
    } else {
      try {
        //var url = Uri.parse('$apiUrl/medicine');
        //final cookie = await getCookie();
        //String date = medicineModel.startDate!.toUtc().toString();
        //Map<String, dynamic> map = medicineModel.toJson();
        //map["startDate"] = date;
        //await http
        //    .post(
        //  url,
        //  headers: <String, String>{
        //    'Content-Type': 'application/json',
        //    'Cookie': cookie.toString(),
        //  },
        //  body: jsonEncode(map),
        //)
        //    .then((value) async {
        //  if (!(value.statusCode > 199 && value.statusCode < 300)) {
        //    error = jsonDecode(value.body)["message"]
        //        .toString()
        //        .replaceAll("[", "")
        //        .replaceAll("]", "");
        //  } else {
        //    await await addMedicine(medicineModel).whenComplete(() async {
        //      await setIsSentInLocalMedicine(true,
        //          medicineModel: medicineModel);
        //    });
        //  }
        //});
      } catch (e) {
        error = e.toString();
      }
    }

    return error;
  }
}