import 'dart:convert';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/hive_crum.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class MedicineRepository {
  Future<List<MedicineModel>> updateLocalMedicines({bool? forcePush}) async {
    List<MedicineModel> medicines = [];

    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      medicines = List.from(HiveCRUM()
          .myMedicines
          .where((element) => element.isRemoved == false));
    } else {
      if ((forcePush != null && forcePush) || !checkIsAnyMedicinesNotSent()) {
        await loadMedicines().then((value) async {
          await HiveCRUM().clearMedicines().whenComplete(() {
            medicines = value;

            for (var medicine in medicines) {
              HiveCRUM().addMedicine(medicine);
            }
          });
        });
      }
    }
    return medicines;
  }

  Future<List<MedicineModel>> loadMedicines() async {
    List<MedicineModel> medicines = [];
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
    } else {
      try {
        var url = Uri.parse('$apiUrl/medicine');
        final cookie = await UserRepository().getCookie();
        await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookie.toString(),
          },
        ).then((value) {
          if (value.statusCode > 199 && value.statusCode < 300) {
            List<dynamic> list = jsonDecode(value.body);

            for (int i = 0; i < list.length; i++) {
              MedicineModel medicine = MedicineModel.fromJson(list[i]);
              medicine = medicine.copyWith(isSentToDB: true);
              medicines.add(medicine);
            }
          } else {
            String error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
            Fluttertoast.showToast(msg: error, toastLength: Toast.LENGTH_LONG);
          }
        });
      } catch (error) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return medicines;
  }

  Future<String?> saveMedicine(MedicineModel medicineModel) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      error = "Немає підключення до інтернету";
      await HiveCRUM().addMedicine(medicineModel);
    } else {
      try {
        var url = Uri.parse('$apiUrl/medicine');
        final cookie = await UserRepository().getCookie();
        String date = medicineModel.startDate.toUtc().toString();
        Map<String, dynamic> map = medicineModel.toJson();
        map["startDate"] = date;
        await http
            .post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookie.toString(),
          },
          body: jsonEncode(map),
        )
            .then((value) async {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
          } else {
            await await HiveCRUM()
                .addMedicine(medicineModel)
                .whenComplete(() async {
              await HiveCRUM()
                  .setIsSentInLocalMedicine(true, medicineModel: medicineModel);
            });
          }
        });
      } catch (e) {
        error = error.toString();
      }
    }
    if (error != null) {
      Fluttertoast.showToast(msg: error!, toastLength: Toast.LENGTH_LONG);
    }
    return error;
  }

  Future<String?> updateMedicine(MedicineModel medicineModel) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      //Fluttertoast.showToast(
      //    msg: "Немає підключення до інтернету",
      //    toastLength: Toast.LENGTH_LONG);
      //error = "Немає підключення до інтернету";
      await HiveCRUM().updateLocalMedicine(medicineModel);
    } else {
      try {
        var url = Uri.parse('$apiUrl/medicine/${medicineModel.id}');
        final cookie = await UserRepository().getCookie();
        String? newDate = medicineModel.startDate.toUtc().toString();
        Map<String, dynamic> map = medicineModel.toJson();
        map["startDate"] = newDate;
        await http
            .patch(url,
                headers: <String, String>{
                  'Content-Type': 'application/json',
                  'Cookie': cookie.toString(),
                },
                body: jsonEncode(map))
            .then((value) async {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
            Fluttertoast.showToast(msg: error!, toastLength: Toast.LENGTH_LONG);
          } else {
            await HiveCRUM()
                .setIsSentInLocalMedicine(medicineModel: medicineModel, true);
          }
        });
      } catch (error) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return error;
  }

  Future<String?> removeMedicine(String medicineId) async {
    String? error;
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      //Fluttertoast.showToast(
      //    msg: "Немає підключення до інтернету",
      //    toastLength: Toast.LENGTH_LONG);
      //error = "Немає підключення до інтернету";
      HiveCRUM().removeLocalMedicine(medicineId);
    } else {
      try {
        var url = Uri.parse('$apiUrl/medicine/$medicineId');
        final cookie = await UserRepository().getCookie();
        await http.delete(url, headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': cookie.toString(),
        }).then((value) {
          if (!(value.statusCode > 199 && value.statusCode < 300)) {
            error = jsonDecode(value.body)["message"]
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
            Fluttertoast.showToast(msg: error!, toastLength: Toast.LENGTH_LONG);
          }
        });
      } catch (error) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return error;
  }

  bool checkIsAnyMedicinesNotSent() {
    List<MedicineModel> myTasks = List.from(HiveCRUM().myMedicines);
    return myTasks.isNotEmpty
        ? myTasks.any((element) => element.isSentToDB == false)
        : false;
  }
}
