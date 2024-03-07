import 'package:chance_app/ux/hive_crum.dart';
import 'package:chance_app/ux/model/product_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemsRepository {
  Future<List<ProductModel>> getItems() async {
    List<ProductModel> items = [];
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Немає підключення до інтернету",
          toastLength: Toast.LENGTH_LONG);
    } else {
      try {} catch (e) {
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
          }
        }
        for (int i = 0; i < dbItems.length; i++) {
          if (newItems.any((element) => element.id != dbItems[i].id)) {
            /// Delete this item
          }
        }
        await HiveCRUM().rewriteItems(newItems);
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
  }
}
