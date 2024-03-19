import 'dart:convert';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/hive_crud.dart';
import 'package:chance_app/ux/model/product_model.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ItemsRepository {
  Future<List<ProductModel>> getItems() async {
    List<ProductModel> items = [];
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
    } else {
      try {
        var url = Uri.parse('$apiUrl/product');
        final cookie = await UserRepository().getCookie();
        await http.get(url, headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': cookie.toString(),
        }).then((value) {
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
              items.add(ProductModel.fromJson(list[i]));
            }
          }
        });
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
    return items;
  }

  Future rewriteItems(List<ProductModel> newItems) async {
    List<ProductModel> dbItems = await getItems();
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
    } else {
      try {
        for (int i = 0; i < newItems.length; i++) {
          if (dbItems.any((element) => element.id != newItems[i].id)) {
            ///Add this item
            var url = Uri.parse('$apiUrl/product');
            final cookie = await UserRepository().getCookie();
            await http
                .post(url,
                    headers: <String, String>{
                      'Content-Type': 'application/json',
                      'Cookie': cookie.toString(),
                    },
                    body: jsonEncode(dbItems[i].toJson()))
                .then((value) {
              if (!(value.statusCode > 199 && value.statusCode < 300)) {
                Fluttertoast.showToast(
                    msg: jsonDecode(value.body)["message"]
                        .toString()
                        .replaceAll("[", "")
                        .replaceAll("]", ""),
                    toastLength: Toast.LENGTH_LONG);
              }
            });
          }
        }
        for (int i = 0; i < dbItems.length; i++) {
          if (newItems.any((element) => element.id != dbItems[i].id)) {
            /// Delete this item
            var url = Uri.parse('$apiUrl/product/${dbItems[i].id}');
            final cookie = await UserRepository().getCookie();
            await http.delete(url, headers: <String, String>{
              'Content-Type': 'application/json',
              'Cookie': cookie.toString(),
            }).then((value) {
              if (!(value.statusCode > 199 && value.statusCode < 300)) {
                Fluttertoast.showToast(
                    msg: jsonDecode(value.body)["message"]
                        .toString()
                        .replaceAll("[", "")
                        .replaceAll("]", ""),
                    toastLength: Toast.LENGTH_LONG);
              }
            });
          }
        }
        await HiveCRUD().rewriteItems(newItems);
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
  }
}
